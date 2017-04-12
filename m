From: l.stach@pengutronix.de (Lucas Stach)
Date: Wed, 12 Apr 2017 18:11:54 +0200
Subject: [PATCH 6/6] regulator: anatop: set default voltage selector for
 pcie
In-Reply-To: <20170413074103.GC23163@b29396-OptiPlex-7040>
References: <1491962327-12477-1-git-send-email-aisheng.dong@nxp.com>
 <1491962327-12477-6-git-send-email-aisheng.dong@nxp.com>
 <20170411204003.avoe5a6o52kx5on2@sirena.org.uk>
 <20170413074103.GC23163@b29396-OptiPlex-7040>
Message-ID: <1492013514.15082.35.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Donnerstag, den 13.04.2017, 15:41 +0800 schrieb Dong Aisheng:
> On Tue, Apr 11, 2017 at 09:40:03PM +0100, Mark Brown wrote:
> > On Wed, Apr 12, 2017 at 09:58:47AM +0800, Dong Aisheng wrote:
> > > Set the initial voltage selector for vddpcie in case it's disabled
> > > by default.
> > 
> > Why is this the only anatop regulator which can have this problem and
> > how do we know this is a good value?
> 
> Anatop regulator has no separate gate bit.
> e.g.
> 00000 Power gated off
> 00001 Target core voltage = 0.725V
> ...
> So it may have no valid default voltage in case it's disabled in
> bootloader.
> e.g. regulator_enable() may not work.
> 
> The default voltage 1.100v this patch sets is defined in reference
> manual.

Huh? Shouldn't regulator_enable bring the voltage in a range defined by
the constraints in the DT?

Regards,
Lucas
