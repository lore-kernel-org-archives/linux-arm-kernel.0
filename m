From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 23 Aug 2012 12:17:41 +0100
Subject: [PATCH 4/7] regulator: anatop-regulator: convert to use
 imx-syscon to access anatop register
In-Reply-To: <20120823071503.GF10057@shlinux2.ap.freescale.net>
References: <1345619928-15446-1-git-send-email-b29396@freescale.com>
 <1345619928-15446-5-git-send-email-b29396@freescale.com>
 <20120822155953.GQ7995@opensource.wolfsonmicro.com>
 <20120823071503.GF10057@shlinux2.ap.freescale.net>
Message-ID: <20120823111741.GX7995@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 23, 2012 at 03:15:04PM +0800, Dong Aisheng wrote:
> On Wed, Aug 22, 2012 at 11:59:53PM +0800, Mark Brown wrote:

> > With the conversion to regmap it'd also be good to convert the driver to
> > use the regmap helper functions for enable and voltage operations if
> > possible.

> The anatop-regulator driver only implements set_voltage_sel/get_voltage_sel
> which i have already converted, what do you mean others like
> 'for enable and voltage operations' i should also convert?

Those operations should ideally be converted to use the generic regmap
implementation now the device uses regmap - regmap_get_voltage_sel_regmap
and so on.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120823/05ca2fe8/attachment.sig>
