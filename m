From: hvaibhav@ti.com (Vaibhav Hiremath)
Date: Wed, 1 Feb 2012 11:56:08 +0530
Subject: [PATCH-V2] arm/dts: omap3-evm: Add i2c and twl4030 support
Message-ID: <1328077568-22043-1-git-send-email-hvaibhav@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for TWL4030, which is interfaced on i2c1 bus.
Also add clock frequencies for other i2c instances(2 & 3)
required for client-device exist on OMAP3EVM board.

Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
Cc: Benoit Cousson <b-cousson@ti.com>
Cc: Grant Likely <grant.likely@secretlab.ca>
Cc: Tony Lindgren <tony@atomide.com>
---
Changes from V1:
	- As per comment from Benoit, changed hex representation
	  from uppercase to lowercase.

 arch/arm/boot/dts/omap3-evm.dts |   28 ++++++++++++++++++++++++++++
 1 files changed, 28 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/omap3-evm.dts b/arch/arm/boot/dts/omap3-evm.dts
index 2eee16e..f349ee9 100644
--- a/arch/arm/boot/dts/omap3-evm.dts
+++ b/arch/arm/boot/dts/omap3-evm.dts
@@ -18,3 +18,31 @@
 		reg = <0x80000000 0x10000000>; /* 256 MB */
 	};
 };
+
+&i2c1 {
+	clock-frequency = <2600000>;
+
+	twl: twl at 48 {
+		reg = <0x48>;
+		interrupts = <7>; /* SYS_NIRQ cascaded to intc */
+		interrupt-parent = <&intc>;
+	};
+};
+
+/include/ "twl4030.dtsi"
+
+&i2c2 {
+	clock-frequency = <400000>;
+};
+
+&i2c3 {
+	clock-frequency = <400000>;
+
+	/*
+	 * TVP5146 Video decoder-in for analog input support.
+	 */
+	tvp5146 at 5c {
+		compatible = "ti,tvp5146m2";
+		reg = <0x5c>;
+	};
+};
--
1.7.0.4
