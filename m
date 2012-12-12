From: jon-hunter@ti.com (Jon Hunter)
Date: Wed, 12 Dec 2012 15:43:07 -0600
Subject: [RFC 4/5] ARM: dts: OMAP4: Add CTI nodes
In-Reply-To: <1355348588-22318-1-git-send-email-jon-hunter@ti.com>
References: <1355348588-22318-1-git-send-email-jon-hunter@ti.com>
Message-ID: <1355348588-22318-5-git-send-email-jon-hunter@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add device-tree nodes for the two Cross Trigger Interface (CTI) modules
in the OMAP4 devices.

Signed-off-by: Jon Hunter <jon-hunter@ti.com>
---
 arch/arm/boot/dts/omap4.dtsi |   23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
index 739bb79..40270c7 100644
--- a/arch/arm/boot/dts/omap4.dtsi
+++ b/arch/arm/boot/dts/omap4.dtsi
@@ -59,6 +59,29 @@
 		interrupts = <1 13 0x304>;
 	};
 
+	amba {
+		compatible = "arm,amba-bus";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+
+		cti0: cti at 0x54148000 {
+			compatible = "arm,primecell";
+			interrupts = <0 1 0x4>;
+			reg = <0x54148000 0x1000>;
+			arm,cti-name = "cti0";
+			arm,primecell-periphid = <0x003bb906>;
+		};
+
+		cti1: cti at 0x54149000 {
+			compatible = "arm,primecell";
+			interrupts = <0 2 0x4>;
+			reg = <0x54149000 0x1000>;
+			arm,cti-name = "cti1";
+			arm,primecell-periphid = <0x003bb906>;
+		};
+	};
+
 	/*
 	 * The soc node represents the soc top level view. It is uses for IPs
 	 * that are not memory mapped in the MPU view or for the MPU itself.
-- 
1.7.10.4
