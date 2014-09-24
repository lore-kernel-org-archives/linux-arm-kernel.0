From: thomas.ab@samsung.com (Thomas Abraham)
Date: Wed, 24 Sep 2014 09:27:52 +0530
Subject: [PATCH v10 0/6] cpufreq: use generic cpufreq drivers for exynos
 platforms
Message-ID: <1411531078-10671-1-git-send-email-thomas.ab@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series removes the use of Exynos4210 and Exynos5250 specific cpufreq
drivers and enables the use of cpufreq-cpu0 driver for these platforms. This
series also enables cpufreq support for Exynos5420 using arm_big_little cpufreq
driver.

This patch series is dependent on two other patches
1. ARM: dts: add CPU nodes for Exynos4 SoCs
   - https://lkml.org/lkml/2014/7/21/315
2. clk: exynos4: remove duplicate div_core2 divider clock instantiation
   - http://www.mail-archive.com/linux-samsung-soc at vger.kernel.org/msg34859.html

Thomas Abraham (6):
  clk: samsung: add infrastructure to register cpu clocks
  clk: samsung: add cpu clock configuration data and instantiate cpu clock
  ARM: dts: Exynos: add CPU OPP and regulator supply property
  ARM: Exynos: switch to using generic cpufreq driver for Exynos4210/5250/5420
  cpufreq: exynos: remove exynos4210/5250 specific cpufreq driver support
  clk: samsung: remove unused clock aliases and update clock flags

 arch/arm/boot/dts/exynos4210-origen.dts         |    4 +
 arch/arm/boot/dts/exynos4210-trats.dts          |    4 +
 arch/arm/boot/dts/exynos4210-universal_c210.dts |    4 +
 arch/arm/boot/dts/exynos4210.dtsi               |   14 +-
 arch/arm/boot/dts/exynos5250-arndale.dts        |    4 +
 arch/arm/boot/dts/exynos5250-smdk5250.dts       |    4 +
 arch/arm/boot/dts/exynos5250-snow.dts           |    4 +
 arch/arm/boot/dts/exynos5250.dtsi               |   25 ++-
 arch/arm/boot/dts/exynos5420.dtsi               |   38 +++
 arch/arm/mach-exynos/exynos.c                   |   24 ++-
 drivers/clk/samsung/Makefile                    |    2 +-
 drivers/clk/samsung/clk-cpu.c                   |  335 +++++++++++++++++++++++
 drivers/clk/samsung/clk-cpu.h                   |   91 ++++++
 drivers/clk/samsung/clk-exynos4.c               |   63 +++--
 drivers/clk/samsung/clk-exynos5250.c            |   44 +++-
 drivers/clk/samsung/clk-exynos5420.c            |   72 +++++-
 drivers/cpufreq/Kconfig.arm                     |   22 --
 drivers/cpufreq/Makefile                        |    2 -
 include/dt-bindings/clock/exynos5250.h          |    1 +
 include/dt-bindings/clock/exynos5420.h          |    2 +
