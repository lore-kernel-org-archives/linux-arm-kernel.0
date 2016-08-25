From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Thu, 25 Aug 2016 15:57:18 +0900
Subject: [PATCH v2 3/3] ARM: dts: Set the clock rate for DREX block 800Mhz on
 exynos5422-odroidxu3
In-Reply-To: <1472108238-24309-1-git-send-email-cw00.choi@samsung.com>
References: <1472108238-24309-1-git-send-email-cw00.choi@samsung.com>
Message-ID: <1472108238-24309-4-git-send-email-cw00.choi@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch sets the clock rate for DREX (DRAM Express) block
on exynos5422-odroidxu3 board. In the exynos5422 TRM,
DRAM clocks use BPLL clock and CMU_CDREX generates
the 800MHz DRAM clock.

[clk_summary on exynos5422-odroidxu3 board]
fout_bpll                             0            0   800000000          0 0
    mout_bpll                          0            0   800000000          0 0
       mout_mclk_cdrex                 0            0   800000000          0 0
          dout_pclk_core_mem           0            0   200000000          0 0
          dout_sclk_cdrex              0            0   800000000          0 0

Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
---
 arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi b/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi
index d56253049ccb..fd3f67c72039 100644
--- a/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi
+++ b/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi
@@ -229,6 +229,11 @@
 	status = "okay";
 };
 
+&clock {
+	assigned-clocks = <&clock CLK_DOUT_SCLK_CDREX>;
+	assigned-clock-rates = <800000000>;
+};
+
 &clock_audss {
 	assigned-clocks = <&clock_audss EXYNOS_MOUT_AUDSS>,
 			<&clock_audss EXYNOS_MOUT_I2S>,
-- 
1.9.1
