From: peter.chen@freescale.com (Peter Chen)
Date: Wed, 28 Nov 2012 10:52:18 +0800
Subject: [PATCH v4 0/6] support other fsl SoCs with usbmisc + small fixes
In-Reply-To: <1354033021-10585-1-git-send-email-m.grzeschik@pengutronix.de>
References: <1354033021-10585-1-git-send-email-m.grzeschik@pengutronix.de>
Message-ID: <20121128025217.GC18593@nchen-desktop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 27, 2012 at 05:16:55PM +0100, Michael Grzeschik wrote:
> Nearly every SoC from Freescale has this non-core usb registers. This series
> adds support for more users of this driver.
> 
> This series is based on Peter Chen's work. Its needed to merge his master branch
> before applying this series:
> 
> https://github.com/hzpeterchen/linux-usb.git

I have tested it at i.mx6q sabrelite board, it works good.

I have pushed your commit to my git, please cc me
your coming chipidea patches, thanks.

Alex, please add:

Reviewed-by: Peter Chen <peter.chen@freescale.com>
Tested-by: Peter Chen <peter.chen@freescale.com>


> 
> Changes since v3:
> * removed [PATCH v3 5/7] usb: chipidea: usbmisc: add support for ahb, ipg and per clock
> 
> 
> Marc Kleine-Budde (3):
>   usb: chipidea: usbmisc: unset global varibale usbmisc on driver remove
>   usb: chipidea: usbmisc: fix a potential race condition
>   usb: chipidea: usbmisc: prepare driver to handle more than one soc
> 
> Michael Grzeschik (3):
>   usb: chipidea: usbmisc: rename file, struct and functions to usbmisc_imx
>   usb: chipidea: usbmisc: add mx53 support
>   usb: chipidea: usbmisc: add post handling and errata fix for mx25
> 
>  .../devicetree/bindings/usb/ci13xxx-imx.txt        |    2 +
>  drivers/usb/chipidea/Makefile                      |    2 +-
>  drivers/usb/chipidea/ci13xxx_imx.c                 |   12 +
>  drivers/usb/chipidea/ci13xxx_imx.h                 |    3 +
>  drivers/usb/chipidea/usbmisc_imx.c                 |  252 ++++++++++++++++++++
>  drivers/usb/chipidea/usbmisc_imx6q.c               |  162 -------------
>  6 files changed, 270 insertions(+), 163 deletions(-)
>  create mode 100644 drivers/usb/chipidea/usbmisc_imx.c
>  delete mode 100644 drivers/usb/chipidea/usbmisc_imx6q.c
> 
> -- 
> 1.7.10.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-usb" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

-- 

Best Regards,
Peter Chen
