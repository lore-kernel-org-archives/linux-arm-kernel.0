From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 15 Aug 2012 13:53:39 +0100
Subject: [PATCH v2 3/4] arm/dts: Add tps65910 regulator DT data to
 am335x-evm.dts
In-Reply-To: <331ABD5ECB02734CA317220B2BBEABC13EA1293E@DBDE01.ent.ti.com>
References: <1343110735-10640-1-git-send-email-anilkumar@ti.com>
 <1343110735-10640-4-git-send-email-anilkumar@ti.com>
 <331ABD5ECB02734CA317220B2BBEABC13EA1293E@DBDE01.ent.ti.com>
Message-ID: <20120815125338.GA13544@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 14, 2012 at 02:25:18PM +0000, AnilKumar, Chimata wrote:

> AM335x EVM have one dedicated input supply which provide supplies to all
> the PMIC regulators. According to tps65910 "VDD1 regulator" input supply
> is from vcc1 so we have to create a dummy/parent/some node to handle this.
> Example below has the details.

Your device tree should accurately reflect the hardware.

> Similarly we have to add 7 more fixed regulators entries to provide input
> supply to different PMIC regulators.

If you have all these unrelated supplies in the system then your device
tree should accurately reflect that.  However this would be a very
unusual hardware design.  Usually there would be a very small set of
system supply rails, frequently only one.
