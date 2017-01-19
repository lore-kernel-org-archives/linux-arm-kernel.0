From: heiko@sntech.de (Heiko Stuebner)
Date: Thu, 19 Jan 2017 19:02:00 +0100
Subject: [PATCH] ARM: dts: rockchip: add soc-specific uart compatibles for
 rk3066/rk3188
Message-ID: <20170119180201.2547-1-heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The serial IPs in Rockchip socs are based on Designware uarts and thus
bind against the snps,dw-apb-uart compatible.
On all newer socs we also carry around per-soc compatibles that allow
us to have more specific drivers in the future - if needed.

The cortex-a9 socs rk3066 and rk3188 that were added first don't have
those yet, so add them for completenes sake.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm/boot/dts/rk3066a.dtsi | 4 ++++
 arch/arm/boot/dts/rk3188.dtsi  | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/rk3066a.dtsi b/arch/arm/boot/dts/rk3066a.dtsi
index e498c362b9e7..f50481fd8e5c 100644
--- a/arch/arm/boot/dts/rk3066a.dtsi
+++ b/arch/arm/boot/dts/rk3066a.dtsi
@@ -687,6 +687,7 @@
 };
 
 &uart0 {
+	compatible = "rockchip,rk3066-uart", "snps,dw-apb-uart";
 	dmas = <&dmac1_s 0>, <&dmac1_s 1>;
 	dma-names = "tx", "rx";
 	pinctrl-names = "default";
@@ -694,6 +695,7 @@
 };
 
 &uart1 {
+	compatible = "rockchip,rk3066-uart", "snps,dw-apb-uart";
 	dmas = <&dmac1_s 2>, <&dmac1_s 3>;
 	dma-names = "tx", "rx";
 	pinctrl-names = "default";
@@ -701,6 +703,7 @@
 };
 
 &uart2 {
+	compatible = "rockchip,rk3066-uart", "snps,dw-apb-uart";
 	dmas = <&dmac2 6>, <&dmac2 7>;
 	dma-names = "tx", "rx";
 	pinctrl-names = "default";
@@ -708,6 +711,7 @@
 };
 
 &uart3 {
+	compatible = "rockchip,rk3066-uart", "snps,dw-apb-uart";
 	dmas = <&dmac2 8>, <&dmac2 9>;
 	dma-names = "tx", "rx";
 	pinctrl-names = "default";
diff --git a/arch/arm/boot/dts/rk3188.dtsi b/arch/arm/boot/dts/rk3188.dtsi
index 869e189331ec..cf91254d0a43 100644
--- a/arch/arm/boot/dts/rk3188.dtsi
+++ b/arch/arm/boot/dts/rk3188.dtsi
@@ -599,21 +599,25 @@
 };
 
 &uart0 {
+	compatible = "rockchip,rk3188-uart", "snps,dw-apb-uart";
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart0_xfer>;
 };
 
 &uart1 {
+	compatible = "rockchip,rk3188-uart", "snps,dw-apb-uart";
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart1_xfer>;
 };
 
 &uart2 {
+	compatible = "rockchip,rk3188-uart", "snps,dw-apb-uart";
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart2_xfer>;
 };
 
 &uart3 {
+	compatible = "rockchip,rk3188-uart", "snps,dw-apb-uart";
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart3_xfer>;
 };
-- 
2.11.0
