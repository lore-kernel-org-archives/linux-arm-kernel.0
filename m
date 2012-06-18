From: marex@denx.de (Marek Vasut)
Date: Mon, 18 Jun 2012 19:13:06 +0200
Subject: [Patch v5 00/13] add imx usb driver for mx28/6x
In-Reply-To: <CAOMZO5BXsPtwC2CTt6Z-DjZUYhrWMKDkr2QnFoAKb-aLc1XsNA@mail.gmail.com>
References: <1339590863-10564-1-git-send-email-richard.zhao@freescale.com>
 <CAOMZO5BXsPtwC2CTt6Z-DjZUYhrWMKDkr2QnFoAKb-aLc1XsNA@mail.gmail.com>
Message-ID: <201206181913.06886.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Fabio Estevam,

> Hi Richard,
> 
> On Wed, Jun 13, 2012 at 9:34 AM, Richard Zhao
> 
> <richard.zhao@freescale.com> wrote:
> > The work is based on  ci13xxx rework done by Alexander Shishkin.
> > 
> > Status:
> >  - this version only support host
> >  - usbotg controler works at host role
> > 
> > Changes since last version:
> >  - collect ack received.
> > 
> > Richard Zhao (13):
> >  usb: otg: add notify_connect/notify_disconnect callback
> >  USB: move transceiver from ehci_hcd and ohci_hcd to hcd and rename it
> >    as phy
> >  USB: notify phy when root hub port connect change
> >  usb: chipidea: permit driver bindings pass phy pointer
> >  usb: otg: add basic mxs phy driver support
> >  usb: chipidea: add imx platform driver
> >  ARM: imx6q: correct device name of usbphy and usb controller clock
> >    export
> >  ARM: imx6q: add config-on-boot gpios
> >  ARM: imx6q: add usbphy clocks
> >  ARM: imx6q: disable usb charger detector
> >  ARM: dts: imx6q-sabrelite: add usb devices
> >  ARM: mxs: clk_register_clkdev mx28 usb clocks
> >  ARM: dts: imx28-evk: add usb devices
> 
> I am trying your patch series on a mx28evk and I am not able to have
> my USB pen drive detected.
> 
> I tried enabling all the required config options in .config.
> 
> Could you please share your .config?

Do you have root TT enabled? If the pendrive isn't detected at all, it's 
probably the PHY not enabling (disabling?) the discon detector upon init. But 
the PHY driver is from my code, so that should work. Do you see any response at 
all upon connecting the stick?

> 
> Thanks,
> 
> Fabio Estevam

Best regards,
Marek Vasut
