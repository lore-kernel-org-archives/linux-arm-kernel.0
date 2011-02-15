From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 15 Feb 2011 17:19:17 +0000
Subject: [PATCH v2 1/7] mmc: mxs-mmc: add mmc host driver for i.MX23/28
In-Reply-To: <20110215171341.GD10770@pengutronix.de>
References: <1297650746-12841-1-git-send-email-shawn.guo@freescale.com>
	<1297650746-12841-2-git-send-email-shawn.guo@freescale.com>
	<20110214165958.GH10709@pengutronix.de>
	<20110215223941.GJ10990@S2100-06.ap.freescale.net>
	<20110215171341.GD10770@pengutronix.de>
Message-ID: <20110215171917.GQ4152@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 15, 2011 at 06:13:41PM +0100, Wolfram Sang wrote:
> 
> > Ah, yes.  I can also see the problem here after turning on
> > DEBUG_SPINLOCK.
> 
> Ah, okay. After turning it off, it works a lot better :)

That doesn't mean the problem is fixed.  The spinlock debugging is there
to find broken code, and it's saying that the code is broken, and in
this case its saying that there's potential for deadlock.

> MMC fails for me (note: the card works fine with an mx35-based board)
> 
> 	mmc0: new high speed MMC card at address 0001
> 	mmcblk0: mmc0:0001 AF HMP 247 MiB 
> 	mmcblk0: retrying using single block read
> 	mmcblk0: error -84 transferring data, sector 0, nr 8, card status 0x900
> 	end_request: I/O error, dev mmcblk0, sector 0

EILSEQ means CRC failure.  Probably unrelated.

> SDIO card locks the machine. Is it supposed to work already?

Guess it's the spinlock causing that problem.
