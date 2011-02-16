From: w.sang@pengutronix.de (Wolfram Sang)
Date: Wed, 16 Feb 2011 16:33:32 +0100
Subject: [PATCH v2 1/7] mmc: mxs-mmc: add mmc host driver for i.MX23/28
In-Reply-To: <20110216202818.GA11467@S2100-06.ap.freescale.net>
References: <1297650746-12841-1-git-send-email-shawn.guo@freescale.com>
	<1297650746-12841-2-git-send-email-shawn.guo@freescale.com>
	<20110214165958.GH10709@pengutronix.de>
	<20110215223941.GJ10990@S2100-06.ap.freescale.net>
	<20110215171341.GD10770@pengutronix.de>
	<20110215171917.GQ4152@n2100.arm.linux.org.uk>
	<20110215172948.GE10770@pengutronix.de>
	<20110216202818.GA11467@S2100-06.ap.freescale.net>
Message-ID: <20110216153332.GC6365@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shawn,

[CRC failures on MMC]
> I guess you will also get the unknown partition table message if you
> test this card on mx35 right now.

No, I didn't see that message on MX35. (Doesn't matter much now).

> I just tested 7 mmc cards in total.  6 cards work fine, and 1 card
> (Transcend MMC plus 1GB) has the exactly same problem as yours. And
> if I remove the 8 bit cap, this card also works fine.  So I would
> agree with Russell that it's unrelated to the driver.

Ah, the 8_BIT_CAP was the right pointer. It works now and I can see the
partitions \o/ But IMHO it is related to the driver because it cannot set that
8_BIT_DATA_CAP unconditionally? Probably something like 'flags' should be added
to platform_data? One flag could then be 8_BIT_CAPABLE_SLOT or something.

> I tested the SDIO, but probably in different way from yours.  I had
> two card slots on my board, rootfs on mmc0 and SDIO card on mmc1.
> It seems working fine in this way.  However, when I use nfs and test
> SDIO on mmc0, my systems hangs too.  I will look into it.

The latter scenario is the only one I can test, because I don't have an
(active) second slot.

Thanks for keeping up with the driver!

   Wolfram

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
