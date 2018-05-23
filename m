From: daniel@zonque.org (Daniel Mack)
Date: Wed, 23 May 2018 10:30:12 +0200
Subject: [PATCH 1/2] ARM: dts: imx6: make edt-ft5x06 a wakeup source for imx6
 boards
Message-ID: <20180523083013.7570-1-daniel@zonque.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The touchscreen driver no longer configures the device as wakeup source by
default. A "wakeup-source" property is needed.

Signed-off-by: Daniel Mack <daniel@zonque.org>
---
 arch/arm/boot/dts/imx6q-var-dt6customboard.dts | 1 +
 arch/arm/boot/dts/imx6qdl-nit6xlite.dtsi       | 1 +
 arch/arm/boot/dts/imx6qdl-nitrogen6_max.dtsi   | 1 +
 arch/arm/boot/dts/imx6qdl-nitrogen6_som2.dtsi  | 1 +
 arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi      | 1 +
 5 files changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/imx6q-var-dt6customboard.dts b/arch/arm/boot/dts/imx6q-var-dt6customboard.dts
index e0728d475f6f..7537d77b3415 100644
--- a/arch/arm/boot/dts/imx6q-var-dt6customboard.dts
+++ b/arch/arm/boot/dts/imx6q-var-dt6customboard.dts
@@ -179,6 +179,7 @@
 		touchscreen-size-y = <480>;
 		touchscreen-inverted-x;
 		touchscreen-inverted-y;
+		wakeup-source;
 	};
 
 	rtc at 68 {
diff --git a/arch/arm/boot/dts/imx6qdl-nit6xlite.dtsi b/arch/arm/boot/dts/imx6qdl-nit6xlite.dtsi
index aab088f318e8..aef4a756ca81 100644
--- a/arch/arm/boot/dts/imx6qdl-nit6xlite.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-nit6xlite.dtsi
@@ -292,6 +292,7 @@
 		reg = <0x38>;
 		interrupt-parent = <&gpio1>;
 		interrupts = <9 IRQ_TYPE_EDGE_FALLING>;
+		wakeup-source;
 	};
 
 	rtc at 6f {
diff --git a/arch/arm/boot/dts/imx6qdl-nitrogen6_max.dtsi b/arch/arm/boot/dts/imx6qdl-nitrogen6_max.dtsi
index 87ca6ead4098..9cb464b65be1 100644
--- a/arch/arm/boot/dts/imx6qdl-nitrogen6_max.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-nitrogen6_max.dtsi
@@ -442,6 +442,7 @@
 		reg = <0x38>;
 		interrupt-parent = <&gpio1>;
 		interrupts = <9 IRQ_TYPE_EDGE_FALLING>;
+		wakeup-source;
 	};
 };
 
diff --git a/arch/arm/boot/dts/imx6qdl-nitrogen6_som2.dtsi b/arch/arm/boot/dts/imx6qdl-nitrogen6_som2.dtsi
index f5b763d39285..5e4da6d6fcff 100644
--- a/arch/arm/boot/dts/imx6qdl-nitrogen6_som2.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-nitrogen6_som2.dtsi
@@ -360,6 +360,7 @@
 		reg = <0x38>;
 		interrupt-parent = <&gpio1>;
 		interrupts = <9 IRQ_TYPE_EDGE_FALLING>;
+		wakeup-source;
 	};
 };
 
diff --git a/arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi b/arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi
index 596866b0a0d2..a14872436c5e 100644
--- a/arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi
@@ -370,6 +370,7 @@
 		reg = <0x38>;
 		interrupt-parent = <&gpio1>;
 		interrupts = <9 IRQ_TYPE_EDGE_FALLING>;
+		wakeup-source;
 	};
 };
 
-- 
2.14.3
