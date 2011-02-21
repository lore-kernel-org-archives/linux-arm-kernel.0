From: w.sang@pengutronix.de (Wolfram Sang)
Date: Mon, 21 Feb 2011 11:46:08 +0100
Subject: [PATCH 5/5] mmc: sdhci: add quirk
	SDHCI_QUIRK_FIX_NO_INT_IN_MULTI_BLK_IO
In-Reply-To: <010C9052C42A00499CE76D637FA5EE900C579F@039-SN1MPN1-001.039d.mgd.msft.net>
References: <1298282095-2279-1-git-send-email-richard.zhao@freescale.com>
	<1298282095-2279-5-git-send-email-richard.zhao@freescale.com>
	<20110221100439.GE2616@pengutronix.de>
	<010C9052C42A00499CE76D637FA5EE900C579F@039-SN1MPN1-001.039d.mgd.msft.net>
Message-ID: <20110221104608.GF2616@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > > -   if (cpu_is_mx35() || cpu_is_mx51())
> > > +   if (cpu_is_mx53())
> > > +           host->quirks |= SDHCI_QUIRK_FIX_NO_INT_IN_MULTI_BLK_IO;
> >
> > Have you tried it doing it via IO-accessors?
> Richard Zhu: This quirk is used to fix a mechanism problem in the MMC CMDs execution procedure.
> It would be very abrupt and ugly, if the IO-accessors are added into these original procedures.

Please don't get it personal, but IMHO it is pretty ugly the way it is
now. This quirk is very imx-specific and calling something like
SDHCI_VENDOR_SPEC in sdhci.c looks clearly wrong to me. By the way, what
does this bit do, the description doesn't say so?

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110221/2393fe81/attachment.sig>
