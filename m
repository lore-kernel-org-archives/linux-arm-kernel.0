From: Peter.Chen@freescale.com (Peter Chen)
Date: Wed, 17 Sep 2014 00:00:57 +0000
Subject: [PATCH v5 07/12] usb: chipidea: add a usb2 driver for ci13xxx
In-Reply-To: <20140916140551.GE4869@kwain>
References: <1410777378-12726-1-git-send-email-antoine.tenart@free-electrons.com>
 <1410777378-12726-8-git-send-email-antoine.tenart@free-electrons.com>
 <20140916005129.GC3379@peterchendt> <20140916133841.GA4869@kwain>
 <20140916140551.GE4869@kwain>
Message-ID: <9aaef3c1f0944174b725371fff9813ab@BN1PR0301MB0772.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 
> > > > Tested on the Marvell Berlin SoCs USB controllers.
> > > >
> > > > Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>
> > > > ---
> > > >  drivers/usb/chipidea/Makefile       |   1 +
> > > >  drivers/usb/chipidea/ci_hdrc_usb2.c | 137
> > > > ++++++++++++++++++++++++++++++++++++
> > > >  2 files changed, 138 insertions(+)  create mode 100644
> > > > drivers/usb/chipidea/ci_hdrc_usb2.c
> > > >
> > >
> > > compile error:
> > >
> > > /home/peter/work/projects/usb/drivers/usb/chipidea/ci_hdrc_usb2.c: In
> function 'ci_hdrc_usb2_dt_probe':
> > > /home/peter/work/projects/usb/drivers/usb/chipidea/ci_hdrc_usb2.c:30
> > > :2: error: implicit declaration of function 'of_phy_get'
> > > [-Werror=implicit-function-declaration]
> > > /home/peter/work/projects/usb/drivers/usb/chipidea/ci_hdrc_usb2.c:30
> > > :16: warning: assignment makes pointer from integer without a cast
> > > [enabled by default]
> >
> > Did you apply the series introducing the support for the generic PHY
> > framework in the USB subsystem first? One of the patches includes
> > 'linux/phy/phy.h' in 'linux/usb/otg.h'. That's why I did not encounter
> > this error.
> >
> > Anyway, you're right and 'linux/phy/phy.h' should be explicitly
> > included here.
> 
> Let me know if you want me to quickly cook up a new version fixing this.
> 

You can send this fix if you don't want to get comments for other parts in this
series.

I also see other dependencies like generic phy support for chipidea with this one.
I think the 7th and 8th in this series are ok after adding 'linux/phy/phy.h', but
you generic phy support series should be queued before this one.

Peter
