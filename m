From: florian.vaussard@epfl.ch (Florian Vaussard)
Date: Mon,  3 Jun 2013 16:12:21 +0200
Subject: [PATCH v2 0/4] ARM: dts: AM3XXX: Use preprocessor for device trees
Message-ID: <1370268745-15860-1-git-send-email-florian.vaussard@epfl.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

Following my series for OMAP2+, this series makes use of the C preprocessor
when compiling AM3xxx DT files, and accomplishes some improvements to improve
overall readability.

The .dtb files were diff-tested before and after applying the series to
guarantee identity for all targets.

To enable pullup/down on the pad, the bit should be cleared on AM33xx, where
it should be set on OMAP3. This was wrong in my first version.

This series is based on Benoit's 'for_3.11/dts' branch.

Regards,

Florian

>From v2:
- Rebased on Benoit's 'for_3.11/dts'
- Fixed inversed bit to enable pullups ('1' on OMAP, but '0' on AM33xx)

Florian Vaussard (4):
  ARM: dts: AM3XXX: Use #include for all device trees
  ARM: dts: AM33XX: Use existing constants for GPIOs
  ARM: dts: AM33XX: Specific pinctrl header
  ARM: dts: AM33XX: Use pinctrl constants

 arch/arm/boot/dts/am335x-bone.dts       |   28 ++++++------
 arch/arm/boot/dts/am335x-evm.dts        |   76 +++++++++++++++---------------
 arch/arm/boot/dts/am335x-evmsk.dts      |   46 +++++++++---------
 arch/arm/boot/dts/am33xx.dtsi           |    5 ++-
 arch/arm/boot/dts/am3517-evm.dts        |    2 +-
 arch/arm/boot/dts/am3517_mt_ventoux.dts |    2 +-
 include/dt-bindings/pinctrl/am33xx.h    |   37 +++++++++++++++
 7 files changed, 118 insertions(+), 78 deletions(-)
 create mode 100644 include/dt-bindings/pinctrl/am33xx.h

-- 
1.7.5.4
