From: jon.mason@broadcom.com (Jon Mason)
Date: Thu,  2 Mar 2017 19:21:34 -0500
Subject: [PATCH v2 3/3] ARM: dts: bcm5301x: Add I2C support to the DT
In-Reply-To: <1488500494-20622-1-git-send-email-jon.mason@broadcom.com>
References: <1488500494-20622-1-git-send-email-jon.mason@broadcom.com>
Message-ID: <1488500494-20622-4-git-send-email-jon.mason@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jon Mason <jonmason@broadcom.com>

Add I2C support to the bcm5301x Device Tree.  Since no driver changes
are needed to enable this hardware, only the device tree changes are
required to make this functional.

Signed-off-by: Jon Mason <jonmason@broadcom.com>
---
 arch/arm/boot/dts/bcm5301x.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/bcm5301x.dtsi b/arch/arm/boot/dts/bcm5301x.dtsi
index 4e3fbce..2a343f2 100644
--- a/arch/arm/boot/dts/bcm5301x.dtsi
+++ b/arch/arm/boot/dts/bcm5301x.dtsi
@@ -338,6 +338,15 @@
 		};
 	};
 
+	i2c0: i2c at 18009000 {
+		compatible = "brcm,iproc-i2c";
+		reg = <0x18009000 0x50>;
+		interrupts = <GIC_SPI 121 IRQ_TYPE_NONE>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		clock-frequency = <100000>;
+	};
+
 	lcpll0: lcpll0 at 1800c100 {
 		#clock-cells = <1>;
 		compatible = "brcm,nsp-lcpll0";
-- 
2.7.4
