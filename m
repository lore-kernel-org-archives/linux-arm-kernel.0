From: ezequiel@collabora.com (Ezequiel Garcia)
Date: Thu, 28 Jun 2018 19:08:29 -0300
Subject: [PATCH v2 2/3] arm64: dts: rockchip: add pin configurations for RK3399
In-Reply-To: <20180628220830.9089-1-ezequiel@collabora.com>
References: <20180628220830.9089-1-ezequiel@collabora.com>
Message-ID: <20180628220830.9089-2-ezequiel@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add pcfg_pull_none_18ma and pcfg_output_low to the
dtsi file, as they are needed by some boards.

Signed-off-by: Ezequiel Garcia <ezequiel@collabora.com>
---
 arch/arm64/boot/dts/rockchip/rk3399.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
index 37fddec1dadf..27dd73d2b9f6 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
@@ -1932,6 +1932,11 @@
 			drive-strength = <12>;
 		};
 
+		pcfg_pull_none_18ma: pcfg-pull-none-18ma {
+			bias-disable;
+			drive-strength = <18>;
+		};
+
 		pcfg_pull_up_8ma: pcfg-pull-up-8ma {
 			bias-pull-up;
 			drive-strength = <8>;
@@ -1957,6 +1962,10 @@
 			drive-strength = <13>;
 		};
 
+		pcfg_output_low: pcfg-output-low {
+			output-low;
+		};
+
 		clock {
 			clk_32k: clk-32k {
 				rockchip,pins = <0 0 RK_FUNC_2 &pcfg_pull_none>;
-- 
2.18.0.rc2
