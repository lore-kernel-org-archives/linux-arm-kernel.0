From: ray.jui@broadcom.com (Ray Jui)
Date: Tue, 12 Jun 2018 13:21:27 -0700
Subject: [PATCH 1/5] ARM: dts: cygnus: Fix I2C controller interrupt type
In-Reply-To: <1528834891-17807-1-git-send-email-ray.jui@broadcom.com>
References: <1528834891-17807-1-git-send-email-ray.jui@broadcom.com>
Message-ID: <1528834891-17807-2-git-send-email-ray.jui@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix I2C controller interrupt to use IRQ_TYPE_LEVEL_HIGH for Broadcom
Cygnus SoC

Fixes: b51c05a331ff ("ARM: dts: add I2C device nodes for Broadcom Cygnus")
Fixes: 0f0b21a83ad2 ("ARM: dts: Move all Cygnus peripherals into axi bus")
Fixes: 9c5101f7a253 ("ARM: dts: Reorder Cygnus peripherals")

Signed-off-by: Ray Jui <ray.jui@broadcom.com>
---
 arch/arm/boot/dts/bcm-cygnus.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/bcm-cygnus.dtsi b/arch/arm/boot/dts/bcm-cygnus.dtsi
index 9fe4f5a..835a6f7 100644
--- a/arch/arm/boot/dts/bcm-cygnus.dtsi
+++ b/arch/arm/boot/dts/bcm-cygnus.dtsi
@@ -216,7 +216,7 @@
 			reg = <0x18008000 0x100>;
 			#address-cells = <1>;
 			#size-cells = <0>;
-			interrupts = <GIC_SPI 85 IRQ_TYPE_NONE>;
+			interrupts = <GIC_SPI 85 IRQ_TYPE_LEVEL_HIGH>;
 			clock-frequency = <100000>;
 			status = "disabled";
 		};
@@ -245,7 +245,7 @@
 			reg = <0x1800b000 0x100>;
 			#address-cells = <1>;
 			#size-cells = <0>;
-			interrupts = <GIC_SPI 86 IRQ_TYPE_NONE>;
+			interrupts = <GIC_SPI 86 IRQ_TYPE_LEVEL_HIGH>;
 			clock-frequency = <100000>;
 			status = "disabled";
 		};
-- 
2.1.4
