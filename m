From: shc_work@mail.ru (=?UTF-8?B?QWxleGFuZGVyIFNoaXlhbg==?=)
Date: Mon, 06 Jan 2014 00:37:50 +0400
Subject: =?UTF-8?B?UmU6IFtQQVRDSCB2NCAxLzRdIEFSTTogQkNNNTMwMVg6IGluaXRpYWwgc3Vw?=
 =?UTF-8?B?cG9ydCBmb3IgdGhlIEJDTTUzMDFYL0JDTTQ3MFggU29DcyB3aXRoIEFSTSBD?=
 =?UTF-8?B?UFU=?=
In-Reply-To: <1388944697-19927-2-git-send-email-hauke@hauke-m.de>
References: <1388944697-19927-1-git-send-email-hauke@hauke-m.de>
 <1388944697-19927-2-git-send-email-hauke@hauke-m.de>
Message-ID: <1388954270.224601777@f339.i.mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> This patch adds support for the BCM5301X/BCM470X SoCs with an ARM CPUs.
> Currently just booting to a shell is working and nothing else, no
> Ethernet, wifi, flash, ...
> I have some pending patches to make Ethernet work for this device.
> Mostly device tree support for bcma is missing.
...
> diff --git a/arch/arm/mach-bcm/Kconfig b/arch/arm/mach-bcm/Kconfig
> index 9fe6d88..e47f9de 100644
> --- a/arch/arm/mach-bcm/Kconfig
> +++ b/arch/arm/mach-bcm/Kconfig
> @@ -31,6 +31,33 @@ config ARCH_BCM_MOBILE
>  	  BCM11130, BCM11140, BCM11351, BCM28145 and
>  	  BCM28155 variants.
>  
> +config ARCH_BCM_5301X
> +	bool "Broadcom BCM470X / BCM5301X ARM SoC" if ARCH_MULTI_V7
> +	depends on MMU
> +	select ARM_GIC
> +	select CACHE_L2X0
> +	select HAVE_ARM_SCU if SMP
> +	select HAVE_ARM_TWD if SMP
> +	select HAVE_SMP
> +	select COMMON_CLK
> +	select GENERIC_CLOCKEVENTS
> +	select GENERIC_TIME

GENERIC_TIME is a dead symbol.

---
