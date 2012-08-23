From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 23 Aug 2012 12:06:47 +0100
Subject: [PATCH 1/7] mfd: add imx syscon driver based on regmap
In-Reply-To: <20120823072629.GG10057@shlinux2.ap.freescale.net>
References: <1345619928-15446-1-git-send-email-b29396@freescale.com>
 <1345619928-15446-2-git-send-email-b29396@freescale.com>
 <20120822160241.GR7995@opensource.wolfsonmicro.com>
 <20120823072629.GG10057@shlinux2.ap.freescale.net>
Message-ID: <20120823110647.GU7995@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 23, 2012 at 03:26:30PM +0800, Dong Aisheng wrote:
> On Thu, Aug 23, 2012 at 12:02:41AM +0800, Mark Brown wrote:

> > It'd be good to provide a way of retrieving the regmap so that drivers
> > for subsystems with generic regmap code could use the framework features
> > (regulator is one example that I just mentioned in my other mail).

> Do you mean something like:
> regmap = syscon_regmap_dev_lookup(np, "fsl,anatop");
> regmap_write(regmap, reg, val);

> Then drivers can use generic regmap framework features rather than depend
> on what imx-syscon implemented, is that correct?

Yes, this is mainly for cases where the subsystem has helper functions
that can work with regmap.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120823/0ada1439/attachment.sig>
