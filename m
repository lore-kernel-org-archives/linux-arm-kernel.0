From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Thu, 20 Apr 2017 16:25:04 +0530
Subject: [PATCH V5 0/7] PM / OPP: Use - instead of @ for DT entries
Message-ID: <cover.1492685450.git.viresh.kumar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Compiling the DT file with W=1, DTC warns like follows:

Warning (unit_address_vs_reg): Node /opp_table0/opp at 1000000000 has a
unit name, but no reg property

Fix this by replacing '@' with '-' as the OPP nodes will never have a
"reg" property.

This is rebased over arm-soc/for-next:
	commit 6f714927c553 ("ARM: SoC: Document merges")

Platform maintainers shall apply patches touching their code.

V4->V5:
- Rebased on arm-soc/for-next. Couldn't do that on linux-next/master as
  it still had the V3 patch via the PM tree (which will be dropped
  today).
- Some more OPP entries got the update as they were present only in
  next.

V3->V4:
- split it per platform

V2->V3:
- Rebased over 4.11-rc7 and fixed a merge conflict for sun8i.

--
Viresh

Viresh Kumar (7):
  PM / OPP: Use - instead of @ for DT entries
  ARM: TI: Use - instead of @ for DT OPP entries
  ARM: exynos: Use - instead of @ for DT OPP entries
  ARM: pxa: Use - instead of @ for DT OPP entries
  ARM: sun8i: Use - instead of @ for DT OPP entries
  ARM: uniphier: Use - instead of @ for DT OPP entries
  ARM: ZTE: Use - instead of @ for DT OPP entries

 .../devicetree/bindings/cpufreq/ti-cpufreq.txt     | 20 +++----
 .../devicetree/bindings/devfreq/exynos-bus.txt     | 46 +++++++--------
 Documentation/devicetree/bindings/opp/opp.txt      | 38 ++++++-------
 arch/arm/boot/dts/am335x-boneblack.dts             |  2 +-
 arch/arm/boot/dts/am33xx.dtsi                      | 20 +++----
 arch/arm/boot/dts/am4372.dtsi                      | 10 ++--
 arch/arm/boot/dts/dra7.dtsi                        |  4 +-
 arch/arm/boot/dts/exynos3250.dtsi                  | 46 +++++++--------
 arch/arm/boot/dts/exynos4210.dtsi                  | 32 +++++------
 arch/arm/boot/dts/exynos4412-prime.dtsi            |  4 +-
 arch/arm/boot/dts/exynos4412.dtsi                  | 66 +++++++++++-----------
 arch/arm/boot/dts/exynos5420.dtsi                  | 40 ++++++-------
 arch/arm/boot/dts/exynos5800.dtsi                  | 56 +++++++++---------
 arch/arm/boot/dts/pxa25x.dtsi                      |  8 +--
 arch/arm/boot/dts/pxa27x.dtsi                      | 14 ++---
 arch/arm/boot/dts/sun8i-a33-sinlinx-sina33.dts     |  4 +-
 arch/arm/boot/dts/sun8i-a33.dtsi                   | 30 +++++-----
 arch/arm/boot/dts/uniphier-pro5.dtsi               | 32 +++++------
 arch/arm/boot/dts/uniphier-pxs2.dtsi               | 16 +++---
 arch/arm64/boot/dts/exynos/exynos5433-bus.dtsi     | 48 ++++++++--------
 arch/arm64/boot/dts/exynos/exynos5433.dtsi         | 50 ++++++++--------
 arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi   | 14 ++---
 arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi   | 32 +++++------
 arch/arm64/boot/dts/zte/zx296718.dtsi              | 10 ++--
 24 files changed, 321 insertions(+), 321 deletions(-)

-- 
2.12.0.432.g71c3a4f4ba37
