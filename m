From: w.sang@pengutronix.de (Wolfram Sang)
Date: Mon, 18 Oct 2010 13:36:35 +0200
Subject: [PATCH 0/6] SD/MMC driver for MX25/35/51
In-Reply-To: <A88EF4D64D8447468743DC1503C0B6CA0D581A@zch01exm22.fsl.freescale.net>
References: <4CB56A88.2040101@eukrea.com>
	<20101013082930.GA11286@pengutronix.de>
	<8762x6xx00.fsf@lechat.rtp-net.org>
	<A88EF4D64D8447468743DC1503C0B6CA0D557C@zch01exm22.fsl.freescale.net>
	<20101013100632.GC11286@pengutronix.de>
	<4CB58565.5020806@eukrea.com>
	<A88EF4D64D8447468743DC1503C0B6CA0D557D@zch01exm22.fsl.freescale.net>
	<20101013102055.GD11286@pengutronix.de>
	<20101015102729.GB4276@pengutronix.de>
	<A88EF4D64D8447468743DC1503C0B6CA0D581A@zch01exm22.fsl.freescale.net>
Message-ID: <20101018113635.GA15440@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Richard,

On Mon, Oct 18, 2010 at 04:48:07PM +0800, Zhu Richard-R65037 wrote:

> The debug msg "mmc0: mmc_rescan: trying to init card at 400000 Hz..." are dumped out repeatedly.
> ROOT: There are pr_info codes in the mmc_rescan func.

There was already a patch on this list fixing it.

> The other:
> Encounter the Timeout and CRC error when the sandisk 4G SDHC card are used as the ROOTFS storage media
> When I boot up the BBG board.
> 
> It seems that the "SDHCI_QUIRK_BROKEN_TIMEOUT_VAL" is mandatory required at my side when I did the tests
>  on BBG3.0 board, and the i.MX51 board can support the "MULTI-BLOCK".

Okay, this can be fixed...

> BTW, I still can't fetch out the latest codes out, that means I still can't found the V5 patches, although I run
> the git fetch and git rebase. :(

My branch gets rebased because I can't mainline the driver with all my
incremental improvements. Does just taking the branch and cherry-pick
your additions work? (BTW meanwhile you can also just use mmc-next)

Regards,

   Wolfram

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 197 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20101018/bd8ece60/attachment.sig>
