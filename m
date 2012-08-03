From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri, 3 Aug 2012 12:08:26 +0200
Subject: [PATCH v5 0/3] imx: add usbmisc support
In-Reply-To: <1343805141-5872-1-git-send-email-richard.zhao@freescale.com>
References: <1343805141-5872-1-git-send-email-richard.zhao@freescale.com>
Message-ID: <20120803100826.GL1451@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 01, 2012 at 03:12:18PM +0800, Richard Zhao wrote:
> usbmisc driver handles the SoC specific non-core usb registers.
> 
> Changes since last version:
>  - add missing ci13xxx_imx.h
> 
> Changes v3 -> v4:
>  - rebase onto torvalds latest git tree
>  - use phandle linke usb controllers and usbmisc device.
>    It also make usbmisc driver possible to be kernel modules.
> 
> Richard Zhao (3):
>   USB: chipidea: add imx usbmisc support
>   ARM: imx6q: clk_register_clkdev usbmisc clock
>   ARM: dts: imx6q-sabrelite: add usbmisc device

I think this is good enough to go now.

Acked-by: Sascha Hauer <s.hauer@pengutronix.de>


> 
>  .../devicetree/bindings/usb/ci13xxx-imx.txt        |    5 +
>  .../devicetree/bindings/usb/usbmisc-imx.txt        |   14 ++
>  arch/arm/boot/dts/imx6q-sabrelite.dts              |    1 +
>  arch/arm/boot/dts/imx6q.dtsi                       |   10 ++
>  arch/arm/mach-imx/clk-imx6q.c                      |    1 +
>  drivers/usb/chipidea/Makefile                      |    2 +-
>  drivers/usb/chipidea/ci13xxx_imx.c                 |   64 ++++++++
>  drivers/usb/chipidea/ci13xxx_imx.h                 |   28 ++++
>  drivers/usb/chipidea/usbmisc_imx6q.c               |  162 ++++++++++++++++++++
>  9 files changed, 286 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/devicetree/bindings/usb/usbmisc-imx.txt
>  create mode 100644 drivers/usb/chipidea/ci13xxx_imx.h
>  create mode 100644 drivers/usb/chipidea/usbmisc_imx6q.c
> 
> -- 
> 1.7.9.5
> 
> 
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
