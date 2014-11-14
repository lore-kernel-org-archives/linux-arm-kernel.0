From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Fri, 14 Nov 2014 22:10:52 +0100
Subject: [PATCH v7 08/13] usb: chipidea: add a usb2 driver for ci13xxx
In-Reply-To: <20141114210832.GE16388@saruman>
References: <1415978763-27345-1-git-send-email-antoine.tenart@free-electrons.com>
 <1415978763-27345-9-git-send-email-antoine.tenart@free-electrons.com>
 <20141114210832.GE16388@saruman>
Message-ID: <20141114211052.GA8105@kwain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Felipe,

On Fri, Nov 14, 2014 at 03:08:32PM -0600, Felipe Balbi wrote:
> On Fri, Nov 14, 2014 at 04:25:58PM +0100, Antoine Tenart wrote:
> > Add a USB2 ChipIdea driver for ci13xxx, with optional PHY, clock
> > and DMA mask, to support USB2 ChipIdea controllers that don't need
> > specific functions.
> > 
> > Tested on the Marvell Berlin SoCs USB controllers.
> > 
> > Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>
> > ---
> >  drivers/usb/chipidea/Makefile       |   1 +
> >  drivers/usb/chipidea/ci_hdrc_usb2.c | 117 ++++++++++++++++++++++++++++++++++++
> >  2 files changed, 118 insertions(+)
> >  create mode 100644 drivers/usb/chipidea/ci_hdrc_usb2.c
> > 
> > diff --git a/drivers/usb/chipidea/Makefile b/drivers/usb/chipidea/Makefile
> > index 2f099c7df7b5..1fc86a2ca22d 100644
> > --- a/drivers/usb/chipidea/Makefile
> > +++ b/drivers/usb/chipidea/Makefile
> > @@ -10,6 +10,7 @@ ci_hdrc-$(CONFIG_USB_OTG_FSM)		+= otg_fsm.o
> >  
> >  # Glue/Bridge layers go here
> >  
> > +obj-$(CONFIG_USB_CHIPIDEA)	+= ci_hdrc_usb2.o
> 
> usb2 is too generic, you should call it ci_hdcr_marvell, or something
> like that.

This driver is generic, and not only for Marvell Berlin SoCs. It is part
of the Berlin USB series as it is the first SoC to use it but Xilinx can
also use it for example.

Antoine

-- 
Antoine T?nart, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
