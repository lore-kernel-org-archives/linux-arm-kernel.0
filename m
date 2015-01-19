From: rjui@broadcom.com (Ray Jui)
Date: Mon, 19 Jan 2015 11:23:48 -0800
Subject: [PATCH v6 3/3] ARM: dts: add I2C device nodes for Broadcom Cygnus
In-Reply-To: <1421695428-19102-1-git-send-email-rjui@broadcom.com>
References: <Ray Jui <rjui@broadcom.com>
 <1421695428-19102-1-git-send-email-rjui@broadcom.com>
Message-ID: <1421695428-19102-4-git-send-email-rjui@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add I2C device nodes and its properties in bcm-cygnus.dtsi but keep
them disabled there. Individual I2C devices can be enabled in board
specific dts file when I2C slave devices are enabled in the future

Signed-off-by: Ray Jui <rjui@broadcom.com>
Reviewed-by: Scott Branden <sbranden@broadcom.com>
---
 arch/arm/boot/dts/bcm-cygnus.dtsi |   20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm/boot/dts/bcm-cygnus.dtsi b/arch/arm/boot/dts/bcm-cygnus.dtsi
index 5126f9e..ff5fb6a 100644
--- a/arch/arm/boot/dts/bcm-cygnus.dtsi
+++ b/arch/arm/boot/dts/bcm-cygnus.dtsi
@@ -70,6 +70,26 @@
 		};
 	};
 
+	i2c0: i2c at 18008000 {
+		compatible = "brcm,cygnus-iproc-i2c", "brcm,iproc-i2c";
+		reg = <0x18008000 0x100>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		interrupts = <GIC_SPI 85 IRQ_TYPE_NONE>;
+		clock-frequency = <100000>;
+		status = "disabled";
+	};
+
+	i2c1: i2c at 1800b000 {
+		compatible = "brcm,cygnus-iproc-i2c", "brcm,iproc-i2c";
+		reg = <0x1800b000 0x100>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		interrupts = <GIC_SPI 86 IRQ_TYPE_NONE>;
+		clock-frequency = <100000>;
+		status = "disabled";
+	};
+
 	uart0: serial at 18020000 {
 		compatible = "snps,dw-apb-uart";
 		reg = <0x18020000 0x100>;
-- 
1.7.9.5
