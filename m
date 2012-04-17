From: dirk.behme@de.bosch.com (Dirk Behme)
Date: Tue, 17 Apr 2012 12:37:47 +0200
Subject: [RFC PATCH 0/8] MXS: Add i.MX28 USB Host driver
In-Reply-To: <1334657751-27678-1-git-send-email-marex@denx.de>
References: <1334657751-27678-1-git-send-email-marex@denx.de>
Message-ID: <4F8D47FB.4050205@de.bosch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marek,

On 17.04.2012 12:15, Marek Vasut wrote:
> This patchset introduces the USB Host driver for i.MX28 CPU, utilising the
> generic USB PHY infrastructure.

Great, many thanks!

Unfortunately, I lost the overview over the i.MXxx USB discussion ;)

Could this be used to add support for the mx53 and mx6, too? If yes, 
what do you think would be needed for this?

Best regards

Dirk

P.S.: What I read from the discussion:

-- cut --
All recent Freescale SoC's USB controller are the same, they are mx23, 
mx25, mx28, mx31, mx35, mx37, mx50, mx51, mx53, and mx6. But, the 
transceiver is different between them
* mx23, mx28, mx6 (Transceiver A)
* mx25 mx31, mx35,mx37, mx50, mx51, mx53 (Transceiver B)
-- cut --

> Marek Vasut (8):
>   MXS: Make clk_disable return integer
>   MXS: Add USB EHCI and USB PHY clock handling
>   MXS: Fixup i.MX233 USB base address name
>   MXS: Add platform registration hooks for USB EHCI
>   MXS: Add USB PHY driver
>   MXS: Add separate MXS EHCI HCD driver
>   MXS: Enable USB on M28EVK
>   MXS: Enable USB on MX28EVK
> 
>  arch/arm/mach-mxs/Kconfig                       |    4 +
>  arch/arm/mach-mxs/clock-mx28.c                  |   28 +-
>  arch/arm/mach-mxs/devices-mx28.h                |    4 +
>  arch/arm/mach-mxs/devices/Kconfig               |    3 +
>  arch/arm/mach-mxs/devices/Makefile              |    1 +
>  arch/arm/mach-mxs/devices/platform-usb.c        |   79 ++++++
>  arch/arm/mach-mxs/include/mach/clock.h          |    2 +-
>  arch/arm/mach-mxs/include/mach/devices-common.h |    9 +
>  arch/arm/mach-mxs/include/mach/mx23.h           |    8 +-
>  arch/arm/mach-mxs/mach-m28evk.c                 |   10 +
>  arch/arm/mach-mxs/mach-mx28evk.c                |   10 +
>  drivers/usb/host/Kconfig                        |    7 +
>  drivers/usb/host/ehci-hcd.c                     |    5 +
>  drivers/usb/host/ehci-mxs.c                     |  309 +++++++++++++++++++++++
>  drivers/usb/otg/Kconfig                         |    9 +
>  drivers/usb/otg/Makefile                        |    1 +
>  drivers/usb/otg/mxs-phy.c                       |  256 +++++++++++++++++++
>  17 files changed, 736 insertions(+), 9 deletions(-)
>  create mode 100644 arch/arm/mach-mxs/devices/platform-usb.c
>  create mode 100644 drivers/usb/host/ehci-mxs.c
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
