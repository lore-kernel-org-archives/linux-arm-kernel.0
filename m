From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 27 Jan 2016 11:56:13 +0100
Subject: noise issues when recording sound on i.MX28
Message-ID: <20160127105613.GC13664@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

I currently work with an i.MX28 based machine and occasionally when
recording sound with arecord but no microphone connected the result
contains much noise.

I found commits

	90ce77d4468e ENGR00285446-3 [MX28] SAIF: Bit Shift in SAIF RX Data
	1ea685a12f19 ENGR00285446-2 [MX28] SAIF: Bit Shift in SAIF RX Data
	1ca899221d8b ENGR00285446-1 [MX28] SAIF: Bit Shift in SAIF RX Data

in the Freescale vendor kernel (branch imx_2.6.35_maintain at
git://git.freescale.com/imx/linux-2.6-imx.git). The kernel running on
the machine in question is based on 3.10 with an impressive (that's
negative) patch stack on top. I think patches -2 and -3 are not relevant
for my setup because the two saif clocks are configured identically if
I'm not mistaken. However implementing the soft reset as is done in
patch -1 doesn't work here. When resetting saif1 (that is used for
recording with saif0 being it's master) the CLKGATE bit gets never set
and when breaking out of the loop the noise issue happend 5 out of 5
test runs in the first iteration.

Does this ring a bell for you? Even if there is something bad hidden in
the patch stack (or 3.10?) a reset should never fail, right?

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
