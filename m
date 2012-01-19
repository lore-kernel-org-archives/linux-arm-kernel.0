From: aneesh@ti.com (Aneesh V)
Date: Thu, 19 Jan 2012 19:58:41 +0530
Subject: [PATCH 3/3] arm/dts: EMIF and lpddr2 device tree data for OMAP4 boards
In-Reply-To: <1324303533-17458-1-git-send-email-aneesh@ti.com>
References: <1324303533-17458-1-git-send-email-aneesh@ti.com>
Message-ID: <1326983321-319-4-git-send-email-aneesh@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Device tree data for the EMIF sdram controllers in OMAP4
and DDR memories attached to OMAP4 boards.

Cc: Rajendra Nayak <rnayak@ti.com>
Cc: Benoit Cousson <b-cousson@ti.com>
Signed-off-by: Aneesh V <aneesh@ti.com>
---
 arch/arm/boot/dts/elpida_ecb240abacn.dtsi |   64 +++++++++++++++++++++++++++++
 arch/arm/boot/dts/omap4-panda.dts         |   13 ++++++
 arch/arm/boot/dts/omap4-sdp.dts           |   13 ++++++
 arch/arm/boot/dts/omap4.dtsi              |   19 +++++++++
 4 files changed, 109 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/boot/dts/elpida_ecb240abacn.dtsi

diff --git a/arch/arm/boot/dts/elpida_ecb240abacn.dtsi b/arch/arm/boot/dts/elpida_ecb240abacn.dtsi
new file mode 100644
index 0000000..437eaff
--- /dev/null
+++ b/arch/arm/boot/dts/elpida_ecb240abacn.dtsi
@@ -0,0 +1,64 @@
+/*
+ * Common devices used in different OMAP boards
+ */
+
+/ {
+	elpida_ECB240ABACN: lpddr2 {
+		compatible 	= "Elpida,ECB240ABACN","jedec,lpddr2-s4";
+		density		= <2048>;
+		io-width	= <32>;
+
+		tRPab-min-tck	= <3>;
+		tRCD-min-tck	= <3>;
+		tWR-min-tck	= <3>;
+		tRASmin-min-tck	= <3>;
+		tRRD-min-tck	= <2>;
+		tWTR-min-tck	= <2>;
+		tXP-min-tck	= <2>;
+		tRTP-min-tck	= <2>;
+		tCKE-min-tck	= <3>;
+		tCKESR-min-tck	= <3>;
+		tFAW-min-tck	= <8>;
+
+		timings_elpida_ECB240ABACN_400mhz: lpddr2-timings at 0 {
+			compatible 	= "jedec,lpddr2-timings";
+			min-freq	= <10000000>;
+			max-freq	= <400000000>;
+			tRPab		= <21000>;
+			tRCD		= <18000>;
+			tWR		= <15000>;
+			tRAS-min	= <42000>;
+			tRRD		= <10000>;
+			tWTR		= <7500>;
+			tXP		= <7500>;
+			tRTP		= <7500>;
+			tCKESR		= <15000>;
+			tDQSCK-max 	= <5500>;
+			tFAW		= <50000>;
+			tZQCS		= <90000>;
+			tZQCL		= <360000>;
+			tZQinit		= <1000000>;
+			tRAS-max-ns	= <70000>;
+		};
+
+		timings_elpida_ECB240ABACN_200mhz: lpddr2-timings at 1 {
+			min-freq	= <10000000>;
+			max-freq	= <200000000>;
+			tRPab		= <21000>;
+			tRCD		= <18000>;
+			tWR		= <15000>;
+			tRAS-min	= <42000>;
+			tRRD		= <10000>;
+			tWTR		= <10000>;
+			tXP		= <7500>;
+			tRTP		= <7500>;
+			tCKESR		= <15000>;
+			tDQSCK-max 	= <5500>;
+			tFAW		= <50000>;
+			tZQCS		= <90000>;
+			tZQCL		= <360000>;
+			tZQinit		= <1000000>;
+			tRAS-max-ns	= <70000>;
+		};
+	};
+};
diff --git a/arch/arm/boot/dts/omap4-panda.dts b/arch/arm/boot/dts/omap4-panda.dts
index c702657..b4f3904 100644
--- a/arch/arm/boot/dts/omap4-panda.dts
+++ b/arch/arm/boot/dts/omap4-panda.dts
@@ -8,6 +8,7 @@
 /dts-v1/;
 
 /include/ "omap4.dtsi"
+/include/ "elpida_ecb240abacn.dtsi"
 
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
+			lpddr2-handle = <&elpida_ECB240ABACN>;
+		};
+
+		emif2: emif at 0x4d000000 {
+			cs1-used;
+			lpddr2-handle = <&elpida_ECB240ABACN>;
+		};
+	};
 };
diff --git a/arch/arm/boot/dts/omap4-sdp.dts b/arch/arm/boot/dts/omap4-sdp.dts
index 066e28c..7959a02 100644
--- a/arch/arm/boot/dts/omap4-sdp.dts
+++ b/arch/arm/boot/dts/omap4-sdp.dts
@@ -8,6 +8,7 @@
 /dts-v1/;
 
 /include/ "omap4.dtsi"
+/include/ "elpida_ecb240abacn.dtsi"
 
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
+			lpddr2-handle = <&elpida_ECB240ABACN>;
+		};
+
+		emif2: emif at 0x4d000000 {
+			cs1-used;
+			lpddr2-handle = <&elpida_ECB240ABACN>;
+		};
+	};
 };
diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
index e8fe75f..6399a11 100644
--- a/arch/arm/boot/dts/omap4.dtsi
+++ b/arch/arm/boot/dts/omap4.dtsi
@@ -127,5 +127,24 @@
 			ti,hwmods = "uart4";
 			clock-frequency = <48000000>;
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
+			phy-type	= <1>;
+			hw-caps-read-idle-ctrl;
+			hw-caps-ll-interface;
+			hw-caps-temp-alert;
+		};
+
 	};
 };
-- 
1.7.1
