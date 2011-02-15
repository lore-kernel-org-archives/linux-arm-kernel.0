From: w.sang@pengutronix.de (Wolfram Sang)
Date: Tue, 15 Feb 2011 18:13:41 +0100
Subject: [PATCH v2 1/7] mmc: mxs-mmc: add mmc host driver for i.MX23/28
In-Reply-To: <20110215223941.GJ10990@S2100-06.ap.freescale.net>
References: <1297650746-12841-1-git-send-email-shawn.guo@freescale.com>
	<1297650746-12841-2-git-send-email-shawn.guo@freescale.com>
	<20110214165958.GH10709@pengutronix.de>
	<20110215223941.GJ10990@S2100-06.ap.freescale.net>
Message-ID: <20110215171341.GD10770@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> Ah, yes.  I can also see the problem here after turning on
> DEBUG_SPINLOCK.

Ah, okay. After turning it off, it works a lot better :)

SD seems to work:

	mmc0: new high speed SD card at address b368
	mmcblk0: mmc0:b368 NCard 1.86 GiB 
	 mmcblk0: p1
	mmc0: card b368 removed

SDHC seems to work:

	mmc0: new high speed SDHC card at address 0007
	mmcblk0: mmc0:0007 SD04G 3.70 GiB 
	 mmcblk0: p1
	mmc0: card 0007 removed

MMC fails for me (note: the card works fine with an mx35-based board)

	mmc0: new high speed MMC card at address 0001
	mmcblk0: mmc0:0001 AF HMP 247 MiB 
	mmcblk0: retrying using single block read
	mmcblk0: error -84 transferring data, sector 0, nr 8, card status 0x900
	end_request: I/O error, dev mmcblk0, sector 0
	mmcblk0: error -84 transferring data, sector 1, nr 7, card status 0x900
	end_request: I/O error, dev mmcblk0, sector 1
	mmcblk0: error -84 transferring data, sector 2, nr 6, card status 0x900
	end_request: I/O error, dev mmcblk0, sector 2
	mmcblk0: error -84 transferring data, sector 3, nr 5, card status 0x900
	end_request: I/O error, dev mmcblk0, sector 3
	mmcblk0: error -84 transferring data, sector 4, nr 4, card status 0x900
	end_request: I/O error, dev mmcblk0, sector 4
	mmcblk0: error -84 transferring data, sector 5, nr 3, card status 0x900
	end_request: I/O error, dev mmcblk0, sector 5
	mmcblk0: error -84 transferring data, sector 6, nr 2, card status 0x900
	end_request: I/O error, dev mmcblk0, sector 6
	mmcblk0: error -84 transferring data, sector 7, nr 1, card status 0x900
	end_request: I/O error, dev mmcblk0, sector 7
	Buffer I/O error on device mmcblk0, logical block 0
	mmcblk0: retrying using single block read
	mmcblk0: error -84 transferring data, sector 0, nr 8, card status 0x900
	end_request: I/O error, dev mmcblk0, sector 0
	mmcblk0: error -84 transferring data, sector 1, nr 7, card status 0x900
	end_request: I/O error, dev mmcblk0, sector 1
	mmcblk0: error -84 transferring data, sector 2, nr 6, card status 0x900
	end_request: I/O error, dev mmcblk0, sector 2
	mmcblk0: error -84 transferring data, sector 3, nr 5, card status 0x900
	end_request: I/O error, dev mmcblk0, sector 3
	mmcblk0: error -84 transferring data, sector 4, nr 4, card status 0x900
	end_request: I/O error, dev mmcblk0, sector 4
	mmcblk0: error -84 transferring data, sector 5, nr 3, card status 0x900
	end_request: I/O error, dev mmcblk0, sector 5
	mmcblk0: error -84 transferring data, sector 6, nr 2, card status 0x900
	end_request: I/O error, dev mmcblk0, sector 6
	mmcblk0: error -84 transferring data, sector 7, nr 1, card status 0x900
	end_request: I/O error, dev mmcblk0, sector 7
	Buffer I/O error on device mmcblk0, logical block 0
	 mmcblk0: unable to read partition table
	mmc0: card 0001 removed

SDIO card locks the machine. Is it supposed to work already?

Regards,

   Wolfram

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
