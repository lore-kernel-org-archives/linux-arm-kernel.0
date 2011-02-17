From: w.sang@pengutronix.de (Wolfram Sang)
Date: Thu, 17 Feb 2011 13:06:32 +0100
Subject: [PATCH v2 1/7] mmc: mxs-mmc: add mmc host driver for i.MX23/28
In-Reply-To: <20110217041713.GB1273@S2100-06.ap.freescale.net>
References: <1297650746-12841-1-git-send-email-shawn.guo@freescale.com>
	<1297650746-12841-2-git-send-email-shawn.guo@freescale.com>
	<20110214165958.GH10709@pengutronix.de>
	<20110215223941.GJ10990@S2100-06.ap.freescale.net>
	<20110215171341.GD10770@pengutronix.de>
	<20110215171917.GQ4152@n2100.arm.linux.org.uk>
	<20110215172948.GE10770@pengutronix.de>
	<20110216202818.GA11467@S2100-06.ap.freescale.net>
	<20110216153332.GC6365@pengutronix.de>
	<20110217041713.GB1273@S2100-06.ap.freescale.net>
Message-ID: <20110217120632.GB30692@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shawn,

> > Ah, the 8_BIT_CAP was the right pointer. It works now and I can see the
> > partitions \o/ But IMHO it is related to the driver because it cannot set that
> > 8_BIT_DATA_CAP unconditionally? Probably something like 'flags' should be added
> > to platform_data? One flag could then be 8_BIT_CAPABLE_SLOT or something.
> > 
> If a platform is designed to support 8-bit mode (e.g. all 8 data
> lines are routed), I do not think the 8-bit cap will be removed from
> this platform just because one particular card has problem to work
> in 8-bit mode.

Right, surely not beacuse of a card, this was a misunderstanding. The issue is
not related to cards but slots. By naming the flag 8_BIT_CAPABLE_SLOT I wanted
to indicate this.

> But I would anyway let platform_data tell the 4 BIT_CAP and 8_BIT_CAP
> just like what Freescale BSP is doing, as some platforms may design
> this cap differently.

Yep, that's what I meant, too :) Adding the slot capabilities in platform_data.

> So your board supplies mmc0 slot with VDDIO_3V3 as well?

Hmm, the schematics say no, but I will assume it is a board issue and check
with the manufacturer.

Thanks again!

   Wolfram

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
