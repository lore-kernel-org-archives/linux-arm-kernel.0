From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Wed, 17 Sep 2014 21:49:17 +0530
Subject: [PATCH 7/9] phy: remove .owner field for drivers using
 module_platform_driver
In-Reply-To: <1408106416-19044-8-git-send-email-peter.griffin@linaro.org>
References: <1408106416-19044-1-git-send-email-peter.griffin@linaro.org>
 <1408106416-19044-8-git-send-email-peter.griffin@linaro.org>
Message-ID: <5419B485.8010002@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Friday 15 August 2014 06:10 PM, Peter Griffin wrote:
> This patch removes the superflous .owner field for drivers which
> use the module_platform_driver or platform_driver_register api,
> as this is overriden in __platform_driver_register.
> 
> Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
> ---
>  drivers/phy/phy-bcm-kona-usb2.c     | 1 -
>  drivers/phy/phy-berlin-sata.c       | 1 -
>  drivers/phy/phy-exynos-dp-video.c   | 1 -
>  drivers/phy/phy-exynos-mipi-video.c | 1 -
>  drivers/phy/phy-exynos5-usbdrd.c    | 1 -
>  drivers/phy/phy-exynos5250-sata.c   | 1 -
>  drivers/phy/phy-hix5hd2-sata.c      | 1 -
>  drivers/phy/phy-miphy365x.c         | 1 -
>  drivers/phy/phy-mvebu-sata.c        | 1 -
>  drivers/phy/phy-omap-control.c      | 1 -
>  drivers/phy/phy-omap-usb2.c         | 1 -
>  drivers/phy/phy-qcom-apq8064-sata.c | 1 -
>  drivers/phy/phy-qcom-ipq806x-sata.c | 1 -
>  drivers/phy/phy-samsung-usb2.c      | 1 -
>  drivers/phy/phy-sun4i-usb.c         | 1 -
>  drivers/phy/phy-ti-pipe3.c          | 1 -
>  drivers/phy/phy-twl4030-usb.c       | 1 -

twl4030-usb doesn't use module_platform_driver. Care to resend this patch
along? I've merged all other patches in this series.

Cheers
Kishon
