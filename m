From: csd@broadcom.com (Christian Daudt)
Date: Thu, 14 Mar 2013 15:14:28 -0700
Subject: [PATCH V2 2/2] ARM: bcm281xx: Add DT support for SMC handler
In-Reply-To: <1363299268-10506-1-git-send-email-csd@broadcom.com>
References: <1363299268-10506-1-git-send-email-csd@broadcom.com>
Message-ID: <1363299268-10506-2-git-send-email-csd@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

- Adds devicetree binding and documentation for the smc handler

Updates from V1:
- Created this separate patch for the DT portion
- Added SoC compatible to smc binding

Signed-off-by: Christian Daudt <csd@broadcom.com>

diff --git a/Documentation/devicetree/bindings/misc/smc.txt b/Documentation/devicetree/bindings/misc/smc.txt
new file mode 100644
index 0000000..02b4281
--- /dev/null
+++ b/Documentation/devicetree/bindings/misc/smc.txt
@@ -0,0 +1,14 @@
+Broadcom Secure Monitor Bounce buffer
+-----------------------------------------------------
+This binding defines the location of the bounce buffer
+used for non-secure to secure communications.
+
+Required properties:
+- compatible : "bcm,kona-smc"
+- reg : Location and size of bounce buffer
+
+Example:
+	smc at 0x3404c000 {
+		compatible = "bcm,bcm11351-smc", "bcm,kona-smc";
+		reg = <0x3404c000 0x400>; //1 KiB in SRAM
+	};
diff --git a/arch/arm/boot/dts/bcm11351.dtsi b/arch/arm/boot/dts/bcm11351.dtsi
index 8f71f40..b2b9d80 100644
--- a/arch/arm/boot/dts/bcm11351.dtsi
+++ b/arch/arm/boot/dts/bcm11351.dtsi
@@ -55,4 +55,9 @@
 		clock-frequency = <32768>;
 	};
 
+	smc at 0x3404c000 {
+		compatible = "bcm,bcm11351-smc", "bcm,kona-smc";
+		reg = <0x3404c000 0x400>; //1 KiB in SRAM
+	};
+
 };
-- 
1.7.10.4
