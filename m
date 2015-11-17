From: jonmason@broadcom.com (Jon Mason)
Date: Tue, 17 Nov 2015 14:55:27 -0500
Subject: [PATCH 2/2] ARM: dts: NSP: Add I2C support to the DT
In-Reply-To: <1447790127-27237-1-git-send-email-jonmason@broadcom.com>
References: <1447790127-27237-1-git-send-email-jonmason@broadcom.com>
Message-ID: <1447790127-27237-3-git-send-email-jonmason@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add I2C support to the Broadcom Northstar Plus Device Tree.  Since no
driver changes are needed to enable this hardware, only the device tree
changes are required to make this functional.

Signed-off-by: Jon Mason <jonmason@broadcom.com>
---
 arch/arm/boot/dts/bcm-nsp.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/bcm-nsp.dtsi b/arch/arm/boot/dts/bcm-nsp.dtsi
index 7335a74..b74438c 100644
--- a/arch/arm/boot/dts/bcm-nsp.dtsi
+++ b/arch/arm/boot/dts/bcm-nsp.dtsi
@@ -217,5 +217,14 @@
 
 			brcm,nand-has-wp;
 		};
+
+		i2c0: i2c at 38000 {
+			compatible = "brcm,iproc-i2c";
+			reg = <0x38000 0x50>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			interrupts = <GIC_SPI 89 IRQ_TYPE_NONE>;
+			clock-frequency = <100000>;
+		};
 	};
 };
-- 
1.9.1
