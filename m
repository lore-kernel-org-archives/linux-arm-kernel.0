From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Wed, 02 Dec 2015 10:39:39 +0900
Subject: [GIT PULL 2/9] ARM: EXYNOS: Exynos SoC/mach specific code for v4.5
In-Reply-To: <1449020386-20250-1-git-send-email-k.kozlowski@samsung.com>
References: <1449020386-20250-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <1449020386-20250-3-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kukjin,

SoC/mach specific code.

Best regards,
Krzysztof


The following changes since commit 8005c49d9aea74d382f474ce11afbbc7d7130bec:

  Linux 4.4-rc1 (2015-11-15 17:00:27 -0800)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-soc-4.5

for you to fetch changes up to 8438aef01d3560549b3a95d247b3a69311fa6f2d:

  ARM: EXYNOS: Remove redundant code from regs-pmu.h (2015-11-20 16:00:47 +0900)

----------------------------------------------------------------
Samsung Exynos improvements for 4.5:
1. Switch from Exynos-specific restart/poweroff handler
   (mach-exynos/pmu.c) to generic syscon-reboot and syscon-poweroff
   drivers.
   This depends on adding syscon nodes to DTS to preserve
   bisectability.
2. Minor improvements.

----------------------------------------------------------------
Alim Akhtar (5):
      ARM: dts: Add syscon-{reboot, poweroff} nodes for exynos3250
      ARM: dts: Add syscon-{reboot, poweroff} nodes for exynos4
      ARM: dts: Add syscon-{reboot, poweroff} nodes for exynos5
      ARM: dts: Add syscon-{reboot, poweroff} nodes for exynos5410
      ARM: EXYNOS: Switch to syscon reboot and poweroff

Krzysztof Kozlowski (2):
      Merge tag 'samsung-dt-syscon-restart-4.5' into next/soc
      ARM: EXYNOS: Constify local exynos_pmu_data structure

Pankaj Dubey (1):
      ARM: EXYNOS: Remove redundant code from regs-pmu.h

 arch/arm/boot/dts/exynos3250.dtsi | 14 ++++++++++++
 arch/arm/boot/dts/exynos4.dtsi    | 14 ++++++++++++
 arch/arm/boot/dts/exynos5.dtsi    | 14 ++++++++++++
 arch/arm/boot/dts/exynos5410.dtsi | 14 ++++++++++++
 arch/arm/mach-exynos/Kconfig      |  3 +++
 arch/arm/mach-exynos/pmu.c        | 45 ++-------------------------------------
 arch/arm/mach-exynos/regs-pmu.h   |  9 --------
 7 files changed, 61 insertions(+), 52 deletions(-)
