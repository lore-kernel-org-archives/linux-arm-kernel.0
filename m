From: wens@csie.org (Chen-Yu Tsai)
Date: Fri, 28 Aug 2015 17:54:33 +0800
Subject: [PATCH 0/6] ARM: sunxi: Support MSI Primo81 tablet and Sinlinx SinA31s
Message-ID: <1440755679-8266-1-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Maxime,

This series adds support for MSI's Primo81 tablet, and Sinlinx's SinA31s
development kit. This also adds a common axp221.dtsi, like we have for
axp209 and axp152. The Hummingbird A31 dts is also migrated to this.

The Primo81 patch is actually a v5. Changes since the last version can
be found in that patch.

Patch 1 adds an lradc node to sun6i-a31.dtsi. This is the same lradc
for tablet buttons found on the other sunxi SoCs.

Patch 2 adds a common dtsi for the AXP221 PMIC. This includes listing
all the regulators, and the basic common properties, like
"interrupt-controller".

Patch 3 migrates the Hummingbird A31 dts to use the new axp221.dtsi

Patch 4 adds the pinmux settings for A31/A31s mmc2 with 8-bit bus for
emmc.

Patch 5 adds dtsi/dts files for the Sinlinx SinA31s development kit.

Patch 6 adds a dts file for the A31s based MSI Primo81 tablet.


Regards
ChenYu

Chen-Yu Tsai (5):
  ARM: dts: sun6i: Add lradc node
  ARM: dts: sunxi: Add dtsi for AXP221 PMIC
  ARM: dts: sun6i: hummingbird: Use axp221.dtsi for axp221 regulators
  ARM: dts: sun6i: Add mmc2 pins for 8 bit emmc
  ARM: dts: sun6i: Add support for Sinlinx A31s SDK board

Karsten Merker (1):
  ARM: dts: sun6i: Add dts file for MSI Primo81 tablet

 arch/arm/boot/dts/Makefile                     |   4 +-
 arch/arm/boot/dts/axp221.dtsi                  | 148 ++++++++++++++
 arch/arm/boot/dts/sun6i-a31-hummingbird.dts    | 114 ++++++-----
 arch/arm/boot/dts/sun6i-a31.dtsi               |  17 ++
 arch/arm/boot/dts/sun6i-a31s-primo81.dts       | 255 +++++++++++++++++++++++++
 arch/arm/boot/dts/sun6i-a31s-sina31s-core.dtsi | 131 +++++++++++++
 arch/arm/boot/dts/sun6i-a31s-sina31s.dts       | 149 +++++++++++++++
 7 files changed, 759 insertions(+), 59 deletions(-)
 create mode 100644 arch/arm/boot/dts/axp221.dtsi
 create mode 100644 arch/arm/boot/dts/sun6i-a31s-primo81.dts
 create mode 100644 arch/arm/boot/dts/sun6i-a31s-sina31s-core.dtsi
 create mode 100644 arch/arm/boot/dts/sun6i-a31s-sina31s.dts

-- 
2.5.0
