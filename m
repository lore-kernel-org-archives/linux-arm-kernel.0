From: linux@prisktech.co.nz (Tony Prisk)
Date: Wed, 24 Apr 2013 17:38:20 +1200
Subject: [PATCH 1/3] dts: vt8500: Fix invalid/missing cpu nodes for soc files.
In-Reply-To: <1366781902-13025-1-git-send-email-linux@prisktech.co.nz>
References: <1366781902-13025-1-git-send-email-linux@prisktech.co.nz>
Message-ID: <1366781902-13025-2-git-send-email-linux@prisktech.co.nz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

vt8500, wm8650 and wm8850 have no cpu node specified.
wm8505 has a cpu node which contains an invalid compatible string, and
is missing the other required properties.

Signed-off-by: Tony Prisk <linux@prisktech.co.nz>
---
 arch/arm/boot/dts/vt8500.dtsi |   10 ++++++++++
 arch/arm/boot/dts/wm8505.dtsi |    8 ++++++--
 arch/arm/boot/dts/wm8650.dtsi |   10 ++++++++++
 arch/arm/boot/dts/wm8850.dtsi |   11 +++++++++++
 4 files changed, 37 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/vt8500.dtsi b/arch/arm/boot/dts/vt8500.dtsi
index cf31ced..e35590e 100644
--- a/arch/arm/boot/dts/vt8500.dtsi
+++ b/arch/arm/boot/dts/vt8500.dtsi
@@ -11,6 +11,16 @@
 / {
 	compatible = "via,vt8500";
 
+	cpus {
+		#size-cells = <0>;
+		#address-cells = <1>;
+
+		cpu {
+			device_type = "cpu";
+			compatible = "arm,arm926";
+		};
+	};
+
 	soc {
 		#address-cells = <1>;
 		#size-cells = <1>;
diff --git a/arch/arm/boot/dts/wm8505.dtsi b/arch/arm/boot/dts/wm8505.dtsi
index e74a1c0..dc21d13 100644
--- a/arch/arm/boot/dts/wm8505.dtsi
+++ b/arch/arm/boot/dts/wm8505.dtsi
@@ -12,8 +12,12 @@
 	compatible = "wm,wm8505";
 
 	cpus {
-		cpu at 0 {
-			compatible = "arm,arm926ejs";
+		#size-cells = <0>;
+		#address-cells = <1>;
+
+		cpu {
+			device_type = "cpu";
+			compatible = "arm,arm926";
 		};
 	};
 
diff --git a/arch/arm/boot/dts/wm8650.dtsi b/arch/arm/boot/dts/wm8650.dtsi
index db3c0a1..f4cd55e 100644
--- a/arch/arm/boot/dts/wm8650.dtsi
+++ b/arch/arm/boot/dts/wm8650.dtsi
@@ -11,6 +11,16 @@
 / {
 	compatible = "wm,wm8650";
 
+	cpus {
+		#size-cells = <0>;
+		#address-cells = <1>;
+
+		cpu {
+			device_type = "cpu";
+			compatible = "arm,arm926";
+		};
+	};
+
 	soc {
 		#address-cells = <1>;
 		#size-cells = <1>;
diff --git a/arch/arm/boot/dts/wm8850.dtsi b/arch/arm/boot/dts/wm8850.dtsi
index e8cbfdc..4b56aa0 100644
--- a/arch/arm/boot/dts/wm8850.dtsi
+++ b/arch/arm/boot/dts/wm8850.dtsi
@@ -11,6 +11,17 @@
 / {
 	compatible = "wm,wm8850";
 
+	cpus {
+		#size-cells = <0>;
+		#address-cells = <1>;
+
+		cpu at 0 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a9";
+			reg = <0x0>;
+		};
+	};
+
 	aliases {
 		serial0 = &uart0;
 		serial1 = &uart1;
-- 
1.7.9.5
