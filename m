From: florian.vaussard@epfl.ch (Florian Vaussard)
Date: Fri, 31 May 2013 14:42:18 +0200
Subject: [PATCH 0/4] ARM: dts: AM3XXX: Use preprocessor for device trees
Message-ID: <1370004142-30506-1-git-send-email-florian.vaussard@epfl.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

Following my series for OMAP2+, this series makes use of the C preprocessor
when compiling AM3XXX DT files, and accomplishes some improvements to improve
overall readability.

The .dtb files were diff-tested before and after applying the series to
guarantee identity for all targets.

For the am335x boards, I spotted a few output pins with pullup selected, but
not enabled. Although it seems a bit strange to me, I left the state
untouched. Has someone a rational for this? Is the pullup later activated?
Or is it unintentional?

This series depends on my previous series "ARM: dts: OMAP2+: Use preprocessor
for device trees", itself based on Benoit's for_3.11/dts branch.

Regards,

Florian

Florian Vaussard (4):
  ARM: dts: AM3XXX: Use #include for all device trees
  ARM: dts: AM33XX: Use existing constants for GPIOs
  ARM: dts: AM33XX: Specific pinctrl header
  ARM: dts: AM33XX: Use pinctrl constants

 arch/arm/boot/dts/am335x-bone.dts       |   28 ++++++++++----------
 arch/arm/boot/dts/am335x-evm.dts        |   44 +++++++++++++++---------------
 arch/arm/boot/dts/am335x-evmsk.dts      |   44 +++++++++++++++---------------
 arch/arm/boot/dts/am33xx.dtsi           |    5 +++-
 arch/arm/boot/dts/am3517-evm.dts        |    2 +-
 arch/arm/boot/dts/am3517_mt_ventoux.dts |    2 +-
 include/dt-bindings/pinctrl/am33xx.h    |   19 +++++++++++++
 7 files changed, 83 insertions(+), 61 deletions(-)
 create mode 100644 include/dt-bindings/pinctrl/am33xx.h

-- 
1.7.5.4
