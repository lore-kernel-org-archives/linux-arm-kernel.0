From: nm@ti.com (Nishanth Menon)
Date: Fri, 22 Aug 2014 09:03:49 -0500
Subject: [PATCH 0/6] ARM: dts: OMAP5+: Fixes for pinctrl support 
Message-ID: <1408716235-26164-1-git-send-email-nm@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following series add the missing dts changes needed for pinctrl to
finally work on OMAP5/DRA7.

This is part 6/6 series which eventually enables framework for
suspend-to-ram and cpuidle for OMAP5 and DRA7.

Depends on previous series for pinctrl and PRM fixes for
functionality, but is capable of continuing to provide older
functionality with older zImage

NOTE: Various hwmod and dts fixes for various other IP blocks are
still pending for complete suspend functionality.

Each of series is based on v3.17-rc1 and this specific series is available:
weblink: https://github.com/nmenon/linux-2.6-playground/commits/push/v3.17/dts-fixes

git repo: https://github.com/nmenon/linux-2.6-playground.git push/v3.17/dts-fixes

An complete integrated branch is available here: https://github.com/nmenon/linux-2.6-playground/commits/testing/v3.17/cpu-idle-suspend-dra7-omap5-framework

Nishanth Menon (6):
  ARM: dts: OMAP3+: Add PRM interrupt
  ARM: dts: OMAP5: switch to compatible pinctrl
  ARM: dts: DRA7: switch to compatible pinctrl
  ARM: dts: AM437x: switch to compatible pinctrl
  ARM: dts: OMAP5/DRA7: switch over to interrupts-extended property for
    UART
  ARM: dts: dra7-evm: Mark uart1 rxd as wakeup capable

 arch/arm/boot/dts/am4372.dtsi  |    4 +++-
 arch/arm/boot/dts/dra7-evm.dts |    2 ++
 arch/arm/boot/dts/dra7.dtsi    |   25 ++++++++++++++-----------
 arch/arm/boot/dts/omap3.dtsi   |    1 +
 arch/arm/boot/dts/omap4.dtsi   |    1 +
 arch/arm/boot/dts/omap5.dtsi   |   21 +++++++++++++--------
 6 files changed, 34 insertions(+), 20 deletions(-)

-- 
1.7.9.5
