From: vikas.sajjan@samsung.com (Vikas Sajjan)
Date: Mon, 17 Mar 2014 18:39:52 +0530
Subject: [PATCH v2 0/3] Add initial support of PMU for exynos5260
Message-ID: <1395061795-17777-1-git-send-email-vikas.sajjan@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Vikas Sajjan <vikas.sajjan@linaro.org>

1) Added initial PMU support for exynos5260

2) Added S2R(single CPU) support on exynos5260

3) Added PMU mapping via DT.

rebased on
1) kgene tree for-next branch
https://git.kernel.org/cgit/linux/kernel/git/kgene/linux-samsung.git/log/?h=for-next

2) Rahul's patches for basic support of exynos5260
http://www.spinics.net/lists/linux-samsung-soc/msg27282.html

3) Rahul's clk patches http://www.spinics.net/lists/linux-samsung-soc/msg27275.html

4) Tomasz Figa's http://permalink.gmane.org/gmane.linux.ports.arm.kernel/299340

Changes since v1:
	       -- Addressed Tomasz Figa's comments.
	       -- removed CMU patch
	       -- Added PMU mapping via DT

Vikas Sajjan (3):
  ARM: EXYNOS: Map PMU address through DT
  ARM: EXYNOS: Add initial support of PMU for Exynos5260
  arm: exynos5260: add support for S2R

 .../devicetree/bindings/arm/samsung/pmu.txt        |    5 +-
 arch/arm/boot/dts/exynos4.dtsi                     |    5 +
 arch/arm/boot/dts/exynos5260.dtsi                  |    5 +
 arch/arm/mach-exynos/common.c                      |   51 ++--
 arch/arm/mach-exynos/common.h                      |   26 +++
 arch/arm/mach-exynos/include/mach/map.h            |    3 -
 arch/arm/mach-exynos/pm.c                          |   96 ++++++--
 arch/arm/mach-exynos/pmu.c                         |  238 +++++++++++++++++++
 arch/arm/mach-exynos/regs-pmu.h                    |  244 ++++++++++++++++++++
 arch/arm/plat-samsung/include/plat/cpu.h           |    8 +
 10 files changed, 637 insertions(+), 44 deletions(-)

-- 
1.7.9.5
