From: w.sang@pengutronix.de (Wolfram Sang)
Date: Tue, 15 Feb 2011 18:29:48 +0100
Subject: [PATCH v2 1/7] mmc: mxs-mmc: add mmc host driver for i.MX23/28
In-Reply-To: <20110215171917.GQ4152@n2100.arm.linux.org.uk>
References: <1297650746-12841-1-git-send-email-shawn.guo@freescale.com>
	<1297650746-12841-2-git-send-email-shawn.guo@freescale.com>
	<20110214165958.GH10709@pengutronix.de>
	<20110215223941.GJ10990@S2100-06.ap.freescale.net>
	<20110215171341.GD10770@pengutronix.de>
	<20110215171917.GQ4152@n2100.arm.linux.org.uk>
Message-ID: <20110215172948.GE10770@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 15, 2011 at 05:19:17PM +0000, Russell King - ARM Linux wrote:
> On Tue, Feb 15, 2011 at 06:13:41PM +0100, Wolfram Sang wrote:
> > 
> > > Ah, yes.  I can also see the problem here after turning on
> > > DEBUG_SPINLOCK.
> > 
> > Ah, okay. After turning it off, it works a lot better :)
> 
> That doesn't mean the problem is fixed. [...]

Yes, I know that. I should have put the 'works' above in quotes, sorry.

> > MMC fails for me (note: the card works fine with an mx35-based board)
> > 
> > 	mmc0: new high speed MMC card at address 0001
> > 	mmcblk0: mmc0:0001 AF HMP 247 MiB 
> > 	mmcblk0: retrying using single block read
> > 	mmcblk0: error -84 transferring data, sector 0, nr 8, card status 0x900
> > 	end_request: I/O error, dev mmcblk0, sector 0
> 
> EILSEQ means CRC failure.  Probably unrelated.

Even if it works in another setup? As a result of the above, I can't read the
partition table of that MMC. The mx35 can do so.

> > SDIO card locks the machine. Is it supposed to work already?
> 
> Guess it's the spinlock causing that problem.

Yeah, that could be. In addition, I was just generally interested if SDIO has
been tested by Shawn.

Regards,

   Wolfram

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
