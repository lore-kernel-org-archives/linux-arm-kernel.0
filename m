From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Tue, 11 Mar 2014 16:54:49 +0900
Subject: [PATCH 0/5] ARM: dts: exynos: Add missing dt data to bring kernel of
 Exynos4x12
Message-ID: <1394524494-30641-1-git-send-email-cw00.choi@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch add missing dt data of Exynos4x12 to bring up kernel feature and
code clean.

exynos4x12/exynos4412/exynos4212.dtsi
- Add ADC (Analog and Digital Converter) to get raw data
- Add PMU (Performance Monitoring Unit) for perf event
- Add gps_alive power domain to remove power leakage when gps-alive isn't used
- Remove duplicate dt data of interrput combiner controller

exynos4412-trats.dts
- Add ADC dt data with ntc thermistor child to read temperature

Chanwoo Choi (5):
  ARM: dts: exynos4x12: Add ADC's dt data to read raw data
  ARM: dts: exynos4x12: Add PMU dt data to support PMU(Perforamnce Monitoring Unit)
  ARM: dts: exynos4x12: Add GPS_ALIVE power domain
  ARM: dts: exynos: Move common dt data for interrupt combiner controller
  ARM: dts: exynos4412-trats2: Add ADC's dt data to get temperature of SoC/battery

 arch/arm/boot/dts/exynos4212.dtsi       | 13 ++++---------
 arch/arm/boot/dts/exynos4412-trats2.dts | 21 +++++++++++++++++++++
 arch/arm/boot/dts/exynos4412.dtsi       | 14 ++++----------
 arch/arm/boot/dts/exynos4x12.dtsi       | 31 +++++++++++++++++++++++++++++++
 4 files changed, 60 insertions(+), 19 deletions(-)

-- 
1.8.0
