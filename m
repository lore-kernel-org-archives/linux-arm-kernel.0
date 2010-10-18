From: r65037@freescale.com (Zhu Richard-R65037)
Date: Mon, 18 Oct 2010 16:48:07 +0800
Subject: [PATCH 0/6] SD/MMC driver for MX25/35/51
References: <1286806866-19258-1-git-send-email-w.sang@pengutronix.de>
	<87aamjxe00.fsf@lechat.rtp-net.org> <4CB56A88.2040101@eukrea.com>
	<20101013082930.GA11286@pengutronix.de>
	<8762x6xx00.fsf@lechat.rtp-net.org>
	<A88EF4D64D8447468743DC1503C0B6CA0D557C@zch01exm22.fsl.freescale.net>
	<20101013100632.GC11286@pengutronix.de>
	<4CB58565.5020806@eukrea.com>
	<A88EF4D64D8447468743DC1503C0B6CA0D557D@zch01exm22.fsl.freescale.net>
	<20101013102055.GD11286@pengutronix.de>
	<20101015102729.GB4276@pengutronix.de>
Message-ID: <A88EF4D64D8447468743DC1503C0B6CA0D581A@zch01exm22.fsl.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Wolfram:
I tested your serial patches with Eric's platform related codes on i.MX51 BBG3.0 board.
Two phenomena:
The debug msg "mmc0: mmc_rescan: trying to init card at 400000 Hz..." are dumped out repeatedly.
ROOT: There are pr_info codes in the mmc_rescan func.

The other:
Encounter the Timeout and CRC error when the sandisk 4G SDHC card are used as the ROOTFS storage media
When I boot up the BBG board.

It seems that the "SDHCI_QUIRK_BROKEN_TIMEOUT_VAL" is mandatory required at my side when I did the tests
 on BBG3.0 board, and the i.MX51 board can support the "MULTI-BLOCK".

Hi Eric:
What's kinds of tests and environment you did at your side?

BTW, I still can't fetch out the latest codes out, that means I still can't found the V5 patches, although I run
the git fetch and git rebase. :(

Best Regards
Richard Zhu


> -----Original Message-----
> From: Zhu Richard-R65037
> Sent: Monday, October 18, 2010 11:30 AM
> To: 'Wolfram Sang'
> Cc: Eric B?nard; Arnaud Patard; linux-mmc at vger.kernel.org; linux-arm-
> kernel at lists.infradead.org
> Subject: RE: [PATCH 0/6] SD/MMC driver for MX25/35/51
> 
> Hi Wolfram:
> Can you sync-up the http URL of your repos with your latest patches?
> I can't get fetch and sync-up with your latest codes now, since I can
> only used the HTTP URL to clone your codes.
> 
> Best Regards
> Richard Zhu
> 
> 
> > -----Original Message-----
> > From: Wolfram Sang [mailto:w.sang at pengutronix.de]
> > Sent: Friday, October 15, 2010 6:27 PM
> > To: Zhu Richard-R65037
> > Cc: Eric B?nard; Arnaud Patard; linux-mmc at vger.kernel.org; linux-arm-
> > kernel at lists.infradead.org
> > Subject: Re: [PATCH 0/6] SD/MMC driver for MX25/35/51
> >
> > Richard,
> >
> > > > I take one day leave yesterday for one examination that had been
> > > > booked a few days ago,  and missed Eric's patches, so regretful.
> > >
> > > No problem, such things happen. If you'd have time to review those
> > > patches now, that would be great, too.
> >
> > Do you have time to check the latest series (V5, just posted)? BTW
> > which patch-set are you using now for development?
> >
> > Regards,
> >
> >    Wolfram
> >
> > --
> > Pengutronix e.K.                           | Wolfram Sang
> > |
> > Industrial Linux Solutions                 | http://www.pengutronix.de/
> > |
