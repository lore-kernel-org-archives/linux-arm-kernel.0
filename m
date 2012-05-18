From: balbi@ti.com (Felipe Balbi)
Date: Fri, 18 May 2012 14:34:38 +0300
Subject: [PATCH 6/8] CI13xxx: Add i.MX233/i.MX28 binding code
In-Reply-To: <201205161541.17508.marex@denx.de>
References: <1337070219-3630-1-git-send-email-marex@denx.de>
 <1337070219-3630-7-git-send-email-marex@denx.de>
 <20120516083613.GG17359@arwen.pp.htv.fi>
 <201205161541.17508.marex@denx.de>
Message-ID: <20120518113436.GN29784@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 16, 2012 at 03:41:17PM +0200, Marek Vasut wrote:
> Dear Felipe Balbi,
> 
> > On Tue, May 15, 2012 at 10:23:37AM +0200, Marek Vasut wrote:
> > > This codes connects the CI13xxx driver with the core found inside of
> > > the Freescale i.MX244/i.MX28 CPU.
> > > 
> > > Signed-off-by: Marek Vasut <marex@denx.de>
> > > Cc: Alan Stern <stern@rowland.harvard.edu>
> > > Cc: Detlev Zundel <dzu@denx.de>
> > > CC: Dong Aisheng <b29396@freescale.com>
> > > CC: Fabio Estevam <fabio.estevam@freescale.com>
> > > Cc: Felipe Balbi <balbi@ti.com>
> > > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > Cc: Linux ARM kernel <linux-arm-kernel@lists.infradead.org>
> > > Cc: linux-i2c at vger.kernel.org
> > > CC: Sascha Hauer <s.hauer@pengutronix.de>
> > > CC: Shawn Guo <shawn.guo@linaro.org>
> > > Cc: Stefano Babic <sbabic@denx.de>
> > > CC: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> > > Cc: Wolfgang Denk <wd@denx.de>
> > > Cc: Wolfram Sang <w.sang@pengutronix.de>
> > > ---
> > > 
> > >  drivers/usb/chipidea/Makefile      |    4 +
> > >  drivers/usb/chipidea/ci13xxx_mxs.c |  201
> > >  ++++++++++++++++++++++++++++++++++++ 2 files changed, 205 insertions(+)
> > >  create mode 100644 drivers/usb/chipidea/ci13xxx_mxs.c
> > > 
> > > diff --git a/drivers/usb/chipidea/Makefile
> > > b/drivers/usb/chipidea/Makefile index cc34937..266d57d 100644
> > > --- a/drivers/usb/chipidea/Makefile
> > > +++ b/drivers/usb/chipidea/Makefile
> > > @@ -12,3 +12,7 @@ endif
> > > 
> > >  ifneq ($(CONFIG_ARCH_MSM),)
> > >  
> > >  	obj-$(CONFIG_USB_CHIPIDEA)	+= ci13xxx_msm.o
> > >  
> > >  endif
> > > 
> > > +
> > > +ifneq ($(CONFIG_ARCH_MXS),)
> > > +	obj-$(CONFIG_USB_CHIPIDEA)	+= ci13xxx_mxs.o
> > > +endif
> > 
> > NAK... let it compile everywhere.
> 
> I just followed the pattern here, honestly I think this is quite OK so far. 
> Further improvements can be made indeed.

why introduce something we know will change ? Just make sure your code
compiles everywhere. What's already there can be changed afterwards.

> > > +	*data->pdev->dev.dma_mask = DMA_BIT_MASK(32);
> > > +	data->pdev->dev.coherent_dma_mask = DMA_BIT_MASK(32);
> > 
> > why don't you just point to the parent's ?
> 
> Good idea, thanks :)

no problem ;-)

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120518/7a2cd354/attachment.sig>
