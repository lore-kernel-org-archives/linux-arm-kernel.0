From: shc_work@mail.ru (=?UTF-8?B?QWxleGFuZGVyIFNoaXlhbg==?=)
Date: Mon, 19 May 2014 11:06:35 +0400
Subject: =?UTF-8?B?UmU6IFtQQVRDSCAxLzRdIEFSTTogaW14OiBtb3ZlIFNPQ19JTVg1IGFuZCBT?=
 =?UTF-8?B?T0NfSU1YNTEgaW50byAnRGV2aWNlIHRyZWUgb25seSc=?=
In-Reply-To: <1400482606-8278-2-git-send-email-shawn.guo@freescale.com>
References: <1400482606-8278-1-git-send-email-shawn.guo@freescale.com>
 <1400482606-8278-2-git-send-email-shawn.guo@freescale.com>
Message-ID: <1400483195.557817536@f437.i.mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mon, 19 May 2014 14:56:43 +0800 ?? Shawn Guo <shawn.guo@freescale.com>:
> After moving SOC_IMX51 support over to device tree, all i.MX5 support
> becomes device tree only now.  So options SOC_IMX5 and SOC_IMX51 can
> just be under 'Device tree only'.
> 
> Signed-off-by: Shawn Guo <shawn.guo@freescale.com>
> ---
>  arch/arm/mach-imx/Kconfig | 26 +++++++++++++-------------
>  1 file changed, 13 insertions(+), 13 deletions(-)
> 
> diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
> index a6ee115..19c609e 100644
> --- a/arch/arm/mach-imx/Kconfig
> +++ b/arch/arm/mach-imx/Kconfig
> @@ -122,19 +122,6 @@ config SOC_IMX35
>  	select PINCTRL_IMX35
>  	select SMP_ON_UP if SMP
>  
> -config SOC_IMX5
> -	bool
> -	select ARCH_HAS_CPUFREQ
> -	select ARCH_HAS_OPP
> -	select ARCH_MXC_IOMUX_V3
> -	select HAVE_IMX_SRC
> -	select MXC_TZIC
> -
> -config	SOC_IMX51
> -	bool
> -	select PINCTRL_IMX51
> -	select SOC_IMX5
> -
>  if ARCH_MULTI_V4T
>  
>  comment "MX1 platforms:"
> @@ -704,6 +691,19 @@ if ARCH_MULTI_V7
>  
>  comment "Device tree only"
>  
> +config SOC_IMX5
> +	bool
> +	select ARCH_HAS_CPUFREQ
> +	select ARCH_HAS_OPP
> +	select ARCH_MXC_IOMUX_V3

We can drop ARCH_MXC_IOMUX_V3 now.

---
