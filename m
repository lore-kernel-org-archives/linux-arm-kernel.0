From: ayaka@soulik.info (Randy Li)
Date: Thu,  8 Sep 2016 05:58:52 +0800
Subject: [PATCH v6 0/3] Add a new board TOPEET iTOP for Exynos 4412
Message-ID: <1473285535-21996-1-git-send-email-ayaka@soulik.info>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Changelog:
  v6:
    move pwms pinctrl to pwms node
    fix the order of the dtb file in Makefile
 - v5:
   - correct the mail format
 - v4:
   - re-order some nodes in alphabetical order
   - fix some minor bugs
   - add a entry in vendor list
 - v3:
   - fixing the rtc clock, using clock source from PMIC
   - enable the tmu
   - enable the fimc for elite board
   - suuport the audio codec at elite board
   - fixing minor bugs in the last commit
 - v2:
   - removing rtc node
     the clock source driver is not done yet.
   - adding exynos-bus
   - fixing the MFC

Randy Li (3):
  ARM: dts: Add TOPEET itop core board SCP package version
  ARM: dts: add TOPEET itop elite based board
  devicetree: bindings: Add vendor prefix for Topeet.

 .../bindings/arm/samsung/samsung-boards.txt        |   3 +
 .../devicetree/bindings/vendor-prefixes.txt        |   1 +
 arch/arm/boot/dts/Makefile                         |   1 +
 arch/arm/boot/dts/exynos4412-itop-elite.dts        | 239 ++++++++++
 arch/arm/boot/dts/exynos4412-itop-scp-core.dtsi    | 490 +++++++++++++++++++++
 5 files changed, 734 insertions(+)
 create mode 100644 arch/arm/boot/dts/exynos4412-itop-elite.dts
 create mode 100644 arch/arm/boot/dts/exynos4412-itop-scp-core.dtsi

-- 
2.7.4
