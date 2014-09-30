From: carlo@caione.org (Carlo Caione)
Date: Tue, 30 Sep 2014 10:43:55 +0200
Subject: [PATCH 3/3] ARM: Meson6: enable SMP in DTS/DTSI
In-Reply-To: <1412066635-5298-1-git-send-email-carlo@caione.org>
References: <1412066635-5298-1-git-send-email-carlo@caione.org>
Message-ID: <1412066635-5298-4-git-send-email-carlo@caione.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Carlo Caione <carlo@caione.org>
---
 arch/arm/boot/dts/meson.dtsi  | 5 +++++
 arch/arm/boot/dts/meson6.dtsi | 6 ++++++
 2 files changed, 11 insertions(+)

diff --git a/arch/arm/boot/dts/meson.dtsi b/arch/arm/boot/dts/meson.dtsi
index 55feb14..30b6f95 100644
--- a/arch/arm/boot/dts/meson.dtsi
+++ b/arch/arm/boot/dts/meson.dtsi
@@ -64,6 +64,11 @@
 		interrupts = <0 10 1>;
 	};
 
+	scu at c4300000 {
+		compatible = "arm,cortex-a9-scu";
+		reg = <0xc4300000 0x1000>;
+	};
+
 	soc {
 		compatible = "simple-bus";
 		#address-cells = <1>;
diff --git a/arch/arm/boot/dts/meson6.dtsi b/arch/arm/boot/dts/meson6.dtsi
index 4ba4912..6e7230f 100644
--- a/arch/arm/boot/dts/meson6.dtsi
+++ b/arch/arm/boot/dts/meson6.dtsi
@@ -56,6 +56,7 @@
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
+		enable-method = "amlogic,meson6-smp";
 
 		cpu at 200 {
 			device_type = "cpu";
@@ -70,6 +71,11 @@
 		};
 	};
 
+	cpuconfig at d901ff80 {
+		compatible = "amlogic,meson6-cpuconfig";
+		reg = <0xd901ff80 0x8>;
+	};
+
 	clk81: clk at 0 {
 		#clock-cells = <0>;
 		compatible = "fixed-clock";
-- 
1.9.1
