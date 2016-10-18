From: ayaka@soulik.info (Randy Li)
Date: Wed, 19 Oct 2016 01:18:47 +0800
Subject: [PATCH v9 0/2] Add a new board TOPEET iTOP for Exynos 4412
In-Reply-To: <devicetree@vger.kernel.org>
References: <devicetree@vger.kernel.org>
Message-ID: <1476811129-4450-1-git-send-email-ayaka@soulik.info>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Changelog:
 - v9:
   - fix some warnings.
   - use the new pin defined for pinctrl.
 - v8:
   - add the missing LDOs for PMIC, the pins for LDOs are not avaiabled in core
     board.
   - re-order the header files in core board.
   - skip the vendor prefix file
 - v7:
   - add a missing header file
   - add a rootdelay to bootargs or it can't mount root filesystem
   - fix the memory node
 - v6:
   - move pwms pinctrl to pwms node
   - fix the order of the dtb file in Makefile
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
   - suuport the audio codec at elite board, but the audio sound a little 
     distortion
   - fixing minor bugs in the last commit
 - v2:
   - removing rtc node
     the clock source driver is not done yet.
   - adding exynos-bus
   - fixing the MFC

Randy Li (2):
  ARM: dts: Add TOPEET itop core board SCP package version
  ARM: dts: add TOPEET itop elite based board

 .../bindings/arm/samsung/samsung-boards.txt        |   3 +
 arch/arm/boot/dts/Makefile                         |   1 +
 arch/arm/boot/dts/exynos4412-itop-elite.dts        | 240 ++++++++++
 arch/arm/boot/dts/exynos4412-itop-scp-core.dtsi    | 501 +++++++++++++++++++++
 4 files changed, 745 insertions(+)
 create mode 100644 arch/arm/boot/dts/exynos4412-itop-elite.dts
 create mode 100644 arch/arm/boot/dts/exynos4412-itop-scp-core.dtsi

-- 
2.7.4
