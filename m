From: a.kesavan@samsung.com (Abhilash Kesavan)
Date: Tue, 28 Oct 2014 16:48:50 +0530
Subject: [PATCH v3 0/5] Add clock support for a few IPs on Exynos7
Message-ID: <1414495135-25588-1-git-send-email-a.kesavan@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Changes since v2:
	- Dropped the dts/arm64 changes and only kept the clock patches so that they
	may be directly applied.
	- Fixed the clock ordering for DOUT_ACLK_CCORE_133.
	- Added a patch that adds support for ADC gate clock as part of this series.

Changes since v1:
	- Added documentation for input clocks of the newly added CMUs

Following are the dependencies:
1) dts, kbuild: Implement support for dtb vendor subdirs patchset 
http://comments.gmane.org/gmane.linux.kbuild.devel/12131
2) arch: arm64: Enable support for Samsung Exynos7 SoC
http://www.spinics.net/lists/linux-samsung-soc/msg37047.html
3) Serial clean-up patches for Exynos7
http://www.spinics.net/lists/arm-kernel/msg367348.html
http://www.spinics.net/lists/arm-kernel/msg367349.html
4) Add initial support for pinctrl on Exynos7
http://www.spinics.net/lists/linux-samsung-soc/msg37708.html

For testing I have applied the following:
1) mmc: dw_mmc: Add IDMAC 64-bit address mode support
http://www.spinics.net/lists/kernel/msg1842300.html
2) mfd: sec: add S2MPS15 PMIC support
https://lkml.org/lkml/2014/10/14/50
3) regulator: s2mps11: add support for S2MPS15 regulators
https://lkml.org/lkml/2014/10/14/52
4) Regulators dt nodes were added in the espresso dts file and I2C channel 4
which has the PMIC on it was tested.
5) watchdog: s3c2410_wdt: Fix the mask bit offset for Exynos7
http://www.spinics.net/lists/linux-watchdog/msg05292.html

Abhilash Kesavan (1):
  clk: samsung: exynos7: add gate clock for ADC block

Naveen Krishna Ch (4):
  clk: samsung: exynos7: add clocks for I2C block
  clk: samsung: exynos7: add clocks for MMC block
  clk: samsung: exynos7: add clocks for RTC block
  clk: samsung: exynos7: add gate clocks for WDT, TMU and PWM blocks

 .../devicetree/bindings/clock/exynos7-clock.txt    |   26 ++
 drivers/clk/samsung/clk-exynos7.c                  |  318 ++++++++++++++++++++
 include/dt-bindings/clock/exynos7-clk.h            |   51 +++-
 3 files changed, 391 insertions(+), 4 deletions(-)

-- 
1.7.9.5
