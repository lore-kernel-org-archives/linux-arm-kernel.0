From: jon.mason@broadcom.com (Jon Mason)
Date: Mon,  6 Mar 2017 11:24:45 -0500
Subject: [PATCH v3 2/2] ARM: dts: bcm5301x: Add I2C support to the DT
In-Reply-To: <1488817485-7503-1-git-send-email-jon.mason@broadcom.com>
References: <1488817485-7503-1-git-send-email-jon.mason@broadcom.com>
Message-ID: <1488817485-7503-3-git-send-email-jon.mason@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jon Mason <jonmason@broadcom.com>

Add I2C support to the bcm5301x Device Tree.  Since no driver changes
are needed to enable this hardware, only the device tree changes are
required to make this functional.

Signed-off-by: Jon Mason <jonmason@broadcom.com>
---
 arch/arm/boot/dts/bcm5301x.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/bcm5301x.dtsi b/arch/arm/boot/dts/bcm5301x.dtsi
index a9aa7be..89b3c7f5 100644
--- a/arch/arm/boot/dts/bcm5301x.dtsi
+++ b/arch/arm/boot/dts/bcm5301x.dtsi
@@ -324,6 +324,16 @@
 		};
 	};
 
+	i2c0: i2c at 18009000 {
+		compatible = "brcm,iproc-i2c";
+		reg = <0x18009000 0x50>;
+		interrupts = <GIC_SPI 121 IRQ_TYPE_NONE>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		clock-frequency = <100000>;
+		status = "disabled";
+	};
+
 	lcpll0: lcpll0 at 1800c100 {
 		#clock-cells = <1>;
 		compatible = "brcm,nsp-lcpll0";
-- 
2.7.4
