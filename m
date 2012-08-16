From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 16 Aug 2012 15:00:56 +0100
Subject: [PATCH v2 3/4] arm/dts: Add tps65910 regulator DT data to
 am335x-evm.dts
In-Reply-To: <331ABD5ECB02734CA317220B2BBEABC13EA13D18@DBDE01.ent.ti.com>
References: <1343110735-10640-1-git-send-email-anilkumar@ti.com>
 <1343110735-10640-4-git-send-email-anilkumar@ti.com>
 <331ABD5ECB02734CA317220B2BBEABC13EA1293E@DBDE01.ent.ti.com>
 <20120815125338.GA13544@opensource.wolfsonmicro.com>
 <331ABD5ECB02734CA317220B2BBEABC13EA13118@DBDE01.ent.ti.com>
 <20120815165431.GF15365@opensource.wolfsonmicro.com>
 <331ABD5ECB02734CA317220B2BBEABC13EA13D18@DBDE01.ent.ti.com>
Message-ID: <20120816140056.GK15365@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 16, 2012 at 01:22:27PM +0000, AnilKumar, Chimata wrote:

> But problem here is single input supply battery/main is not sufficient.

What makes you say this?

> pmic->desc[i].supply_name = info->vin_name;
> with this assignment regulator core searches for exact supply name vcc1 or
> vcc2 etc if there are no matches then it will not register any regulators. 

Why does this mean you need multiple regulators?  A single regulator can
of course supply multiple devices.
