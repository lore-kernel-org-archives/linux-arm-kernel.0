From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 2 Jul 2012 11:03:25 +0100
Subject: [PATCH 1/3] mfd: support 88pm80x in 80x driver
In-Reply-To: <4FF1685A.9070506@marvell.com>
References: <1340853214-5429-1-git-send-email-zhouqiao@marvell.com>
 <201206281121.56769.arnd@arndb.de> <4FED196D.6090500@marvell.com>
 <201206291358.28788.arnd@arndb.de> <4FF152D3.9040706@marvell.com>
 <4FF1685A.9070506@marvell.com>
Message-ID: <20120702100324.GC25093@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 02, 2012 at 05:22:34PM +0800, Qiao Zhou wrote:
> On 07/02/2012 03:50 PM, Qiao Zhou wrote:

> >Here I have a question about the implementation specifically with
> >88pm800. this chip has 3 register pages, and 3 i2c address corresponding
> >to each page. so it requires an additional parameter to point out the
> >page(i2c) to be accessed. currently I didn't think of a good API to
> >export for such purpose. seems to me, the 88pm800 chip is already bound
> >to i2c interface, and using regmap directly is a better solution. could
> >you give some suggestions?

> is it OK to export another two groups of r/w interface for gpadc and
> power page separately in 88pm800? such as pm800_gpadc_read_reg() /
> pm800_power_read_reg() etc?  Appreciate any comments.

What do you mean by pages?  regmap has paging support which just maps
everything into a single flat register map from the point of view of
callers.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120702/6fd60484/attachment.sig>
