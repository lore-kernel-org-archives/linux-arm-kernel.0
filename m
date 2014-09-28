From: alvin.chen@intel.com (Chen, Alvin)
Date: Sun, 28 Sep 2014 03:23:21 +0000
Subject: [PATCH] SPI: spi-pxa2xx: SPI support for Intel Quark X1000
In-Reply-To: <1411741357.22717.4.camel@linux.intel.com>
References: <1411752349-31490-1-git-send-email-alvin.chen@intel.com>
 <1411752349-31490-2-git-send-email-alvin.chen@intel.com>
 <20140926100832.GE27755@sirena.org.uk>
 <1411741357.22717.4.camel@linux.intel.com>
Message-ID: <4656BEB6164FC34F8171C6538F1A595B2E99710F@SHSMSX101.ccr.corp.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> 
> >
> > > +/*  see Quark SPI data sheet for implementation rationale */ static
> > > +u32 quark_x1000_set_clk_regvals(u32 rate, u32 *dds, u32 *clk_div) {
> >
> > Please document this in the driver - I don't know if this datasheet is
> > public but even if it is it may not stay that way.
> 
> Datasheet is public.
> I'm just wondering if we can use just a formula instead of table.
> 
As I said before, there are two formulas, but for the given rate, from the formulas, we can get a lot of <dds, clk_div> pairs,
and we also need to select them according to the guidelines which is not formula. The table the datasheet given should be
the best one to meet the jitter and duty cycles as the datasheet documented.
