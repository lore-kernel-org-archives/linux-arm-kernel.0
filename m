From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Wed, 01 Jul 2015 22:21:14 +0900
Subject: [PATCH v5 0/3] cpufreq: Use cpufreq-dt driver for Exynos3250
Message-ID: <1435756877-26736-1-git-send-email-cw00.choi@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset use cpufreq-dt driver to support Exynos3250 cpufreq and tested it
on Exynos3250-based Rinato board.

Depends on:
- next-20150701 tag (master branch) of linux-next kernel tree
- This patch-set is based on Exynos5250 patch-set[1] because two patch-set
  modify the 'arch/arm/mach-exynos/exynos.c' to add the compatible string.
  [1] https://lkml.org/lkml/2015/6/29/361
  : [PATCH v2 0/4] cpufreq: use generic cpufreq drivers for Exynos5250 platform

Changes from v4:
(https://lkml.org/lkml/2014/10/20/215)
- Rebased on latest linux-next git repository.
- Remove unnecessary divider clock flag from divider of DIV_CPU0/DIV_CPU1 register

Changes from v3:
- This patchset is based on 3.18-rc1 with new patchset[3] of Thomas Abraham
  [3] [PATCH v11 0/6] cpufreq: use generic cpufreq drivers for exynos platforms
  - http://www.spinics.net/lists/arm-kernel/msg370412.html

Changes from v2:
- Rebased on new patchset of Thomas Abraham
  and for-next branch of samsunc-clk.git of Tomasz Figa

Changes from v1:
- Rebased on new patchset[1] by Thomas Abraham
  [1] [PATCH v10 0/6] cpufreq: use generic cpufreq drivers for exynos platforms
  - http://www.spinics.net/lists/arm-kernel/msg364790.html
- Modify clk-cpu.c to support Exynos3250
- Drop documentation patch on previous patchset[2]
  [2] http://www.spinics.net/lists/cpufreq/msg10265.html
- Add only operating-points for Exynos3250 without armclk-divider-table

Chanwoo Choi (3):
  clk: samsung: exynos3250: Add cpu clock configuration data and instaniate cpu clock
  ARM: dts: Add CPU OPP and regulator supply property for Exynos3250
  ARM: exynos: Add exynos3250 compatible to use generic cpufreq driver

 arch/arm/boot/dts/exynos3250-monk.dts   |  4 ++++
 arch/arm/boot/dts/exynos3250-rinato.dts |  4 ++++
 arch/arm/boot/dts/exynos3250.dtsi       | 15 +++++++++++++++
 arch/arm/mach-exynos/exynos.c           |  1 +
 drivers/clk/samsung/clk-exynos3250.c    | 32 ++++++++++++++++++++++++++++++--
 include/dt-bindings/clock/exynos3250.h  |  1 +
 6 files changed, 55 insertions(+), 2 deletions(-)

-- 
1.8.5.5
