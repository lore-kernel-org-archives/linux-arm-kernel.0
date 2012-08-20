From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 20 Aug 2012 21:07:15 +0100
Subject: [PATCH v2 3/4] arm/dts: Add tps65910 regulator DT data to
 am335x-evm.dts
In-Reply-To: <331ABD5ECB02734CA317220B2BBEABC13EA19A81@DBDE01.ent.ti.com>
References: <1343110735-10640-1-git-send-email-anilkumar@ti.com>
 <1343110735-10640-4-git-send-email-anilkumar@ti.com>
 <331ABD5ECB02734CA317220B2BBEABC13EA1293E@DBDE01.ent.ti.com>
 <20120815125338.GA13544@opensource.wolfsonmicro.com>
 <331ABD5ECB02734CA317220B2BBEABC13EA13118@DBDE01.ent.ti.com>
 <20120815165431.GF15365@opensource.wolfsonmicro.com>
 <331ABD5ECB02734CA317220B2BBEABC13EA13D18@DBDE01.ent.ti.com>
 <20120816140056.GK15365@opensource.wolfsonmicro.com>
 <331ABD5ECB02734CA317220B2BBEABC13EA19A81@DBDE01.ent.ti.com>
Message-ID: <20120820200715.GT26991@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 20, 2012 at 06:27:01AM +0000, AnilKumar, Chimata wrote:
> On Thu, Aug 16, 2012 at 19:30:56, Mark Brown wrote:

> > Why does this mean you need multiple regulators?  A single regulator can
> > of course supply multiple devices.

> I got your point but tps65910 driver is failing if we add single fixed
> regulator. Solution is driver needs to change or add multiple fixed
> regulators.

No, really.  One regulator can supply many things, not being a.

> vrtc:
> tps65910 0-002d: Failed to find supply vcc7
> tps65910 0-002d: failed to register tps65910-pmic regulator

So you've specified a whole bunch of supplies and this one individual
supply is not matching (and it's not the first...).  You should
investigate what's gone wrong there rather than bodging around the
problem.  I can't immediately say anything much based on the information
you've given.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120820/4e98778b/attachment.sig>
