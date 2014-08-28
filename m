From: dforsi@gmail.com (Daniele Forsi)
Date: Thu, 28 Aug 2014 17:06:58 +0200
Subject: [PATCH 5/5] phy: exynos5-usbdrd: Adding Kconfig dependency for
 Exynos7
In-Reply-To: <1409212920-28526-6-git-send-email-gautam.vivek@samsung.com>
References: <1409212920-28526-1-git-send-email-gautam.vivek@samsung.com>
 <1409212920-28526-6-git-send-email-gautam.vivek@samsung.com>
Message-ID: <CAN_we7MQAqEsRaQc_pkRE_KXx9zZNLDBR2aHUrazM30Nv3udmQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2014-08-28 10:02 GMT+02:00 Vivek Gautam:

> This USB 3.0 PHY controller is also present on Exynos7
> platform, so adding the dependency on ARCH_EXYNOS7 for this driver.

> +++ b/drivers/phy/Kconfig
> @@ -186,7 +186,7 @@ config PHY_EXYNOS5250_USB2
>
>  config PHY_EXYNOS5_USBDRD
>         tristate "Exynos5 SoC series USB DRD PHY driver"
> -       depends on ARCH_EXYNOS5 && OF
> +       depends on (ARCH_EXYNOS5 || ARCH_EXYNOS7) && OF

shouldn't that prompt and its help text be updated to mention also Exynos7?

-- 
Daniele Forsi
