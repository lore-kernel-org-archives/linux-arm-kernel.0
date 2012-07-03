From: sebastian.hesselbarth@googlemail.com (Sebastian Hesselbarth)
Date: Tue,  3 Jul 2012 14:34:24 +0200
Subject: [PATCH 1/3] ARM: dts: dove: Add devicetree descriptors
In-Reply-To: <1341318868-24567-2-git-send-email-sebastian.hesselbarth@googlemail.com>
References: <1341318868-24567-2-git-send-email-sebastian.hesselbarth@googlemail.com>
Message-ID: <1341318868-24567-3-git-send-email-sebastian.hesselbarth@googlemail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds devicetree descriptors for Marvell Dove and currently
supported boards.

Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@googlemail.com>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: linux-arm-kernel at lists.infradead.org
---
 arch/arm/boot/dts/dove-cm-a510.dtsi |   27 +++++++++++++++++
 arch/arm/boot/dts/dove-dove-db.dtsi |   27 +++++++++++++++++
 arch/arm/boot/dts/dove.dtsi         |   55 +++++++++++++++++++++++++++++++++++
 4 files changed, 132 insertions(+)
 create mode 100644 arch/arm/boot/dts/dove-cm-a510.dtsi
 create mode 100644 arch/arm/boot/dts/dove-dove-db.dtsi
 create mode 100644 arch/arm/boot/dts/dove.dtsi

diff --git a/arch/arm/boot/dts/dove-cm-a510.dtsi b/arch/arm/boot/dts/dove-cm-a510.dtsi
new file mode 100644
index 0000000..5cdebbb
--- /dev/null
+++ b/arch/arm/boot/dts/dove-cm-a510.dtsi
@@ -0,0 +1,27 @@
+/dts-v1/;
+
+/include/ "dove.dtsi"
+
+/ {
+	model = "Compulab CM-A510";
+	compatible = "compulab,cm-a510", "mrvl,dove";
+
+	memory {
+		device_type = "memory";
+		reg = <0x00000000 0x40000000>;
+	};
+
+	chosen {
+		bootargs = "console=ttyS0,115200n8 earlyprintk";
+	};
+
+	ocp at f1000000 {
+		serial at 12000 {
+			status = "ok";
+		};
+
+		serial at 12100 {
+			status = "ok";
+		};
+	};
+};
diff --git a/arch/arm/boot/dts/dove-dove-db.dtsi b/arch/arm/boot/dts/dove-dove-db.dtsi
new file mode 100644
index 0000000..16c4a65
--- /dev/null
+++ b/arch/arm/boot/dts/dove-dove-db.dtsi
@@ -0,0 +1,27 @@
+/dts-v1/;
+
+/include/ "dove.dtsi"
+
+/ {
+	model = "Marvell DB-MV88AP510-BP Development Board";
+	compatible = "marvell,dove-db", "mrvl,dove";
+
+	memory {
+		device_type = "memory";
+		reg = <0x00000000 0x40000000>;
+	};
+
+	chosen {
+		bootargs = "console=ttyS0,115200n8 earlyprintk";
+	};
+
+	ocp at f1000000 {
+		serial at 12000 {
+			status = "ok";
+		};
+
+		serial at 12100 {
+			status = "ok";
+		};
+	};
+};
diff --git a/arch/arm/boot/dts/dove.dtsi b/arch/arm/boot/dts/dove.dtsi
new file mode 100644
index 0000000..3e76334
--- /dev/null
+++ b/arch/arm/boot/dts/dove.dtsi
@@ -0,0 +1,55 @@
+/include/ "skeleton.dtsi"
+
+/ {
+	compatible = "mrvl,dove";
+
+	ocp at f1000000 {
+		compatible = "simple-bus";
+		ranges = <0 0xf1000000 0x8000000>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+
+		serial at 12000 {
+			compatible = "ns16550a";
+			reg = <0x12000 0x100>;
+			reg-shift = <2>;
+			interrupts = <7>;
+			clock-frequency = <166666667>;
+			status = "disabled";
+		};
+
+		serial at 12100 {
+			compatible = "ns16550a";
+			reg = <0x12100 0x100>;
+			reg-shift = <2>;
+			interrupts = <8>;
+			clock-frequency = <166666667>;
+			status = "disabled";
+		};
+
+		serial at 12200 {
+			compatible = "ns16550a";
+			reg = <0x12200 0x100>;
+			reg-shift = <2>;
+			interrupts = <9>;
+			clock-frequency = <166666667>;
+			status = "disabled";
+		};
+
+		serial at 12300 {
+			compatible = "ns16550a";
+			reg = <0x12300 0x100>;
+			reg-shift = <2>;
+			interrupts = <10>;
+			clock-frequency = <166666667>;
+			status = "disabled";
+		};
+
+		rtc at d8500 {
+			compatible = "mrvl,dove-rtc", "mrvl,orion-rtc";
+			reg = <0xd8500 0x20>;
+			interrupts = <133>;
+		};
+
+	};
+};
-- 
1.7.10
