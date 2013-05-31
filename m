From: florian.vaussard@epfl.ch (Florian Vaussard)
Date: Fri, 31 May 2013 14:32:54 +0200
Subject: [PATCH v4 0/5] ARM: dts: OMAP2+: Use preprocessor for device trees
Message-ID: <1370003579-30219-1-git-send-email-florian.vaussard@epfl.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

Following a similar proposal by Stephen Warren for tegra [1], this series
makes use of the C preprocessor when compiling OMAP DT files, and
accomplishes some improvements to improve overall readability.

Patch 1 is a preparation for the rest of the series.
Patch 2 uses existing constants for GPIOs. Patch 3 does the same for
IRQs. Patch 4 creates a new header for OMAP's padmux, and patch 5 uses
it to simplify pinctrl DT.

As for previous versions, the .dtb files were diff-tested before and after
applying the series to guarantee identity for all targets.

The same series for AM3XXX will follow shortly.

Best regards,

Florian

>From v3:
- Rebased on Benoit's for_3.11/dts branch

>From v2: 
- Address Tony's comments (standardize comments, remove OMAP_ prefix)

>From v1: 
- Remove duplicated fix
- Remove OMAP_GPIO macro
- Add pinctrl constants

Florian Vaussard (5):
  ARM: dts: OMAP2+: Use #include for all device trees
  ARM: dts: OMAP2+: Use existing constants for GPIOs
  ARM: dts: OMAP4/5: Use existing constants for IRQs
  ARM: dts: OMAP2+: Header file for pinctrl constants
  ARM: dts: OMAP2+: Use pinctrl constants

 arch/arm/boot/dts/omap2.dtsi              |    5 +-
 arch/arm/boot/dts/omap2420-h4.dts         |    2 +-
 arch/arm/boot/dts/omap2420.dtsi           |    2 +-
 arch/arm/boot/dts/omap2430.dtsi           |    2 +-
 arch/arm/boot/dts/omap3-beagle-xm.dts     |    8 +-
 arch/arm/boot/dts/omap3-beagle.dts        |   34 ++++----
 arch/arm/boot/dts/omap3-devkit8000.dts    |   10 +-
 arch/arm/boot/dts/omap3-evm.dts           |    6 +-
 arch/arm/boot/dts/omap3-igep.dtsi         |   38 ++++----
 arch/arm/boot/dts/omap3-igep0020.dts      |   10 +-
 arch/arm/boot/dts/omap3-igep0030.dts      |   10 +-
 arch/arm/boot/dts/omap3-overo.dtsi        |    4 +-
 arch/arm/boot/dts/omap3-tobi.dts          |    4 +-
 arch/arm/boot/dts/omap3.dtsi              |    5 +-
 arch/arm/boot/dts/omap3430-sdp.dts        |    4 +-
 arch/arm/boot/dts/omap34xx.dtsi           |    2 +-
 arch/arm/boot/dts/omap36xx.dtsi           |    2 +-
 arch/arm/boot/dts/omap4-panda-a4.dts      |   10 +-
 arch/arm/boot/dts/omap4-panda-common.dtsi |   70 ++++++++--------
 arch/arm/boot/dts/omap4-panda-es.dts      |   10 +-
 arch/arm/boot/dts/omap4-panda.dts         |    4 +-
 arch/arm/boot/dts/omap4-sdp-es23plus.dts  |    8 +-
 arch/arm/boot/dts/omap4-sdp.dts           |  126 ++++++++++++++--------------
 arch/arm/boot/dts/omap4-var-som.dts       |    8 +-
 arch/arm/boot/dts/omap4.dtsi              |  118 ++++++++++++++-------------
 arch/arm/boot/dts/omap443x.dtsi           |    2 +-
 arch/arm/boot/dts/omap4460.dtsi           |    6 +-
 arch/arm/boot/dts/omap5-evm.dts           |   92 ++++++++++----------
 arch/arm/boot/dts/omap5.dtsi              |  128 +++++++++++++++--------------
 include/dt-bindings/pinctrl/omap.h        |   50 +++++++++++
 30 files changed, 422 insertions(+), 358 deletions(-)
 create mode 100644 include/dt-bindings/pinctrl/omap.h

-- 
1.7.5.4
