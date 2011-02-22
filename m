From: R65037@freescale.com (Zhu Richard-R65037)
Date: Tue, 22 Feb 2011 02:26:08 +0000
Subject: [PATCH 5/5] mmc: sdhci: add quirk
	SDHCI_QUIRK_FIX_NO_INT_IN_MULTI_BLK_IO
In-Reply-To: <20110221110905.GL14495@n2100.arm.linux.org.uk>
References: <1298282095-2279-1-git-send-email-richard.zhao@freescale.com>
	<1298282095-2279-5-git-send-email-richard.zhao@freescale.com>
	<20110221100439.GE2616@pengutronix.de>
	<010C9052C42A00499CE76D637FA5EE900C579F@039-SN1MPN1-001.039d.mgd.msft.net>
	<20110221104608.GF2616@pengutronix.de>
	<20110221110905.GL14495@n2100.arm.linux.org.uk>
Message-ID: <010C9052C42A00499CE76D637FA5EE900C5998@039-SN1MPN1-001.039d.mgd.msft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell King:
Thanks for your comments firstly.

Best Regards
Richard Zhu


> -----Original Message-----
> From: Russell King - ARM Linux [mailto:linux at arm.linux.org.uk]
> Sent: Monday, February 21, 2011 7:09 PM
> To: Wolfram Sang
> Cc: Zhu Richard-R65037; Zhao Richard-B20223; cjb at laptop.org;
> eric at eukrea.com; linux-mmc at vger.kernel.org; kernel at pengutronix.de;
> avorontsov at ru.mvista.com; linux-arm-kernel at lists.infradead.org;
> linuxzsc at gmail.com
> Subject: Re: [PATCH 5/5] mmc: sdhci: add quirk
> SDHCI_QUIRK_FIX_NO_INT_IN_MULTI_BLK_IO
>
> On Mon, Feb 21, 2011 at 11:46:08AM +0100, Wolfram Sang wrote:
> > > > > -   if (cpu_is_mx35() || cpu_is_mx51())
> > > > > +   if (cpu_is_mx53())
> > > > > +           host->quirks |=
> > > > > + SDHCI_QUIRK_FIX_NO_INT_IN_MULTI_BLK_IO;
> > > >
> > > > Have you tried it doing it via IO-accessors?
> > > Richard Zhu: This quirk is used to fix a mechanism problem in the MMC
> CMDs execution procedure.
> > > It would be very abrupt and ugly, if the IO-accessors are added into
> these original procedures.
> >
> > Please don't get it personal, but IMHO it is pretty ugly the way it is
> > now. This quirk is very imx-specific and calling something like
> > SDHCI_VENDOR_SPEC in sdhci.c looks clearly wrong to me. By the way,
> > what does this bit do, the description doesn't say so?
>
> SDHCI_QUIRK_FIX_NO_INT_IN_MULTI_BLK_IO is rather too verbose.  Isn't
> there a shorter version which could be used?
> SDHCI_QUIRK_SDIO_MULTIBLK_INT maybe?
Yeah, I agree, the clear and shorter is better.
I'm discussing with WolfSang that this quirk should be added or not.
First of all, we should make a decision that this quirk is needed or not.
Then we can refine it.
