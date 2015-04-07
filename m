From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Wed, 08 Apr 2015 01:34:24 +0200
Subject: [PATCH 2/2] ARM: dts: rockchip: enable tsadc on rk3288 boards
In-Reply-To: <1464569.rLOrpbGREu@diego>
References: <1464569.rLOrpbGREu@diego>
Message-ID: <2306443.Xj290TNvSf@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The tsadc is used to read cpu and gpu temperatures. Also enable it on the
other rk3288 boards beside the evb using the cru reset settings.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm/boot/dts/rk3288-firefly.dtsi | 6 ++++++
 arch/arm/boot/dts/rk3288-popmetal.dts | 6 ++++++
 2 files changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/rk3288-firefly.dtsi b/arch/arm/boot/dts/rk3288-firefly.dtsi
index a3b1fc4..0b42372 100644
--- a/arch/arm/boot/dts/rk3288-firefly.dtsi
+++ b/arch/arm/boot/dts/rk3288-firefly.dtsi
@@ -465,6 +465,12 @@
 	status = "okay";
 };
 
+&tsadc {
+	rockchip,hw-tshut-mode = <0>;
+	rockchip,hw-tshut-polarity = <0>;
+	status = "okay";
+};
+
 &uart0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart0_xfer>, <&uart0_cts>, <&uart0_rts>;
diff --git a/arch/arm/boot/dts/rk3288-popmetal.dts b/arch/arm/boot/dts/rk3288-popmetal.dts
index d081f0e..d582811 100644
--- a/arch/arm/boot/dts/rk3288-popmetal.dts
+++ b/arch/arm/boot/dts/rk3288-popmetal.dts
@@ -406,6 +406,12 @@
 	};
 };
 
+&tsadc {
+	rockchip,hw-tshut-mode = <0>;
+	rockchip,hw-tshut-polarity = <0>;
+	status = "okay";
+};
+
 &vopb {
 	status = "okay";
 };
-- 
2.1.4
