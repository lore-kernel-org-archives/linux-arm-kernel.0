From: aneesh@ti.com (Aneesh V)
Date: Mon, 19 Dec 2011 19:35:33 +0530
Subject: [RFC v2 PATCH 3/3] arm/dts: EMIF and lpddr2 device tree data for
 OMAP4 boards
In-Reply-To: <1324303533-17458-1-git-send-email-aneesh@ti.com>
References: <1324303533-17458-1-git-send-email-aneesh@ti.com>
Message-ID: <1324303533-17458-4-git-send-email-aneesh@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Device tree data for the EMIF sdram controllers in OMAP4
and DDR memories attached to OMAP4 boards.

Cc: Rajendra Nayak <rnayak@ti.com>
Cc: Benoit Cousson <b-cousson@ti.com>
Signed-off-by: Aneesh V <aneesh@ti.com>
---
 arch/arm/boot/dts/omap-common-devices.dtsi |   63 ++++++++++++++++++++++++++++
 arch/arm/boot/dts/omap4-panda.dts          |   13 ++++++
 arch/arm/boot/dts/omap4-sdp.dts            |   13 ++++++
 arch/arm/boot/dts/omap4.dtsi               |   19 ++++++++
 4 files changed, 108 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/boot/dts/omap-common-devices.dtsi

diff --git a/arch/arm/boot/dts/omap-common-devices.dtsi b/arch/arm/boot/dts/omap-common-devices.dtsi
new file mode 100644
index 0000000..bac2a40
--- /dev/null
+++ b/arch/arm/boot/dts/omap-common-devices.dtsi
@@ -0,0 +1,63 @@
+/*
+ * Common devices used in different OMAP boards
+ */
+
+/ {
+	elpida_ECB240ABACN: ddr {
+		compatible 	= "Elpida,ECB240ABACN","jedec,lpddr2-s4";
+		density		= "2Gb";
+		io-width	= "x32";
+
+		tRPab-min-nCK	= <3>;
+		tRCD-min-nCK	= <3>;
+		tWR-min-nCK	= <3>;
+		tRASmin-min-nCK	= <3>;
+		tRRD-min-nCK	= <2>;
+		tWTR-min-nCK	= <2>;
+		tXP-min-nCK	= <2>;
+		tRTP-min-nCK	= <2>;
+		tCKE-min-nCK	= <3>;
+		tCKESR-min-nCK	= <3>;
+		tFAW-min-nCK	= <8>;
+
+		timings_elpida_ECB240ABACN_400mhz: ddr-timings at 1 {
+			min-freq	= <10000000>;
+			max-freq	= <400000000>;
+			tRPab-ps	= <21000>;
+			tRCD-ps		= <18000>;
+			tWR-ps		= <15000>;
+			tRAS-min-ps	= <42000>;
+			tRRD-ps		= <10000>;
+			tWTR-ps		= <7500>;
+			tXP-ps		= <7500>;
+			tRTP-ps		= <7500>;
+			tCKESR-ps	= <15000>;
+			tDQSCK-max-ps 	= <5500>;
+			tFAW-ps		= <50000>;
+			tZQCS-ps	= <90000>;
+			tZQCL-ps	= <360000>;
+			tZQinit-ps	= <1000000>;
+			tRAS-max-ns	= <70000>;
+		};
+
+		timings_elpida_ECB240ABACN_200mhz: ddr-timings@ {
+			min-freq	= <10000000>;
+			max-freq	= <200000000>;
+			tRPab-ps	= <21000>;
+			tRCD-ps		= <18000>;
+			tWR-ps		= <15000>;
+			tRAS-min-ps	= <42000>;
+			tRRD-ps		= <10000>;
+			tWTR-ps		= <10000>;
+			tXP-ps		= <7500>;
+			tRTP-ps		= <7500>;
+			tCKESR-ps	= <15000>;
+			tDQSCK-max-ps 	= <5500>;
+			tFAW-ps		= <50000>;
+			tZQCS-ps	= <90000>;
+			tZQCL-ps	= <360000>;
+			tZQinit-ps	= <1000000>;
+			tRAS-max-ns	= <70000>;
+		};
+	};
+};
diff --git a/arch/arm/boot/dts/omap4-panda.dts b/arch/arm/boot/dts/omap4-panda.dts
index c702657..3446f4f 100644
--- a/arch/arm/boot/dts/omap4-panda.dts
+++ b/arch/arm/boot/dts/omap4-panda.dts
@@ -8,6 +8,7 @@
 /dts-v1/;
 
 /include/ "omap4.dtsi"
+/include/ "omap-common-devices.dtsi"
 
 / {
 	model = "TI OMAP4 PandaBoard";
@@ -26,4 +27,16 @@
 		device_type = "memory";
 		reg = <0x80000000 0x40000000>; /* 1 GB */
 	};
+
+	ocp {
+		emif1: emif at 0x4c000000 {
+			cs1-used;
+			ddr-handle = <&elpida_ECB240ABACN>;
+		};
+
+		emif2: emif at 0x4d000000 {
+			cs1-used;
+			ddr-handle = <&elpida_ECB240ABACN>;
+		};
+	};
 };
diff --git a/arch/arm/boot/dts/omap4-sdp.dts b/arch/arm/boot/dts/omap4-sdp.dts
index 066e28c..799ac0a 100644
--- a/arch/arm/boot/dts/omap4-sdp.dts
+++ b/arch/arm/boot/dts/omap4-sdp.dts
@@ -8,6 +8,7 @@
 /dts-v1/;
 
 /include/ "omap4.dtsi"
+/include/ "omap-common-devices.dtsi"
 
 / {
 	model = "TI OMAP4 SDP board";
@@ -26,4 +27,16 @@
 		device_type = "memory";
 		reg = <0x80000000 0x40000000>; /* 1 GB */
 	};
+
+	ocp {
+		emif1: emif at 0x4c000000 {
+			cs1-used;
+			ddr-handle = <&elpida_ECB240ABACN>;
+		};
+
+		emif2: emif at 0x4d000000 {
+			cs1-used;
+			ddr-handle = <&elpida_ECB240ABACN>;
+		};
+	};
 };
diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
index 4c61c82..5393ae5 100644
--- a/arch/arm/boot/dts/omap4.dtsi
+++ b/arch/arm/boot/dts/omap4.dtsi
@@ -99,5 +99,24 @@
 			reg = <0x48241000 0x1000>,
 			      <0x48240100 0x0100>;
 		};
+
+		emif1: emif at 0x4c000000 {
+			compatible	= "ti,emif-lpddr2";
+			ti,hwmods	= "emif1";
+			phy-type	= "phy-type-omap4";
+			hw-caps-read-idle-ctrl;
+			hw-caps-ll-interface;
+			hw-caps-temp-alert;
+		};
+
+		emif2: emif at 0x4d000000 {
+			compatible	= "ti,emif-lpddr2";
+			ti,hwmods	= "emif2";
+			phy-type	= "phy-type-omap4";
+			hw-caps-read-idle-ctrl;
+			hw-caps-ll-interface;
+			hw-caps-temp-alert;
+		};
+
 	};
 };
-- 
1.7.1
