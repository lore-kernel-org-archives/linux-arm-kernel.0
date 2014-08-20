From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Wed, 20 Aug 2014 20:33:42 +0530
Subject: [PATCH 0/9] phy: various misc cleanups to phy drivers
In-Reply-To: <1408106416-19044-1-git-send-email-peter.griffin@linaro.org>
References: <1408106416-19044-1-git-send-email-peter.griffin@linaro.org>
Message-ID: <53F4B8CE.50300@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Friday 15 August 2014 06:10 PM, Peter Griffin wrote:
> Hi,
> 
> This series some a few misc cleanups to the PHY drivers: -
> 
> 1) Use module_platform_driver to register spear PHY drivers. This gets rid
> of a lof of boiler plate code.
> 
> 2) Remove .owner field from drivers using module_platform_driver, as this gets
> overridden anyway in __platform_driver_register.
> 
> 3) Remove OOM site specific failure messages. These are unecessary and make
> the kernel bigger.
> 
> 4) Add missing kzalloc error check, which could avoid NULL ptr dereference.

Thanks for doing this clean-up.
But I can queue this only for 3.18 (since these are cleanups) after -rc4 is tagged.

Thanks
Kishon

> 
> regards,
> 
> Peter.
> 
> Peter Griffin (9):
>   phy: phy-omap-control: Remove unncessary site specific OOM messages
>   phy: phy-mvebu-sata: Add missing error check for devm_kzalloc
>   phy: phy-omap-usb2: Remove unncessary site specific OOM messages
>   phy: phy-ti-pipe3: Remove unncessary site specific OOM messages
>   phy: phy-spear1310-miphy: Remove unncessary site specific OOM messages
>   phy: phy-spear1340-miphy: Remove unncessary site specific OOM messages
>   phy: remove .owner field for drivers using module_platform_driver
>   phy: phy-spear1310-miphy: Use module_platform_driver to register
>     driver.
>   phy: phy-spear1340-miphy: Use module_platform_driver to register
>     driver.
> 
>  drivers/phy/phy-bcm-kona-usb2.c     |  1 -
>  drivers/phy/phy-berlin-sata.c       |  1 -
>  drivers/phy/phy-exynos-dp-video.c   |  1 -
>  drivers/phy/phy-exynos-mipi-video.c |  1 -
>  drivers/phy/phy-exynos5-usbdrd.c    |  1 -
>  drivers/phy/phy-exynos5250-sata.c   |  1 -
>  drivers/phy/phy-hix5hd2-sata.c      |  1 -
>  drivers/phy/phy-miphy365x.c         |  1 -
>  drivers/phy/phy-mvebu-sata.c        |  3 ++-
>  drivers/phy/phy-omap-control.c      |  5 +----
>  drivers/phy/phy-omap-usb2.c         |  9 ++-------
>  drivers/phy/phy-qcom-apq8064-sata.c |  1 -
>  drivers/phy/phy-qcom-ipq806x-sata.c |  1 -
>  drivers/phy/phy-samsung-usb2.c      |  1 -
>  drivers/phy/phy-spear1310-miphy.c   | 17 ++---------------
>  drivers/phy/phy-spear1340-miphy.c   | 17 ++---------------
>  drivers/phy/phy-sun4i-usb.c         |  1 -
>  drivers/phy/phy-ti-pipe3.c          |  6 ++----
>  drivers/phy/phy-twl4030-usb.c       |  1 -
>  drivers/phy/phy-xgene.c             |  1 -
>  20 files changed, 11 insertions(+), 60 deletions(-)
> 
