From: linux@rempel-privat.de (Oleksij Rempel)
Date: Mon, 27 Oct 2014 14:37:04 +0100
Subject: [PATCH 1/2] ARM: add mach-asm9260
In-Reply-To: <1414416960-10705-1-git-send-email-linux@rempel-privat.de>
References: <544E4611.8070802@cogentembedded.com>
 <1414416960-10705-1-git-send-email-linux@rempel-privat.de>
Message-ID: <544E4A80.1060303@rempel-privat.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

grr... ignore it.

Am 27.10.2014 um 14:36 schrieb Oleksij Rempel:
> it is low cost (?) SoC targeted for market in China and India which
> trying to compete with AT91SAM9G25.
> 
> Here is some info:
> http://www.alphascale.com/index.asp?ics/615.html
> 
> One of products:
> http://www.aliexpress.com/store/product/2014-hot-sales-FREE-SHIPPING-new-Purple-core-ARM9-development-board-ASM9260T-SDRAM-power-line/433637_1931495721.html
> 
> In some cases this SoC looks similar to iMX23/iMX28. But currently it makes no
> sense to merge mach code of this devices. Especially because most differences
> are already collected mach-mxs folder.
> 
> Signed-off-by: Oleksij Rempel <linux@rempel-privat.de>
> ---
>  arch/arm/Kconfig              | 2 ++
>  arch/arm/mach-asm9260/Kconfig | 6 ++++++
>  2 files changed, 8 insertions(+)
>  create mode 100644 arch/arm/mach-asm9260/Kconfig
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 5918d40..1b32023 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -849,6 +849,8 @@ config ARCH_VIRT
>  #
>  source "arch/arm/mach-mvebu/Kconfig"
>  
> +source "arch/arm/mach-asm9260/Kconfig"
> +
>  source "arch/arm/mach-at91/Kconfig"
>  
>  source "arch/arm/mach-axxia/Kconfig"
> diff --git a/arch/arm/mach-asm9260/Kconfig b/arch/arm/mach-asm9260/Kconfig
> new file mode 100644
> index 0000000..33b9b28
> --- /dev/null
> +++ b/arch/arm/mach-asm9260/Kconfig
> @@ -0,0 +1,6 @@
> +config MACH_ASM9260
> +	bool "Alphascale ASM9260"
> +	depends on ARCH_MULTI_V5
> +	select CPU_ARM926T
> +	help
> +	  Support for Alpascale ASM9260 based platform.
> 


-- 
Regards,
Oleksij

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 213 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141027/c0ee05df/attachment.sig>
