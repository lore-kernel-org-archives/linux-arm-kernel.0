From: sugar.zhang@rock-chips.com (Sugar Zhang)
Date: Mon, 21 Aug 2017 16:25:06 +0800
Subject: [PATCH v2 1/2] arm64: dts: rockchip: add rk3328 pdm node
In-Reply-To: <1503303907-57630-1-git-send-email-sugar.zhang@rock-chips.com>
References: <1503303907-57630-1-git-send-email-sugar.zhang@rock-chips.com>
Message-ID: <1503303907-57630-2-git-send-email-sugar.zhang@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch add pdm controller device node for rk3328.

Signed-off-by: Sugar Zhang <sugar.zhang@rock-chips.com>

---

Changes in v2:
- separate pinctrl pins
  remove unused fsync clk, it's debug pins

 arch/arm64/boot/dts/rockchip/rk3328.dtsi | 77 ++++++++++++++++++++++++++++++++
 1 file changed, 77 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3328.dtsi b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
index 0be96ce..c4f52ec 100644
--- a/arch/arm64/boot/dts/rockchip/rk3328.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
@@ -156,6 +156,27 @@
 		clock-output-names = "xin24m";
 	};
 
+	pdm: pdm at ff040000 {
+		compatible = "rockchip,pdm";
+		reg = <0x0 0xff040000 0x0 0x1000>;
+		clocks = <&cru SCLK_PDM>, <&cru HCLK_PDM>;
+		clock-names = "pdm_clk", "pdm_hclk";
+		dmas = <&dmac 16>;
+		dma-names = "rx";
+		pinctrl-names = "default", "sleep";
+		pinctrl-0 = <&pdmm0_clk
+			     &pdmm0_sdi0
+			     &pdmm0_sdi1
+			     &pdmm0_sdi2
+			     &pdmm0_sdi3>;
+		pinctrl-1 = <&pdmm0_clk_sleep
+			     &pdmm0_sdi0_sleep
+			     &pdmm0_sdi1_sleep
+			     &pdmm0_sdi2_sleep
+			     &pdmm0_sdi3_sleep>;
+		status = "disabled";
+	};
+
 	grf: syscon at ff100000 {
 		compatible = "rockchip,rk3328-grf", "syscon", "simple-mfd";
 		reg = <0x0 0xff100000 0x0 0x1000>;
@@ -734,6 +755,62 @@
 			};
 		};
 
+		pdm-0 {
+			pdmm0_clk: pdmm0-clk {
+				rockchip,pins = <2 RK_PC2 2 &pcfg_pull_none>;
+			};
+
+			pdmm0_fsync: pdmm0-fsync {
+				rockchip,pins = <2 RK_PC7 2 &pcfg_pull_none>;
+			};
+
+			pdmm0_sdi0: pdmm0-sdi0 {
+				rockchip,pins = <2 RK_PC3 2 &pcfg_pull_none>;
+			};
+
+			pdmm0_sdi1: pdmm0-sdi1 {
+				rockchip,pins = <2 RK_PC4 2 &pcfg_pull_none>;
+			};
+
+			pdmm0_sdi2: pdmm0-sdi2 {
+				rockchip,pins = <2 RK_PC5 2 &pcfg_pull_none>;
+			};
+
+			pdmm0_sdi3: pdmm0-sdi3 {
+				rockchip,pins = <2 RK_PC6 2 &pcfg_pull_none>;
+			};
+
+			pdmm0_clk_sleep: pdmm0-clk-sleep {
+				rockchip,pins =
+					<2 RK_PC2 RK_FUNC_GPIO &pcfg_input_high>;
+			};
+
+			pdmm0_sdi0_sleep: pdmm0-sdi0-sleep {
+				rockchip,pins =
+					<2 RK_PC3 RK_FUNC_GPIO &pcfg_input_high>;
+			};
+
+			pdmm0_sdi1_sleep: pdmm0-sdi1-sleep {
+				rockchip,pins =
+					<2 RK_PC4 RK_FUNC_GPIO &pcfg_input_high>;
+			};
+
+			pdmm0_sdi2_sleep: pdmm0-sdi2-sleep {
+				rockchip,pins =
+					<2 RK_PC5 RK_FUNC_GPIO &pcfg_input_high>;
+			};
+
+			pdmm0_sdi3_sleep: pdmm0-sdi3-sleep {
+				rockchip,pins =
+					<2 RK_PC6 RK_FUNC_GPIO &pcfg_input_high>;
+			};
+
+			pdmm0_fsync_sleep: pdmm0-fsync-sleep {
+				rockchip,pins =
+					<2 RK_PC7 RK_FUNC_GPIO &pcfg_input_high>;
+			};
+		};
+
 		i2s1 {
 			i2s1_mclk: i2s1-mclk {
 				rockchip,pins = <2 RK_PB7 1 &pcfg_pull_none>;
-- 
2.7.4
