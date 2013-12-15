From: kgene.kim@samsung.com (Kukjin Kim)
Date: Mon, 16 Dec 2013 05:22:50 +0900
Subject: [GIT PULL 6/7] Samsung DT for v3.14
Message-ID: <52AE0F9A.3010407@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 6ce4eac1f600b34f2f7f58f9cd8f0503d79e42ae:

   Linux 3.13-rc1 (2013-11-22 11:30:55 -0800)

are available in the git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git 
tags/samsung-dt

for you to fetch changes up to e0b51c2eae8ebf10d80530b7a306818252206325:

   ARM: dts: Update Samsung sysreg binding document (2013-12-16 04:47:38 
+0900)

----------------------------------------------------------------
Samsung DT updates for v3.14
- Add support Octa Cores for exynos5420
   : populate CPU node entries to 8 Cores
   : extend mct to support 8 local interrupts
- Update dwmmc nodes for exynos5250 and exynos5420
   : change status property of dwmmc nodes for exynos5250
   : move dwmmc nodes from exynos5 to exynos5250 because
     it's different between exynos5250 and exynos5420
   : rename mmc nodes from dwmmc for exynos5 SoCs
   : add dwmmc nodes for exynos5420
- Add G-Scaler nodes for exynos5420
- Add HS-i2c nodes in exynos5420
   : High Speed I2C 7 channels (4 to 10)
- Update sysreg binding and node name in exynos4
- Update min voltage on exynos5250-arndale
- Move fifo-depth property from boards to exynos5250 SoC
   : because the fifo-depth property is SoC specific

----------------------------------------------------------------
Chander Kashyap (2):
       clocksource: mct: extend mct to support 8 local interrupts for 
Exynos5420
       ARM: dts: populate cpu node entries to 8 cpus for exynos5420

Leela Krishna Amudala (1):
       ARM: dts: Add device nodes for GScaler blocks for exynos5420

Sachin Kamat (4):
       ARM: dts: Update min voltage for vdd_arm on Arndale
       ARM: dts: Add hs-i2c nodes to exynos5420
       ARM: dts: Fix sysreg node name in exynos4.dtsi
       ARM: dts: Update Samsung sysreg binding document

Yuvaraj Kumar C D (5):
       ARM: dts: Move dwmmc nodes from exynos5.dtsi to exynos5250.dtsi
       ARM: dts: change status property of dwmmc nodes for exynos5250
       ARM: dts: Move fifo-depth property from exynos5250 board dts
       ARM: dts: rename mmc dts node for exynos5 series
       ARM: dts: Add dwmmc DT nodes for exynos5420 SOC

  .../devicetree/bindings/arm/samsung/sysreg.txt     |   7 +-
  .../devicetree/bindings/mmc/exynos-dw-mshc.txt     |   2 +
  arch/arm/boot/dts/cros5250-common.dtsi             |  11 +-
  arch/arm/boot/dts/exynos4.dtsi                     |   2 +-
  arch/arm/boot/dts/exynos5.dtsi                     |  21 ---
  arch/arm/boot/dts/exynos5250-arndale.dts           |  18 +-
  arch/arm/boot/dts/exynos5250-smdk5250.dts          |  16 +-
  arch/arm/boot/dts/exynos5250-snow.dts              |   2 +-
  arch/arm/boot/dts/exynos5250.dtsi                  |  36 +++-
  arch/arm/boot/dts/exynos5420-smdk5420.dts          |  33 ++++
  arch/arm/boot/dts/exynos5420.dtsi                  | 194 
++++++++++++++++++++-
  drivers/clocksource/exynos_mct.c                   |   4 +
  12 files changed, 280 insertions(+), 66 deletions(-)
