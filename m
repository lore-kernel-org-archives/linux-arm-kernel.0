From: a.kesavan@samsung.com (Abhilash Kesavan)
Date: Sun, 27 Apr 2014 02:08:40 +0530
Subject: [PATCH RFC 0/8] Devfreq support for Exynos5250/5420
Message-ID: <1398544728-2075-1-git-send-email-a.kesavan@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset adds devfreq support on Exynos5250 and Exynos5420.
The patches add the missing INT clock support for exynos5250 and
also add a new 5420 driver. We also have patches which add the PPMU
node and fix a typo in the exynos5250 driver.

The patches have been tested on Exynos5250 based Snow board and SMDK5420
EVT1 boards. They have been prepared on linux-next(20140424) with the
devfreq for-next branch and Shaik Ameer Basha's clock cleanup patches
merged (http://www.spinics.net/lists/arm-kernel/msg325313.html).

There are a couple of concerns with these patches:
1) The patches are using clock aliases to expose the required clocks to the
devfreq driver.
2) The patches are making use of different compatible strings for the PPMU
node to differentiate between multiple SoCs even though the PPMU is the same.

Kindly suggest a way to move forward with respect to the above.

Abhilash Kesavan (4):
  ARM: dts: Add PPMU device tree support for Exynos5250
  ARM: dts: Add PPMU device tree support for Exynos5420
  PM / devfreq: exynos: Fix typo in macro
  PM / devfreq: Rename the exynos5250 devfreq driver

Andrew Bresticker (2):
  clk: exynos5250: add aliases for clocks used by devfreq
  PM / devfreq: exynos5250: migrate to common-clock

Arjun.K.V (2):
  clk: exynos5420: Add aliases for clocks used by devfreq
  PM / devfreq: Add devfreq driver for Exynos5420

 .../bindings/arm/exynos/ppmu-exynos5.txt           |  29 +
 arch/arm/boot/dts/exynos5250.dtsi                  |   9 +
 arch/arm/boot/dts/exynos5420.dtsi                  |   7 +
 drivers/clk/samsung/clk-exynos5250.c               |  30 +-
 drivers/clk/samsung/clk-exynos5420.c               |  77 ++-
 drivers/devfreq/Kconfig                            |  13 +-
 drivers/devfreq/Makefile                           |   3 +-
 drivers/devfreq/exynos/Makefile                    |   6 +-
 .../exynos/{exynos5_bus.c => exynos5250_bus.c}     | 131 +++-
 drivers/devfreq/exynos/exynos5420_bus.c            | 706 +++++++++++++++++++++
 drivers/devfreq/exynos/exynos_ppmu.h               |   2 +-
 11 files changed, 961 insertions(+), 52 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/exynos/ppmu-exynos5.txt
 rename drivers/devfreq/exynos/{exynos5_bus.c => exynos5250_bus.c} (80%)
 create mode 100644 drivers/devfreq/exynos/exynos5420_bus.c

-- 
1.8.3.2
