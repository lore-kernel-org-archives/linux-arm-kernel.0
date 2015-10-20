From: alim.akhtar@samsung.com (Alim Akhtar)
Date: Tue, 20 Oct 2015 14:54:39 +0530
Subject: [PATCH v2 0/6] Switch to generic syscon regmap based drivers
Message-ID: <1445333085-22837-1-git-send-email-alim.akhtar@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now we have a nice way to reboot/poweroff system using a generic
syscon regmap based drivers, this series moves exynos SoCs to
make use of the same.

Changes since v1:
* Added a comment about the register information
* Droped defconfig changes as disscussed
* Collected various Reviewed-by, Tested-by and Acked-by tags
* Added SYSCON-{RESET, POWEROFF} to select from Kconfig

Alim Akhtar (6):
  arm: dts: Add syscon-{reboot, poweroff} nodes for exynos3250 SoCs
  arm: dts: Add syscon-{reboot, poweroff} nodes for exynos4
  arm: dts: Add syscon-{reboot, poweroff} nodes for exynos5
  arm: dts: Add syscon-{reboot, poweroff} nodes for exynos5410 SoC
  ARM: exynos: select POWER_RESET_SYSCON and
    POWER_RESET_SYSCON_POWEROFF
  ARM: EXYNOS: Remove code for restart and poweroff for exynos SoCs

 arch/arm/boot/dts/exynos3250.dtsi |   14 ++++++++++++
 arch/arm/boot/dts/exynos4.dtsi    |   14 ++++++++++++
 arch/arm/boot/dts/exynos5.dtsi    |   14 ++++++++++++
 arch/arm/boot/dts/exynos5410.dtsi |   14 ++++++++++++
 arch/arm/mach-exynos/Kconfig      |    3 +++
 arch/arm/mach-exynos/pmu.c        |   43 -------------------------------------
 6 files changed, 59 insertions(+), 43 deletions(-)

-- 
1.7.10.4
