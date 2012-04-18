From: B29397@freescale.com (Chen Peter-B29397)
Date: Wed, 18 Apr 2012 07:52:25 +0000
Subject: [RFC PATCH 00/10 V2]  MXS: Add i.MX28 USB Host driver
In-Reply-To: <1334714869-19282-1-git-send-email-marex@denx.de>
References: <1334657751-27678-1-git-send-email-marex@denx.de>
 <1334714869-19282-1-git-send-email-marex@denx.de>
Message-ID: <F281D0F91ED19E4D8E63A7504E8A649803B76759@039-SN2MPN1-023.039d.mgd.msft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


 
> This patchset introduces the USB Host driver for i.MX28 CPU, utilising
> the
> generic USB PHY infrastructure.
> 
> V2: Introduce stub imx-usb driver that then registers the PHY and EHCI
> drivers.
> 

- Currently, there is no generic PHY layer, so only one host/device can be supported.

- Now, the PHY and OTG is separated, it is better to put PHY driver to
drivers/usb/phy/

- mx23, mx28, mx6q uses the same PHY (FSL PHY), it is better to use the phy driver name
as imx-phy.c.

> Marek Vasut (10):
>   MXS: Make clk_disable return integer
>   MXS: Add USB EHCI and USB PHY clock handling
>   MXS: Fixup i.MX233 USB base address name
>   MXS: Add data shared between imx-usb, PHY and EHCI driver
>   MXS: Add platform registration hooks for USB EHCI
>   MXS: Add composite imx-usb driver
>   MXS: Add USB PHY driver
>   MXS: Add separate MXS EHCI HCD driver
>   MXS: Enable USB on M28EVK
>   MXS: Enable USB on MX28EVK
> 
>  arch/arm/mach-mxs/Kconfig                       |    4 +
>  arch/arm/mach-mxs/clock-mx28.c                  |   28 ++-
>  arch/arm/mach-mxs/devices-mx28.h                |    4 +
>  arch/arm/mach-mxs/devices/Kconfig               |    3 +
>  arch/arm/mach-mxs/devices/Makefile              |    1 +
>  arch/arm/mach-mxs/devices/platform-usb.c        |   67 +++++
>  arch/arm/mach-mxs/include/mach/clock.h          |    2 +-
>  arch/arm/mach-mxs/include/mach/devices-common.h |    9 +
>  arch/arm/mach-mxs/include/mach/mx23.h           |    8 +-
>  arch/arm/mach-mxs/mach-m28evk.c                 |    9 +
>  arch/arm/mach-mxs/mach-mx28evk.c                |   10 +
>  drivers/usb/host/Kconfig                        |    7 +
>  drivers/usb/host/ehci-hcd.c                     |    5 +
>  drivers/usb/host/ehci-mxs.c                     |  254
> +++++++++++++++++++
>  drivers/usb/otg/Kconfig                         |   16 ++
>  drivers/usb/otg/Makefile                        |    2 +
>  drivers/usb/otg/imx-usb.c                       |  303
> +++++++++++++++++++++++
>  drivers/usb/otg/mxs-phy.c                       |  201 +++++++++++++++
>  include/linux/fsl_devices.h                     |   15 ++
>  19 files changed, 939 insertions(+), 9 deletions(-)
>  create mode 100644 arch/arm/mach-mxs/devices/platform-usb.c
>  create mode 100644 drivers/usb/host/ehci-mxs.c
>  create mode 100644 drivers/usb/otg/imx-usb.c
>  create mode 100644 drivers/usb/otg/mxs-phy.c
> 
> Cc: Chen Peter-B29397 <B29397@freescale.com>
> Cc: Detlev Zundel <dzu@denx.de>
> Cc: Fabio Estevam <festevam@gmail.com>
> Cc: Li Frank-B20596 <B20596@freescale.com>
> Cc: Lin Tony-B19295 <B19295@freescale.com>
> Cc: Linux USB <linux-usb@vger.kernel.org>
> Cc: Sascha Hauer <s.hauer@pengutronix.de>
> Cc: Shawn Guo <shawn.guo@freescale.com>
> Cc: Shawn Guo <shawn.guo@linaro.org>
> Cc: Stefano Babic <sbabic@denx.de>
> Cc: Subodh Nijsure <snijsure@grid-net.com>
> Cc: Tony Lin <tony.lin@freescale.com>
> Cc: Wolfgang Denk <wd@denx.de>
> --
> 1.7.9.5
> 
