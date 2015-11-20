From: alim.akhtar@samsung.com (Alim Akhtar)
Date: Fri, 20 Nov 2015 10:47:04 +0530
Subject: [PATCH v3 0/5] Switch to generic syscon regmap based drivers
Message-ID: <1447996629-18232-1-git-send-email-alim.akhtar@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now we have a nice way to reboot/poweroff system using a generic
syscon regmap based drivers, this series moves exynos SoCs to
make use of the same.

Changes since v2:
* Merged patch 5 and 6 to keep git bisect happy

Changes since v1:
* Added a comment about the register information
* Droped defconfig changes as disscussed
* Collected various Reviewed-by, Tested-by and Acked-by tags
* Added SYSCON-{RESET, POWEROFF} to select from Kconfig

Alim Akhtar (5):
  arm: dts: Add syscon-{reboot, poweroff} nodes for exynos3250 SoCs
  arm: dts: Add syscon-{reboot, poweroff} nodes for exynos4
  arm: dts: Add syscon-{reboot, poweroff} nodes for exynos5
  arm: dts: Add syscon-{reboot, poweroff} nodes for exynos5410 SoC
  ARM: exynos: select POWER_RESET_SYSCON and
    POWER_RESET_SYSCON_POWEROFF

 arch/arm/boot/dts/exynos3250.dtsi |   14 ++++++++++++
 arch/arm/boot/dts/exynos4.dtsi    |   14 ++++++++++++
 arch/arm/boot/dts/exynos5.dtsi    |   14 ++++++++++++
 arch/arm/boot/dts/exynos5410.dtsi |   14 ++++++++++++
 arch/arm/mach-exynos/Kconfig      |    3 +++
 arch/arm/mach-exynos/pmu.c        |   43 -------------------------------------
 6 files changed, 59 insertions(+), 43 deletions(-)

-- 
1.7.10.4
