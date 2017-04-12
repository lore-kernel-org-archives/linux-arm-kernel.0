From: broonie@kernel.org (Mark Brown)
Date: Wed, 12 Apr 2017 17:16:32 +0100
Subject: [PATCH 6/6] regulator: anatop: set default voltage selector for
 pcie
In-Reply-To: <1492013514.15082.35.camel@pengutronix.de>
References: <1491962327-12477-1-git-send-email-aisheng.dong@nxp.com>
 <1491962327-12477-6-git-send-email-aisheng.dong@nxp.com>
 <20170411204003.avoe5a6o52kx5on2@sirena.org.uk>
 <20170413074103.GC23163@b29396-OptiPlex-7040>
 <1492013514.15082.35.camel@pengutronix.de>
Message-ID: <20170412161631.d45jtyqgcky2cqxm@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 12, 2017 at 06:11:54PM +0200, Lucas Stach wrote:
> Am Donnerstag, den 13.04.2017, 15:41 +0800 schrieb Dong Aisheng:

> > The default voltage 1.100v this patch sets is defined in reference
> > manual.

> Huh? Shouldn't regulator_enable bring the voltage in a range defined by
> the constraints in the DT?

As part of that process it checks what the current voltage is but with
this regulator you can't read the voltage if the regulator is powered
off and we don't just ignore that error.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170412/ec7a844c/attachment.sig>
