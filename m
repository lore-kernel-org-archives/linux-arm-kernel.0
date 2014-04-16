From: shawn.guo@freescale.com (Shawn Guo)
Date: Wed, 16 Apr 2014 16:08:50 +0800
Subject: [PATCH 1/2] ahci: imx: use macros to define registers and bits
In-Reply-To: <20140416075957.GR5969@pengutronix.de>
References: <1397529703-21165-1-git-send-email-shawn.guo@freescale.com>
 <20140416075957.GR5969@pengutronix.de>
Message-ID: <20140416080849.GL2523@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 16, 2014 at 09:59:57AM +0200, Uwe Kleine-K?nig wrote:
> On Tue, Apr 15, 2014 at 10:41:42AM +0800, Shawn Guo wrote:
> > diff --git a/drivers/ata/ahci_imx.c b/drivers/ata/ahci_imx.c
> > index 497c7ab..39629b4 100644
> > --- a/drivers/ata/ahci_imx.c
> > +++ b/drivers/ata/ahci_imx.c
> > @@ -28,11 +28,9 @@
> >  #include <linux/libata.h>
> >  #include "ahci.h"
> >  
> > -enum {
> > -	PORT_PHY_CTL = 0x178,			/* Port0 PHY Control */
> > -	PORT_PHY_CTL_PDDQ_LOC = 0x100000,	/* PORT_PHY_CTL bits */
> > -	HOST_TIMER1MS = 0xe0,			/* Timer 1-ms */
> > -};
> > +#define IMX_SATA_TIMER1MS			0x00e0
> > +#define IMX_SATA_P0PHYCR			0x0178
> > +#define  P0PHYCR_TEST_PDDQ			(1 << 20)
> Did you intentionally not namespace the bit mask?

Yes, with the intention to make the bit names a little shorter.

Shawn
