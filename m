From: hayashi.kunihiko@socionext.com (Kunihiko Hayashi)
Date: Tue, 24 Apr 2018 13:47:00 +0900
Subject: [PATCH 1/4] ARM: dts: uniphier: add required clocks and resets to
 Pro4 ethernet node
In-Reply-To: <1524545223-5893-1-git-send-email-hayashi.kunihiko@socionext.com>
References: <1524545223-5893-1-git-send-email-hayashi.kunihiko@socionext.com>
Message-ID: <1524545223-5893-2-git-send-email-hayashi.kunihiko@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The GIO clock/reset, Another MAC clock, and the PHY clock are required
for the ethernet of Pro4 SoC.
And add clock-names and reset-names to the ethernet node of PXs2 since
we need to distinguish clocks and resets now.

Suggested-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
---
 arch/arm/boot/dts/uniphier-pro4.dtsi | 7 +++++--
 arch/arm/boot/dts/uniphier-pxs2.dtsi | 2 ++
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/uniphier-pro4.dtsi b/arch/arm/boot/dts/uniphier-pro4.dtsi
index 844124b..392d7dd 100644
--- a/arch/arm/boot/dts/uniphier-pro4.dtsi
+++ b/arch/arm/boot/dts/uniphier-pro4.dtsi
@@ -371,8 +371,11 @@
 			interrupts = <0 66 4>;
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_ether_rgmii>;
-			clocks = <&sys_clk 6>;
-			resets = <&sys_rst 6>;
+			clock-names = "gio", "ether", "ether-gb", "ether-phy";
+			clocks = <&sys_clk 12>, <&sys_clk 6>, <&sys_clk 7>,
+				 <&sys_clk 10>;
+			reset-names = "gio", "ether";
+			resets = <&sys_rst 12>, <&sys_rst 6>;
 			phy-mode = "rgmii";
 			local-mac-address = [00 00 00 00 00 00];
 
diff --git a/arch/arm/boot/dts/uniphier-pxs2.dtsi b/arch/arm/boot/dts/uniphier-pxs2.dtsi
index debcbd1..a1839db 100644
--- a/arch/arm/boot/dts/uniphier-pxs2.dtsi
+++ b/arch/arm/boot/dts/uniphier-pxs2.dtsi
@@ -506,7 +506,9 @@
 			interrupts = <0 66 4>;
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_ether_rgmii>;
+			clock-names = "ether";
 			clocks = <&sys_clk 6>;
+			reset-names = "ether";
 			resets = <&sys_rst 6>;
 			phy-mode = "rgmii";
 			local-mac-address = [00 00 00 00 00 00];
-- 
2.7.4
