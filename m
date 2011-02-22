From: w.sang@pengutronix.de (Wolfram Sang)
Date: Tue, 22 Feb 2011 11:33:49 +0100
Subject: [PATCH v3] mmc: mxs-mmc: add mmc host driver for i.MX23/28
In-Reply-To: <20110222085256.GA19871@S2100-06.ap.freescale.net>
References: <1298284528-14761-1-git-send-email-shawn.guo@freescale.com>
	<20110221174016.GN2616@pengutronix.de>
	<20110222085256.GA19871@S2100-06.ap.freescale.net>
Message-ID: <20110222103349.GA2755@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> > What throughput rates do you get on a mx28-regulated slot serving a card
> > at 50Mhz? This is poor here (55kb/s) while it is OK at 25Mhz. Could be a
> 
> To make sure we are on the same test, can you share the test case
> you ran to get the result?  So that I can run it here for the result
> on my board.

# mount -t vfat /dev/mmcblk0p1 /mnt
# dd if=/mnt/test.dat of=/tmp/a bs=1024
# umount /mnt
# ./dd --version
dd (coreutils) 8.5
...

'test.dat' was a 8MB file of random data on a 4GB SDHC card
(extrememory) on a slot powered by the mx28. Operating the card at
50Mhz, dd will report ~55 kb/s. If I add 'rate /= 2;' to the beginning
of set_clk_rate, so it will operate at 25Mhz, I have 8mb/s.

Regards,

   Wolfram

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110222/067cb096/attachment.sig>
