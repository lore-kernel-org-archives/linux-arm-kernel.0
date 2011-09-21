From: shawn.guo@freescale.com (Shawn Guo)
Date: Wed, 21 Sep 2011 19:58:22 +0800
Subject: [PATCH v2 3/3] net/fec: add imx6q enet support
In-Reply-To: <20110921113239.GF1966@pengutronix.de>
References: <1316603432-20032-1-git-send-email-shawn.guo@linaro.org>
	<1316603432-20032-4-git-send-email-shawn.guo@linaro.org>
	<20110921113239.GF1966@pengutronix.de>
Message-ID: <20110921115821.GF28907@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 21, 2011 at 01:32:39PM +0200, Wolfram Sang wrote:
> 
> > +/* Controller has GBIT support */
> > +#define FEC_QUIRK_HAS_GBIT		(1 << 3)
> 
> Heh, this is not really a quirk, but a nice feature :) I think we can
> drop QUIRK if we see driver_data more as "flags" instead of "quirks"?
> Minor, though.
> 
As you have told, all these FEC_QUIRK_* are just flags actually.  The
name was pick to keep the consistency, as they are all used for the
same purpose.

> >  MODULE_DEVICE_TABLE(of, fec_dt_ids);
> > @@ -373,6 +383,7 @@ fec_restart(struct net_device *ndev, int duplex)
> >  	int i;
> >  	u32 temp_mac[2];
> >  	u32 rcntl = OPT_FRAME_SIZE | 0x04;
> > +	u32 ecntl = 0x2; /* ETHEREN */
> 
> Also minor, but the patch looks like a good oportunity to start
> replacing magic values with proper defines?
> 
There are already so many magic numbers.  It really deserves a separated
patch.

I heard that Uwe had a plan to do that some time ago.  He gives up
now? :)

-- 
Regards,
Shawn
