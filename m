From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Fri, 10 Dec 2010 11:18:00 +0530
Subject: [PATCH 2/2] ARM: Make CONFIG_FPE_NWFPE depend on
	!CONFIG_THUMB2_KERNEL
In-Reply-To: <1291895982-4775-3-git-send-email-dave.martin@linaro.org>
References: <1291895982-4775-1-git-send-email-dave.martin@linaro.org>
	<1291895982-4775-3-git-send-email-dave.martin@linaro.org>
Message-ID: <07daf23764a279fb2f61f1666d1de74a@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Dave Martin [mailto:dave.martin at linaro.org]
> Sent: Thursday, December 09, 2010 5:30 PM
> To: linux-arm-kernel at lists.infradead.org
> Cc: Dave Martin; Santosh Shilimkar; linux-omap at vger.kernel.org
> Subject: [PATCH 2/2] ARM: Make CONFIG_FPE_NWFPE depend
> on !CONFIG_THUMB2_KERNEL
>
> Because the nwfpe support is unlikely to be used on new platforms
> and requires CONFIG_OABI_COMPAT, which is not generally used with
> ARMv7+, we shouldn't expect to build nwfpe support into a Thumb-2
> kernel.
>
> At present, nwfpe contains assembly code which isn't Thumb-2
> compatible, and for now it doesn't appear useful to port this
> code.
>
> All ARMv7-A/R platforms necessarily have VFPv3 hardware floating-
> point natively, making emulation unnecessary.
>
> Signed-off-by: Dave Martin <dave.martin@linaro.org>
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>
If you like.
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> ---
>  arch/arm/Kconfig |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index f9ca7f3..7e825c3 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -1759,7 +1759,7 @@ comment "At least one emulation must be selected"
>
>  config FPE_NWFPE
>  	bool "NWFPE math emulation"
> -	depends on !AEABI || OABI_COMPAT
> +	depends on (!AEABI || OABI_COMPAT) && !THUMB2_KERNEL
>  	---help---
>  	  Say Y to include the NWFPE floating point emulator in the
kernel.
>  	  This is necessary to run most binaries. Linux does not currently
> --
> 1.7.1
