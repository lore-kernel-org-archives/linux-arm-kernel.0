From: peter.chen@freescale.com (Peter Chen)
Date: Fri, 13 Dec 2013 13:15:09 +0800
Subject: [PATCH v6 02/15] usb: phy-mxs: Add platform judgement code
In-Reply-To: <20131213041918.GC867@saruman.home>
References: <1386897825-6130-1-git-send-email-peter.chen@freescale.com>
 <1386897825-6130-3-git-send-email-peter.chen@freescale.com>
 <20131213041918.GC867@saruman.home>
Message-ID: <20131213051508.GA16072@shlinux1.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 12, 2013 at 10:19:19PM -0600, Felipe Balbi wrote:
> On Fri, Dec 13, 2013 at 09:23:32AM +0800, Peter Chen wrote:
> > The mxs-phy has several bugs and features at different
> > versions, the driver code can get it through of_device_id.data.
> > 
> > Signed-off-by: Peter Chen <peter.chen@freescale.com>
> > ---
> >  drivers/usb/phy/phy-mxs-usb.c |   58 ++++++++++++++++++++++++++++++++++------
> >  1 files changed, 49 insertions(+), 9 deletions(-)
> > 
> > diff --git a/drivers/usb/phy/phy-mxs-usb.c b/drivers/usb/phy/phy-mxs-usb.c
> > index 545844b..6d49040 100644
> > --- a/drivers/usb/phy/phy-mxs-usb.c
> > +++ b/drivers/usb/phy/phy-mxs-usb.c
> > @@ -1,5 +1,5 @@
> >  /*
> > - * Copyright 2012 Freescale Semiconductor, Inc.
> > + * Copyright 2012-2013 Freescale Semiconductor, Inc.
> >   * Copyright (C) 2012 Marek Vasut <marex@denx.de>
> >   * on behalf of DENX Software Engineering GmbH
> >   *
> > @@ -20,6 +20,7 @@
> >  #include <linux/delay.h>
> >  #include <linux/err.h>
> >  #include <linux/io.h>
> > +#include <linux/of_device.h>
> >  
> >  #define DRIVER_NAME "mxs_phy"
> >  
> > @@ -34,13 +35,55 @@
> >  #define BM_USBPHY_CTRL_ENUTMILEVEL2		BIT(14)
> >  #define BM_USBPHY_CTRL_ENHOSTDISCONDETECT	BIT(1)
> >  
> > +#define to_mxs_phy(p) container_of((p), struct mxs_phy, phy)
> 
> defined, but never used.
> 

At current code, this define is after definition of struct mxs_phy,
I think the lines of #define should be at the same place, so I move
it up.

-- 

Best Regards,
Peter Chen
