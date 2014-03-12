From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Wed, 12 Mar 2014 15:19:11 +0900
Subject: [PATCHv2 0/5] ARM: dts: exynos: Add missing dt data to bring kernel of
 Exynos4x12
Message-ID: <1394605156-7768-1-git-send-email-cw00.choi@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch add missing dt data of Exynos4x12 to bring up kernel feature and
code clean. This patchset is based on 'v3.15-next/dt-clk-exynos' branch.
- git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git

exynos4x12/exynos4412/exynos4212.dtsi
- Add ADC (Analog and Digital Converter) to get raw data
- Add PMU (Performance Monitoring Unit) for perf event
- Add gps_alive power domain to remove power leakage when gps-alive isn't used
- Remove duplicate dt data of interrput combiner controller

exynos4412-trats.dts
- Add ADC dt data with ntc thermistor child to read temperature

Changes from v1:
- Use clock macro name for Exynos4 instead of constant for ADC
- Remove unnecessary description about patch content
- Move gps-alive power domain's dt data from exynos4x12.dts to exynos4.dts
- Move thermistor dt node outside of ADC dt node and modify node name of thermistor

Chanwoo Choi (5):
  ARM: dts: exynos4x12: Add ADC's dt data to read raw data
  ARM: dts: exynos4x12: Add PMU dt data to support PMU(Perforamnce Monitoring Unit)
  ARM: dts: exynos4x12: Add GPS_ALIVE power domain
  ARM: dts: exynos: Move common dt data for interrupt combiner controller
  ARM: dts: exynos4412-trats2: Add ADC/themistor dt data to get temperature of SoC/battery

 arch/arm/boot/dts/exynos4.dtsi          |  5 +++++
 arch/arm/boot/dts/exynos4212.dtsi       | 13 ++++---------
 arch/arm/boot/dts/exynos4412-trats2.dts | 21 +++++++++++++++++++++
 arch/arm/boot/dts/exynos4412.dtsi       | 14 ++++----------
 arch/arm/boot/dts/exynos4x12.dtsi       | 26 ++++++++++++++++++++++++++
 5 files changed, 60 insertions(+), 19 deletions(-)

-- 
1.8.0
