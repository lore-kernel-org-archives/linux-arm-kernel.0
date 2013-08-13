From: Dave.Martin@arm.com (Dave Martin)
Date: Tue, 13 Aug 2013 14:18:59 +0100
Subject: [PATCH 16/16] Add config EFI_STUB for ARM to Kconfig
In-Reply-To: <1376090777-20090-17-git-send-email-roy.franz@linaro.org>
References: <1376090777-20090-1-git-send-email-roy.franz@linaro.org>
 <1376090777-20090-17-git-send-email-roy.franz@linaro.org>
Message-ID: <20130813131857.GE2823@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 09, 2013 at 04:26:17PM -0700, Roy Franz wrote:
> Signed-off-by: Roy Franz <roy.franz@linaro.org>
> ---
>  arch/arm/Kconfig |   11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 43594d5..8607d03 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -1805,6 +1805,17 @@ config UACCESS_WITH_MEMCPY
>  	  However, if the CPU data cache is using a write-allocate mode,
>  	  this option is unlikely to provide any performance gain.
>  
> +config EFI_STUB
> +	bool "EFI stub support"
> +	depends on EFI

&& !CPU_BIG_ENDIAN, in case you didn't get around to that.

Sooner or later, someone may try to fix that, so there should be a
comment somewhere explaining what is broken for BE.

Either in efi-stub.c or in the commit message accompanying this patch, I
guess.

Cheers
---Dave

> +	---help---
> +	  This kernel feature allows a zImage to be loaded directly
> +	  by EFI firmware without the use of a bootloader.  A PE/COFF
> +	  header is added to the zImage in a way that makes the binary
> +	  both a Linux zImage and an PE/COFF executable that can be
> +	  executed directly by EFI firmware.
> +	  See Documentation/efi-stub.txt for more information.
> +
>  config SECCOMP
>  	bool
>  	prompt "Enable seccomp to safely compute untrusted bytecode"
> -- 
> 1.7.10.4
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
