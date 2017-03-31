From: hgkr.klein@gmail.com (Helmut Klein)
Date: Fri, 31 Mar 2017 18:54:37 +0200
Subject: [PATCH v3 4/4] ARM64: dts: meson-gx: add core clock support for
 uart_A, uart_B and uart_C
In-Reply-To: <20170331165437.26227-1-hgkr.klein@gmail.com>
References: <20170331165437.26227-1-hgkr.klein@gmail.com>
Message-ID: <20170331165437.26227-5-hgkr.klein@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the core clock support for the three none AO UARTs
of the meson gxbb & meson gxl SoCs

Signed-off-by: Helmut Klein <hgkr.klein@gmail.com>
---
 arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi | 15 +++++++++++++++
 arch/arm64/boot/dts/amlogic/meson-gxl.dtsi  | 15 +++++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
index 04b3324bc132..aa2f75d5cd37 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
@@ -524,3 +524,18 @@
 &vpu {
 	compatible = "amlogic,meson-gxbb-vpu", "amlogic,meson-gx-vpu";
 };
+
+&uart_A {
+	clocks = <&xtal>, <&clkc CLKID_UART0>;
+	clock-names = "xtal", "core";
+};
+
+&uart_B {
+	clocks = <&xtal>, <&clkc CLKID_UART1>;
+	clock-names = "xtal", "core";
+};
+
+&uart_C {
+	clocks = <&xtal>, <&clkc CLKID_UART2>;
+	clock-names = "xtal", "core";
+};
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
index fe11b5fc61f7..f3cc18fd624a 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
@@ -381,3 +381,18 @@
 &vpu {
 	compatible = "amlogic,meson-gxl-vpu", "amlogic,meson-gx-vpu";
 };
+
+&uart_A {
+	clocks = <&xtal>, <&clkc CLKID_UART0>;
+	clock-names = "xtal", "core";
+};
+
+&uart_B {
+	clocks = <&xtal>, <&clkc CLKID_UART1>;
+	clock-names = "xtal", "core";
+};
+
+&uart_C {
+	clocks = <&xtal>, <&clkc CLKID_UART2>;
+	clock-names = "xtal", "core";
+};
--
2.11.0
