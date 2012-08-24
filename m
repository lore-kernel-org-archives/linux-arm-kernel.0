From: b29396@freescale.com (Dong Aisheng)
Date: Fri, 24 Aug 2012 10:28:09 +0800
Subject: [PATCH 1/7] mfd: add imx syscon driver based on regmap
In-Reply-To: <20120823110647.GU7995@opensource.wolfsonmicro.com>
References: <1345619928-15446-1-git-send-email-b29396@freescale.com>
 <1345619928-15446-2-git-send-email-b29396@freescale.com>
 <20120822160241.GR7995@opensource.wolfsonmicro.com>
 <20120823072629.GG10057@shlinux2.ap.freescale.net>
 <20120823110647.GU7995@opensource.wolfsonmicro.com>
Message-ID: <20120824022807.GA5822@shlinux2.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 23, 2012 at 07:06:47PM +0800, Mark Brown wrote:
> On Thu, Aug 23, 2012 at 03:26:30PM +0800, Dong Aisheng wrote:
> > On Thu, Aug 23, 2012 at 12:02:41AM +0800, Mark Brown wrote:
> 
> > > It'd be good to provide a way of retrieving the regmap so that drivers
> > > for subsystems with generic regmap code could use the framework features
> > > (regulator is one example that I just mentioned in my other mail).
> 
> > Do you mean something like:
> > regmap = syscon_regmap_dev_lookup(np, "fsl,anatop");
> > regmap_write(regmap, reg, val);
> 
> > Then drivers can use generic regmap framework features rather than depend
> > on what imx-syscon implemented, is that correct?
> 
> Yes, this is mainly for cases where the subsystem has helper functions
> that can work with regmap.

Okay, then imx-syscon only implements regmap register mechanism and regmap
lookup mechanism, for accessors, client driver can directly use the generic
regmap API defined in include/linux/regmap.h.

Then it looks to me the driver is more like a generic feature which may also be
needed for other SoCs, IIRC, Tegra ahb and ux500 PRCMU,

Do you think if we should implement it in a more generic way at first?
e.g, drop 'imx-' prefix first.

Linus,
You're the first guy to raise the idea that we could implement a syscon
framework to generic register access, what's your comment on this?

Regards
Dong Aisheng
