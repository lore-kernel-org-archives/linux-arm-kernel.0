From: hayashi.kunihiko@socionext.com (Kunihiko Hayashi)
Date: Tue, 24 Apr 2018 13:47:01 +0900
Subject: [PATCH 2/4] arm64: dts: uniphier: add clock-names and reset-names to
 ethernet node
In-Reply-To: <1524545223-5893-1-git-send-email-hayashi.kunihiko@socionext.com>
References: <1524545223-5893-1-git-send-email-hayashi.kunihiko@socionext.com>
Message-ID: <1524545223-5893-3-git-send-email-hayashi.kunihiko@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add clock-names and reset-names because this node recognizes multiple
clocks and resets.  ("ether", and so on, for each)

Suggested-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
---
 arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi | 2 ++
 arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi | 2 ++
 arch/arm64/boot/dts/socionext/uniphier-pxs3.dtsi | 4 ++++
 3 files changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi b/arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi
index e62bda1..540e012 100644
--- a/arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi
+++ b/arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi
@@ -549,7 +549,9 @@
 			status = "disabled";
 			reg = <0x65000000 0x8500>;
 			interrupts = <0 66 4>;
+			clock-names = "ether";
 			clocks = <&sys_clk 6>;
+			reset-names = "ether";
 			resets = <&sys_rst 6>;
 			phy-mode = "rmii";
 			local-mac-address = [00 00 00 00 00 00];
diff --git a/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi b/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi
index 9efe20d..845b407 100644
--- a/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi
+++ b/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi
@@ -604,7 +604,9 @@
 			interrupts = <0 66 4>;
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_ether_rgmii>;
+			clock-names = "ether";
 			clocks = <&sys_clk 6>;
+			reset-names = "ether";
 			resets = <&sys_rst 6>;
 			phy-mode = "rgmii";
 			local-mac-address = [00 00 00 00 00 00];
diff --git a/arch/arm64/boot/dts/socionext/uniphier-pxs3.dtsi b/arch/arm64/boot/dts/socionext/uniphier-pxs3.dtsi
index 7c8f710..4ff043e 100644
--- a/arch/arm64/boot/dts/socionext/uniphier-pxs3.dtsi
+++ b/arch/arm64/boot/dts/socionext/uniphier-pxs3.dtsi
@@ -412,7 +412,9 @@
 			interrupts = <0 66 4>;
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_ether_rgmii>;
+			clock-names = "ether";
 			clocks = <&sys_clk 6>;
+			reset-names = "ether";
 			resets = <&sys_rst 6>;
 			phy-mode = "rgmii";
 			local-mac-address = [00 00 00 00 00 00];
@@ -430,7 +432,9 @@
 			interrupts = <0 67 4>;
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_ether1_rgmii>;
+			clock-names = "ether";
 			clocks = <&sys_clk 7>;
+			reset-names = "ether";
 			resets = <&sys_rst 7>;
 			phy-mode = "rgmii";
 			local-mac-address = [00 00 00 00 00 00];
-- 
2.7.4
