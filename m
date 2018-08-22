From: heiko@sntech.de (Heiko Stuebner)
Date: Wed, 22 Aug 2018 14:09:25 +0200
Subject: [PATCH] arm64: dts: rockchip: add cr50 tpm to rk3399-gru scarlet and
 bob
Message-ID: <20180822120925.12388-1-heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Scarlet and Bob use the Google-developed cr50 chip to do things
like TPM and closed-case-debugging.

Add the nodes describing the cr50 and its spi-connection.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
The last activity on upstreaming the cr50 happened in 2016 it seems [0].
And while I hope that this will continue at some point, I've split this
out of the patches adding Gru-Bob and -Scarlet devicetrees to the mainline
kernel and am putting this out here, so I can keep track of it and maybe
inspire [= prod ;-) ] someone from CrOS to resume upstreaming the driver
part ;-) .


[0] https://patchwork.kernel.org/patch/9251895/

 arch/arm64/boot/dts/rockchip/rk3399-gru-bob.dts      | 10 ++++++++++
 arch/arm64/boot/dts/rockchip/rk3399-gru-scarlet.dtsi | 10 ++++++++++
 2 files changed, 20 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-gru-bob.dts b/arch/arm64/boot/dts/rockchip/rk3399-gru-bob.dts
index 1ee0dc0d9f10..a16c5afe1636 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-gru-bob.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-gru-bob.dts
@@ -68,6 +68,16 @@
 
 &spi0 {
 	status = "okay";
+
+	cr50 at 0 {
+		compatible = "google,cr50";
+		reg = <0>;
+		interrupt-parent = <&gpio0>;
+		interrupts = <5 IRQ_TYPE_EDGE_RISING>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&h1_int_od_l>;
+		spi-max-frequency = <800000>;
+	};
 };
 
 &pinctrl {
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-gru-scarlet.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-gru-scarlet.dtsi
index fc50b3ef758c..7a93d0774108 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-gru-scarlet.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-gru-scarlet.dtsi
@@ -435,6 +435,16 @@ camera: &i2c7 {
 
 &spi2 {
 	status = "okay";
+
+	cr50 at 0 {
+		compatible = "google,cr50";
+		reg = <0>;
+		interrupt-parent = <&gpio1>;
+		interrupts = <17 IRQ_TYPE_EDGE_RISING>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&h1_int_od_l>;
+		spi-max-frequency = <800000>;
+	};
 };
 
 &wake_on_bt {
-- 
2.17.0
