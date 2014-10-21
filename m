From: a.kesavan@samsung.com (Abhilash Kesavan)
Date: Tue, 21 Oct 2014 11:13:50 +0530
Subject: [PATCH v2 0/7] Add clock and DT support for a few IPs on Exynos7
Message-ID: <1413870237-1821-1-git-send-email-a.kesavan@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

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
2) mmc: dw_mmc: Reset DMA before enabling IDMAC
http://www.gossamer-threads.com/lists/linux/kernel/2021576?page=last
3) drivers: rtc: fix s3c-rtc initialization failure without rtc source clock
https://lkml.org/lkml/2014/10/15/210
4) mfd: sec: add S2MPS15 PMIC support
https://lkml.org/lkml/2014/10/14/50
5) regulator: s2mps11: add support for S2MPS15 regulators
https://lkml.org/lkml/2014/10/14/52
6) Regulators dt nodes were added in the espresso dts file and I2C channel 4
which has the PMIC on it was tested.
7) watchdog: s3c2410_wdt: Fix the mask bit offset for Exynos7
http://www.spinics.net/lists/linux-watchdog/msg05292.html

Abhilash Kesavan (3):
  arm64: dts: Add PMU DT node for exynos7 SoC
  arm64: dts: Add nodes for mmc, i2c, rtc, watchdog on Exynos7
  arm64: exynos: Enable rtc and watchdog support for Exynos7

Naveen Krishna Ch (4):
  clk: samsung: exynos7: add clocks for I2C block
  clk: samsung: exynos7: add clocks for MMC block
  clk: samsung: exynos7: add clocks for RTC block
  clk: samsung: exynos7: add gate clocks for WDT, TMU and PWM blocks

 .../devicetree/bindings/arm/samsung/pmu.txt        |    1 +
 .../devicetree/bindings/clock/exynos7-clock.txt    |   26 ++
 arch/arm64/Kconfig                                 |    3 +
 arch/arm64/boot/dts/exynos/exynos7-espresso.dts    |   41 +++
 arch/arm64/boot/dts/exynos/exynos7.dtsi            |  261 ++++++++++++++++
 drivers/clk/samsung/clk-exynos7.c                  |  316 ++++++++++++++++++++
 include/dt-bindings/clock/exynos7-clk.h            |   60 +++-
 7 files changed, 699 insertions(+), 9 deletions(-)

-- 
1.7.9.5
