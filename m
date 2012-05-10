From: marex@denx.de (Marek Vasut)
Date: Thu, 10 May 2012 20:10:22 +0200
Subject: [RFC PATCH 00/11 V7] MXS: Add i.MX28 USB Host driver
In-Reply-To: <201205101219.14787.jbe@pengutronix.de>
References: <1335837363-12376-1-git-send-email-marex@denx.de>
 <201205101219.14787.jbe@pengutronix.de>
Message-ID: <201205102010.23109.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Juergen Beisert,

> Hi Marek,
> 
> Marek Vasut wrote:
> > This patchset introduces the USB Host driver for i.MX28 CPU, utilising
> > the generic USB PHY infrastructure. Also added is glue code for CI13xxx
> > driver, to allow device mode. This patchset still does NOT support OTG
> > mode, the device/host mode is selected via platform data.
> 
> When using your patch set with my 3.4-rc6 I get:
> 
> After enabling 'CONFIG_USB_EHCI_MXS':
> 
> drivers/usb/host/ehci-mxs.c:171: undefined reference to
> `imx_otg_set_irq_handler'
> 
> After enabling 'CONFIG_USB_MXS_PHY':
> 
> drivers/usb/otg/imx-otg.c:149: undefined reference to `usb_del_gadget_udc'
> 
> And after enabling CONFIG_USB_GADGET it compiles again. But it should be a
> USB host driver, shouldn't it?

Nice catch, I'll add it into the stack of fixes that need to be made in V8. 
Though I'd rather rebase V8 on top of usb-next.

btw. this supports both host and gadget mode (not OTG right now), certainly 
handling the fact the gadget code isn't present in kernel needs to be done. In 
the meantime, enable also gadget mode and add ci13xxx-mxs into the kernel, it 
should fix your problem.

Thanks for the report!

> 
> Regards,
> Juergen

Best regards,
Marek Vasut
