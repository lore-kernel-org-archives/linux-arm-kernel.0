From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 07 Aug 2012 19:00:04 +0900
Subject: [PATCH v2 0/5] usb: phy: samsung: Introducing usb phy driver for
 samsung SoCs
In-Reply-To: <1344324524-2286-1-git-send-email-p.paneri@samsung.com>
References: <1344324524-2286-1-git-send-email-p.paneri@samsung.com>
Message-ID: <098c01cd7483$6a93eeb0$3fbbcc10$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Praveen Paneri wrote:
> 
> Changes from v1:
> Rebased patches to latest usb-next branch
> Changed the name 'sec_usbphy' to 'samsung_usbphy'
> 
Yes, looks better. But I'm not sure Felipe or Greg would prefer to use '_'
not '-'...you used samsung-usbphy as a name in your patch.

> This patch set introduces a phy driver for samsung SoCs. It uses the
> existing
> transceiver infrastructure to provide phy control functions. Use of this
> driver
> can be extended for usb host phy as well. Over the period of time all the
> phy
> related code for most of the samsung SoCs can be integrated here.
> Removing the existing phy code from mach-s3c64xx but not from other
> machine

Why? Is there any reason? After quick looking at your patches, seems this
can remove all of setup-usb-phy in arch/arm/ for Samsung stuff. In addition,
the isolation hook function also can be put in this by using platform_data
or dt parsing.

> code.This driver is tested with smdk6410 and Exynos4210(with DT).
> 
I and my colleague, Yulgon will comment on this series soon.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.


> Praveen Paneri (5):
>   usb: phy: samsung: Introducing usb phy driver for hsotg
>   usb: s3c-hsotg: Adding phy driver support
>   ARM: S3C64XX: Removing old phy setup code
>   ARM: S3C64XX: Enabling samsung_usbphy driver
>   ARM: Exynos4210: Enabling samsung_usbphy driver
> 
>  .../devicetree/bindings/usb/samsung-usbphy.txt     |    9 +
>  arch/arm/boot/dts/exynos4210.dtsi                  |    5 +
>  arch/arm/mach-exynos/include/mach/map.h            |    1 +
>  arch/arm/mach-exynos/mach-exynos4-dt.c             |    8 +
>  arch/arm/mach-exynos/setup-usb-phy.c               |   13 +
>  arch/arm/mach-s3c64xx/include/mach/map.h           |    2 +
>  arch/arm/mach-s3c64xx/mach-crag6410.c              |    5 +-
>  arch/arm/mach-s3c64xx/mach-smartq.c                |    6 +-
>  arch/arm/mach-s3c64xx/mach-smdk6410.c              |    5 +-
>  arch/arm/mach-s3c64xx/setup-usb-phy.c              |   79 +----
>  arch/arm/plat-samsung/devs.c                       |   32 ++
>  arch/arm/plat-samsung/include/plat/devs.h          |    1 +
>  arch/arm/plat-samsung/include/plat/usb-phy.h       |    1 +
>  drivers/usb/gadget/s3c-hsotg.c                     |   38 ++-
>  drivers/usb/phy/Kconfig                            |    8 +
>  drivers/usb/phy/Makefile                           |    1 +
>  drivers/usb/phy/samsung_usbphy.c                   |  355
++++++++++++++++++++
>  drivers/usb/phy/samsung_usbphy.h                   |   48 +++
>  include/linux/platform_data/s3c-hsotg.h            |    5 +
>  19 files changed, 534 insertions(+), 88 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/usb/samsung-
> usbphy.txt
>  create mode 100644 drivers/usb/phy/samsung_usbphy.c
>  create mode 100644 drivers/usb/phy/samsung_usbphy.h
