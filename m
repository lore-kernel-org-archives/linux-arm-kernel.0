From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 23 Mar 2018 17:12:34 +0000
Subject: [PATCH] arm64/sve: Document firmware support requirements in
 Kconfig
In-Reply-To: <1521633289-10504-1-git-send-email-Dave.Martin@arm.com>
References: <1521633289-10504-1-git-send-email-Dave.Martin@arm.com>
Message-ID: <20180323171233.rmsm2mgxufgu52bz@armageddon.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 21, 2018 at 11:54:49AM +0000, Dave P Martin wrote:
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 7381eeb..e6fa47b 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -1104,6 +1104,23 @@ config ARM64_SVE
>  
>  	  To enable use of this extension on CPUs that implement it, say Y.
>  
> +	  Note that for architectural reasons, firmware _must_ implement SVE
> +	  support when running on SVE capable hardware.  The required support
> +	  is present in:
> +
> +	    * version 1.5 and later of the ARM Trusted Firmware
> +	    * the AArch64 boot wrapper since commit 5e1261e08abf
> +	      ("bootwrapper: SVE: Enable SVE for EL2 and below").
> +
> +	  For other firmware implementations, consult the firware documentation
> +	  or vendor.
> +
> +	  If you need the kernel to boot on SVE-capable hardware with broken
> +	  firmware, you may need to say N here until you get your firmware
> +	  fixed.  Otherwise, you may experience firmware panics or lockups when
> +	  booting the kernel.  If unsure and you are not observing these
> +	  symptoms, you should assume that it is safe to say Y.

It's a shame that we can't detect this architecturally but the
alternative would be to ask the firmware to describe the presence of SVE
via DT or ACPI (which I don't particularly like since it's a CPU feature
rather than an SoC one).

I'm personally fine with the warning in Kconfig.

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
