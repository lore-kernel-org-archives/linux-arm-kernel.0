From: jon.mason@broadcom.com (Jon Mason)
Date: Wed, 11 May 2016 19:19:09 -0400
Subject: [PATCH v2 2/3] ARM: dts: bcm5301x: Add I2C support to the DT
In-Reply-To: <1463008750-13902-1-git-send-email-jonmason@broadcom.com>
References: <1463008750-13902-1-git-send-email-jonmason@broadcom.com>
Message-ID: <1463008750-13902-3-git-send-email-jonmason@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add I2C support to the bcm5301x Device Tree.  Since no driver changes
are needed to enable this hardware, only the device tree changes are
required to make this functional.

Signed-off-by: Jon Mason <jonmason@broadcom.com>
---
 arch/arm/boot/dts/bcm5301x.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/bcm5301x.dtsi b/arch/arm/boot/dts/bcm5301x.dtsi
index 4b9887f..ffc4a9b 100644
--- a/arch/arm/boot/dts/bcm5301x.dtsi
+++ b/arch/arm/boot/dts/bcm5301x.dtsi
@@ -218,6 +218,15 @@
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
1.9.1
