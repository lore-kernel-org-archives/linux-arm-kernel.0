From: carlo@caione.org (Carlo Caione)
Date: Mon, 23 Nov 2015 11:16:56 +0100
Subject: [PATCH v2 5/5] ARM: meson: DTS: Enable GPIO IRQs
In-Reply-To: <1448273816-11290-1-git-send-email-carlo@caione.org>
References: <1448273816-11290-1-git-send-email-carlo@caione.org>
Message-ID: <1448273816-11290-6-git-send-email-carlo@caione.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Carlo Caione <carlo@endlessm.com>

Signed-off-by: Carlo Caione <carlo@endlessm.com>
---
 arch/arm/boot/dts/meson8b.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/meson8b.dtsi b/arch/arm/boot/dts/meson8b.dtsi
index ee352bf..3c0ae45 100644
--- a/arch/arm/boot/dts/meson8b.dtsi
+++ b/arch/arm/boot/dts/meson8b.dtsi
@@ -152,6 +152,12 @@
 		pinctrl: pinctrl at c1109880 {
 			compatible = "amlogic,meson8b-pinctrl";
 			reg = <0xc1109880 0x10>;
+			reg-names = "irq";
+			interrupt-parent = <&gic>;
+			interrupts = <0 64 1>, <0 65 1>, <0 66 1>, <0 67 1>,
+				     <0 68 1>, <0 69 1>, <0 70 1>, <0 71 1>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges;
-- 
2.5.0
