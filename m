From: w.sang@pengutronix.de (Wolfram Sang)
Date: Tue, 27 Mar 2012 11:45:45 +0200
Subject: [MX25][MMC] mmc esdhc failure in 3.3
In-Reply-To: <7f2ae9e3800848e140461a0506808fb4@mail.fqingenieria.es>
References: <20120312132423.GC2459@pengutronix.de>
 <9018463dfcd3c9e9a311aeed42b758bf@mail.fqingenieria.es>
 <0E83723C55F66F43A6041464FE31119D099A34@039-SN2MPN1-011.039d.mgd.msft.net>
 <a06e68c3687c7390e15950bc20831fd4@mail.fqingenieria.es>
 <85b807b77d73328485781d6fa1568e46@mail.fqingenieria.es>
 <20120327101259.73525f9d@eb-e6520>
 <ac05d6e5c1ce4bf9cfc5c28d235f866f@mail.fqingenieria.es>
 <20120327090148.GB6790@pengutronix.de>
 <20120327110615.3bfaf969@eb-e6520>
 <7f2ae9e3800848e140461a0506808fb4@mail.fqingenieria.es>
Message-ID: <20120327094545.GE6790@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> Might be unrelated, however I have been keeping my eyes on the fix
> of ENGcm07207 quirk introduced with 16a790bcc. According to the
> IMX25CE.pdf, to abort data transfers on the AHB, software can reset
> the eSDHC by writing 1 to SYSCTL[24] (RSTA), which currently is not
> done with SDHCI_QUIRK_NO_MULTIBLOCK. It sets the max_blk_count to 1
> instead of 65535. Not sure if this is also limiting the speed.

Oh, it is limiting speed, for sure.

SDHCI_QUIRK_NO_MULTIBLOCK is a _generic_ quirk which can be enabled by
various buggy sdhci implementations, not only esdhc (which is pretty
good at being buggy). It is not there to fix MX25 specific issues,
that would have to be done seperately in sdhci-esdhc-imx.c.

So, the above quirk is a big hammer solution. There might be more
precise ones, but those still would have to be developed. I don't know
of anyone planning to do this.

Regards,

   Wolfram

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120327/c71d2935/attachment-0001.sig>
