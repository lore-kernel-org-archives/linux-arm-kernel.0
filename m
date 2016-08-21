From: plaes@plaes.org (Priit Laes)
Date: Sun, 21 Aug 2016 09:51:25 +0300
Subject: [linux-sunxi] [PATCH 0/9] mfd: axp20x: Add support for AXP809 PMIC
In-Reply-To: <20160821021125.1521-1-wens@csie.org>
References: <20160821021125.1521-1-wens@csie.org>
Message-ID: <1471762285.581.1.camel@plaes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 2016-08-21 at 10:11 +0800, Chen-Yu Tsai wrote:
> Hi everyone,
> 
> This series adds support for X-Powers' AXP806 PMIC. This is the
> secondary
> PMIC accompanying Allwinner's A80 SoC. For now, only the regulators
> are
> supported. While the AXP806 supports standalone operation, no
> hardware
> exists, so this will not be supported.

Title says AXP809, but in text and in subsequent patches there's also
806/809 confusion.

> 
> Patch 1 adds AXP806 to the axp20x bindings.
> 
> Patch 2 adds AXP806 support to the axp20x mfd driver.
> 
> Patch 3 fixes regulator output adjustment during regulator
> registration
> so it doesn't fail if the higher or lower bounds of its voltage
> constraints
> don't match up with the regulator's voltage granularity.
> 
> Patch 4 adds AXP806 support to the axp20x regulator driver.
> 
> Patch 5 adds the unused SW switch output of the AXP809 PMIC on the
> A80
> Optimus board. This was accidentally left out of the AXP809 series.
> 
> Patch 6 adds the unused SW switch output of the AXP809 PMIC on the
> Cubieboard 4. This was accidentally left out of the AXP809 series.
> 
> Patch 7 enables AXP809 support on the A80 Optimus board.
> 
> Patch 8 enables AXP809 support on the Cubieboard 4.
> 
> Patch 9 disables EHCI1 on the A80 Optimus board.
> 
> 
> Regards
> ChenYu
> 
> Chen-Yu Tsai (9):
> ? mfd: axp20x: Add bindings for AXP806 PMIC
> ? mfd: axp20x: Add support for AXP806 PMIC
> ? regulator: core: Try full range when adjusting regulators to
> ????constraints
> ? regulator: axp20x: support AXP806 variant
> ? ARM: dts: sun9i: a80-optimus: Declare AXP809 SW regulator as unused
> ? ARM: dts: sun9i: cubieboard4: Declare AXP809 SW regulator as unused
> ? ARM: dts: sun9i: a80-optimus: Add AXP806 PMIC device node and
> ????regulators
> ? ARM: dts: sun9i: cubieboard4: Add AXP806 PMIC device node and
> ????regulators
> ? ARM: dts: sun9i: a80-optimus: Disable EHCI1
> 
> ?Documentation/devicetree/bindings/mfd/axp20x.txt |??28 +++++-
> ?arch/arm/boot/dts/sun9i-a80-cubieboard4.dts??????| 116
> +++++++++++++++++++++
> ?arch/arm/boot/dts/sun9i-a80-optimus.dts??????????| 123
> ++++++++++++++++++++++-
> ?drivers/mfd/axp20x-rsb.c?????????????????????????|???1 +
> ?drivers/mfd/axp20x.c?????????????????????????????|??72 +++++++++++++
> ?drivers/regulator/axp20x-regulator.c?????????????| 117
> +++++++++++++++++++--
> ?drivers/regulator/core.c?????????????????????????|???8 +-
> ?include/linux/mfd/axp20x.h???????????????????????|??60 +++++++++++
> ?8 files changed, 508 insertions(+), 17 deletions(-)
> 
> --?
> 2.9.3
> 
