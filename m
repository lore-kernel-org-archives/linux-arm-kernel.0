From: jbe@pengutronix.de (Juergen Beisert)
Date: Thu, 10 May 2012 12:19:14 +0200
Subject: [RFC PATCH 00/11 V7] MXS: Add i.MX28 USB Host driver
In-Reply-To: <1335837363-12376-1-git-send-email-marex@denx.de>
References: <1335837363-12376-1-git-send-email-marex@denx.de>
Message-ID: <201205101219.14787.jbe@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marek,

Marek Vasut wrote:
> This patchset introduces the USB Host driver for i.MX28 CPU, utilising the
> generic USB PHY infrastructure. Also added is glue code for CI13xxx driver,
> to allow device mode. This patchset still does NOT support OTG mode, the
> device/host mode is selected via platform data.

When using your patch set with my 3.4-rc6 I get:

After enabling 'CONFIG_USB_EHCI_MXS':

drivers/usb/host/ehci-mxs.c:171: undefined reference to 
`imx_otg_set_irq_handler'

After enabling 'CONFIG_USB_MXS_PHY':

drivers/usb/otg/imx-otg.c:149: undefined reference to `usb_del_gadget_udc'

And after enabling CONFIG_USB_GADGET it compiles again. But it should be a USB 
host driver, shouldn't it?

Regards,
Juergen

-- 
Pengutronix e.K.                              | Juergen Beisert             |
Linux Solutions for Science and Industry      | Phone: +49-5121-206917-5128 |
Vertretung Sued/Muenchen, Germany             | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686              | http://www.pengutronix.de/  |
