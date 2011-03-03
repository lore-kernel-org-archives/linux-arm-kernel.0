From: w.sang@pengutronix.de (Wolfram Sang)
Date: Thu, 3 Mar 2011 11:49:02 +0100
Subject: [PATCH V3 4/4] mmc: sdhci-esdhc: enable esdhc on imx53
In-Reply-To: <010C9052C42A00499CE76D637FA5EE900C82A4@039-SN1MPN1-001.039d.mgd.msft.net>
References: <1298892725-23672-1-git-send-email-Hong-Xing.Zhu@freescale.com>
	<1298892725-23672-4-git-send-email-Hong-Xing.Zhu@freescale.com>
	<20110228144741.GF15532@pengutronix.de>
	<010C9052C42A00499CE76D637FA5EE900C7B7B@039-SN1MPN1-001.039d.mgd.msft.net>
	<20110301113115.GB2212@pengutronix.de>
	<010C9052C42A00499CE76D637FA5EE900C82A4@039-SN1MPN1-001.039d.mgd.msft.net>
Message-ID: <20110303104902.GE3649@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> > > > > +/* Abort type definition in the command register  */
> > > > > +#define  SDHCI_CMD_ABORTCMD        0xC0
> > > >
> > > > Won't that belong into sd.h (unless I misunderstood your last mail)?
> > > This is the bit definitions of the ABORTCMD CMD-TYPE on the bit6~7 of
> > CMD register.
> > > Here is the definition of the CMD register derived from SDHC spec. FYI.
> > > D15   D14 D13  D08     D07 D06       D05                  D04
> > D03                       D02         D01 D00
> > > Rsvd  Command  Index   Command Type  Data Present Select  Command Index
> > Check Enable   Command CRC Check Enable  Rsvd        Response Type Select
> >
> > Ack, I found that, too. Exactly because it is in the standard, I thought
> > this should rather go into sd.h than sdhci-esdhc-imx.c. Would be a
> > seperate patch, though.
> >
> Do you means the sdhci.h file?
> I find that the sd.h file doesn't contain the bit definitions stuff of SD HOST CONTROLLER registers.
> The sdhci.h file has them, such as:
> #define SDHCI_COMMAND           0x0E
> #define  SDHCI_CMD_RESP_MASK    0x03
> #define  SDHCI_CMD_CRC          0x08
> #define  SDHCI_CMD_INDEX        0x10
> #define  SDHCI_CMD_DATA         0x20

My idea was that it belongs more to the command definitions, thus sd.h.
But as long as there is nothing to be solved at core-level sdhci.h might
do for now as well.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110303/7ac90df5/attachment.sig>
