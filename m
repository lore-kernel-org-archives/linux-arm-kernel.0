From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 21 Feb 2011 11:09:05 +0000
Subject: [PATCH 5/5] mmc: sdhci: add quirk
	SDHCI_QUIRK_FIX_NO_INT_IN_MULTI_BLK_IO
In-Reply-To: <20110221104608.GF2616@pengutronix.de>
References: <1298282095-2279-1-git-send-email-richard.zhao@freescale.com>
	<1298282095-2279-5-git-send-email-richard.zhao@freescale.com>
	<20110221100439.GE2616@pengutronix.de>
	<010C9052C42A00499CE76D637FA5EE900C579F@039-SN1MPN1-001.039d.mgd.msft.net>
	<20110221104608.GF2616@pengutronix.de>
Message-ID: <20110221110905.GL14495@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 21, 2011 at 11:46:08AM +0100, Wolfram Sang wrote:
> > > > -   if (cpu_is_mx35() || cpu_is_mx51())
> > > > +   if (cpu_is_mx53())
> > > > +           host->quirks |= SDHCI_QUIRK_FIX_NO_INT_IN_MULTI_BLK_IO;
> > >
> > > Have you tried it doing it via IO-accessors?
> > Richard Zhu: This quirk is used to fix a mechanism problem in the MMC CMDs execution procedure.
> > It would be very abrupt and ugly, if the IO-accessors are added into these original procedures.
> 
> Please don't get it personal, but IMHO it is pretty ugly the way it is
> now. This quirk is very imx-specific and calling something like
> SDHCI_VENDOR_SPEC in sdhci.c looks clearly wrong to me. By the way, what
> does this bit do, the description doesn't say so?

SDHCI_QUIRK_FIX_NO_INT_IN_MULTI_BLK_IO is rather too verbose.  Isn't
there a shorter version which could be used?  SDHCI_QUIRK_SDIO_MULTIBLK_INT
maybe?
