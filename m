From: shc_work@mail.ru (=?UTF-8?B?QWxleGFuZGVyIFNoaXlhbg==?=)
Date: Mon, 18 Nov 2013 11:36:51 +0400
Subject: =?UTF-8?B?UmU6IFtQQVRDSF0gQVJNOmNscHM3MTF4OkVuYWJsZSBBUk1fUEFUQ0hfUEhZ?=
 =?UTF-8?B?U19WSVJUIGJ5IGRlZmF1bHQ=?=
In-Reply-To: <1384758970-20099-1-git-send-email-panchaxari.prasannamurthy@linaro.org>
References: <1384758970-20099-1-git-send-email-panchaxari.prasannamurthy@linaro.org>
Message-ID: <1384760211.959851268@f258.i.mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> ARM_PATCH_PHYS_VIRT is enabled by default for clps711x systems
> 
> Introduction of this config as default will enable phy-to-virt and
> virt-to-phy translation function at boot and module loading time
> and enforce dynamic reallocation of memory.
> 
> This config is mutually exclusive to XIP_KERNEL, which is used in
> systems with NOR flash devices
> 
> Requesting platform maintainers to evaluate  the changes on the
> board and comment on the changes, as I dont have the board for
> testing.
> 
> Signed-off-by: panchaxari <panchaxari.prasannamurthy@linaro.org>
> Cc: Linus Walleij <linux.walleij@linaro.org>
> Cc: Alexander Shiyan <shc_work@mail.ru>
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: Olof Johansson <olof@lixom.net>
> Cc: linux-arm-kernel at lists.infradead.org
> ---
>  arch/arm/Kconfig |    1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 1ad6fb6..dff1c81 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -372,6 +372,7 @@ config ARCH_CLPS711X
>  	bool "Cirrus Logic CLPS711x/EP721x/EP731x-based"
>  	select ARCH_REQUIRE_GPIOLIB
>  	select AUTO_ZRELADDR
> +	select ARM_PATCH_PHYS_VIRT
>  	select CLKDEV_LOOKUP
>  	select CLKSRC_MMIO
>  	select COMMON_CLK
> -- 

Should we keep sorting of symbols here?
Anyway, since this symbol in my config by default,

Tested-by: Alexander Shiyan <shc_work@mail.ru>

---
