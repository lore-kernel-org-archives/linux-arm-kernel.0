From: anilkumar@ti.com (AnilKumar, Chimata)
Date: Wed, 15 Aug 2012 16:47:02 +0000
Subject: [PATCH v2 3/4] arm/dts: Add tps65910 regulator DT data to
 am335x-evm.dts
In-Reply-To: <20120815125338.GA13544@opensource.wolfsonmicro.com>
References: <1343110735-10640-1-git-send-email-anilkumar@ti.com>
 <1343110735-10640-4-git-send-email-anilkumar@ti.com>
 <331ABD5ECB02734CA317220B2BBEABC13EA1293E@DBDE01.ent.ti.com>
 <20120815125338.GA13544@opensource.wolfsonmicro.com>
Message-ID: <331ABD5ECB02734CA317220B2BBEABC13EA13118@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On Wed, Aug 15, 2012 at 18:23:39, Mark Brown wrote:
> On Tue, Aug 14, 2012 at 02:25:18PM +0000, AnilKumar, Chimata wrote:
> 
> > AM335x EVM have one dedicated input supply which provide supplies to all
> > the PMIC regulators. According to tps65910 "VDD1 regulator" input supply
> > is from vcc1 so we have to create a dummy/parent/some node to handle this.
> > Example below has the details.
> 
> Your device tree should accurately reflect the hardware.
> 
> > Similarly we have to add 7 more fixed regulators entries to provide input
> > supply to different PMIC regulators.
> 
> If you have all these unrelated supplies in the system then your device
> tree should accurately reflect that.  However this would be a very

In that case I have to add all these fixed regulators.

> unusual hardware design.  Usually there would be a very small set of
> system supply rails, frequently only one.

In case of AM335X-EVM one dedicated supply (5v) feeding to all the input
supplies (vcc1-7 and vccio) of the regulators.

tps65910 PMIC have vcc1-7 and vccio input supplies which are feeding to
all the regulators. (like one - one and one - many).

Tps65910 regulator drivers registration fails if we not providing the
correct input supply with supply name. One option I can see is that
fixed voltage regulators. If we do this then total 21 (8 input supply
fixed regulators and others are out regulators) are present in the system.

If this is the correct approach then I will submit next version of patch.

Thanks
AnilKumar
