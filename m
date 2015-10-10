From: wens@csie.org (Chen-Yu Tsai)
Date: Sat, 10 Oct 2015 22:48:55 +0800
Subject: [PATCH v2 0/5] ARM: sunxi: Sinlinx SinA31s support / AXP22x dtsi
 conversion
Message-ID: <1444488540-11263-1-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Maxime,

This is v2 of the Primo81/SinA31s series. I dropped the Primo81 stuff
as it needs more work.

Changes since v1:

  - Requires "ARM: dts: sun6i: hummingbird: Drop AXP221 DC1SW and DC5LDO
    supplies"

  - Dropped already merged patches

  - Dropped Primo81 patch; needs more work to support various device
    bindings

  - Renamed axp221.dtsi to axp22x.dtsi to generalize for AXP223 later on

  - Added "ARM: dts: sun6i: hummingbird: Fix VDD-CPU and VDD-GPU
    regulator names"

  - Added 'ARM: dts: sun6i: hummingbird: Enable AXP221 DC5LDO regulator
    as "vdd-cpus"'

This series adds support for Sinlinx's SinA31s development kit. This
also adds a common axp22x.dtsi, like we have for axp209 and axp152.
This will be used for AXP221/AXP223. The Hummingbird A31 dts is also
migrated to this.

Patch 1 fixes the regulator names for the Hummingbird A31. The CPU
and GPU regulators were mixed up.

Patch 2 adds a common dtsi for the AXP22x family of PMICs. This
includes listing all the regulators, and the basic common properties,
like "interrupt-controller".

Patch 3 migrates the Hummingbird A31 dts to use the new axp221.dtsi

Patch 4 enables the AXP221 DC5LDO regulator on the Hummingbird A31.
This is used to power the embedded controller/processor core.

Patch 5 adds dtsi/dts files for the Sinlinx SinA31s development kit.


Regards
ChenYu

Chen-Yu Tsai (5):
  ARM: dts: sun6i: hummingbird: Fix VDD-CPU and VDD-GPU regulator names
  ARM: dts: sunxi: Add dtsi for AXP22x PMIC
  ARM: dts: sun6i: hummingbird: Use axp22x.dtsi for AXP221 regulators
  ARM: dts: sun6i: hummingbird: Enable AXP221 DC5LDO regulator as
    "vdd-cpus"
  ARM: dts: sun6i: Add support for Sinlinx A31s SDK board

 arch/arm/boot/dts/Makefile                     |   1 +
 arch/arm/boot/dts/axp22x.dtsi                  | 143 +++++++++++++++++++++
 arch/arm/boot/dts/sun6i-a31-hummingbird.dts    | 119 +++++++++---------
 arch/arm/boot/dts/sun6i-a31s-sina31s-core.dtsi | 140 +++++++++++++++++++++
 arch/arm/boot/dts/sun6i-a31s-sina31s.dts       | 167 +++++++++++++++++++++++++
 5 files changed, 513 insertions(+), 57 deletions(-)
 create mode 100644 arch/arm/boot/dts/axp22x.dtsi
 create mode 100644 arch/arm/boot/dts/sun6i-a31s-sina31s-core.dtsi
 create mode 100644 arch/arm/boot/dts/sun6i-a31s-sina31s.dts

-- 
2.5.3
