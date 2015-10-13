From: baruch@tkos.co.il (Baruch Siach)
Date: Tue, 13 Oct 2015 14:28:03 +0300
Subject: [PATCH 2/3] ARM: digicolor: add pinctrl module device node
In-Reply-To: <cover.1444735169.git.baruch@tkos.co.il>
References: <cover.1444735169.git.baruch@tkos.co.il>
Message-ID: <ea62163fb38342399b11a75f727f9ed5e0c9da6e.1444735169.git.baruch@tkos.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Baruch Siach <baruch@tkos.co.il>
---
 arch/arm/boot/dts/cx92755.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/cx92755.dtsi b/arch/arm/boot/dts/cx92755.dtsi
index df4c6f1f93f9..a5a23c376418 100644
--- a/arch/arm/boot/dts/cx92755.dtsi
+++ b/arch/arm/boot/dts/cx92755.dtsi
@@ -95,6 +95,13 @@
 		timeout-sec = <15>;
 	};
 
+	pinctrl: pinctrl at f0000e20 {
+		compatible = "cnxt,cx92755-pinctrl";
+		reg = <0xf0000e20 0x100>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+
 	uc_regs: syscon at f00003a0 {
 		compatible = "cnxt,cx92755-uc", "syscon";
 		reg = <0xf00003a0 0x10>;
-- 
2.6.1
