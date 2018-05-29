From: ray.jui@broadcom.com (Ray Jui)
Date: Tue, 29 May 2018 14:58:47 -0700
Subject: [PATCH 3/6] arm: dts: Change PCIe INTx mapping for Cygnus
In-Reply-To: <1527631130-20045-1-git-send-email-ray.jui@broadcom.com>
References: <1527631130-20045-1-git-send-email-ray.jui@broadcom.com>
Message-ID: <1527631130-20045-4-git-send-email-ray.jui@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Change the PCIe INTx mapping to model the 4 INTx interrupts in the
IRQ domain of the iProc PCIe controller itself

Signed-off-by: Ray Jui <ray.jui@broadcom.com>
---
 arch/arm/boot/dts/bcm-cygnus.dtsi | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/bcm-cygnus.dtsi b/arch/arm/boot/dts/bcm-cygnus.dtsi
index 699fdf9..6de21ef 100644
--- a/arch/arm/boot/dts/bcm-cygnus.dtsi
+++ b/arch/arm/boot/dts/bcm-cygnus.dtsi
@@ -254,9 +254,14 @@
 			compatible = "brcm,iproc-pcie";
 			reg = <0x18012000 0x1000>;
 
+			interrupt-controller;
 			#interrupt-cells = <1>;
-			interrupt-map-mask = <0 0 0 0>;
-			interrupt-map = <0 0 0 0 &gic GIC_SPI 100 IRQ_TYPE_NONE>;
+			interrupt-map-mask = <0 0 0 7>;
+			interrupt-map = <0 0 0 1 &pcie0 1>,
+					<0 0 0 2 &pcie0 2>,
+					<0 0 0 3 &pcie0 3>,
+					<0 0 0 4 &pcie0 4>;
+			interrupts = <GIC_SPI 100 IRQ_TYPE_NONE>;
 
 			linux,pci-domain = <0>;
 
@@ -289,9 +294,14 @@
 			compatible = "brcm,iproc-pcie";
 			reg = <0x18013000 0x1000>;
 
+			interrupt-controller;
 			#interrupt-cells = <1>;
-			interrupt-map-mask = <0 0 0 0>;
-			interrupt-map = <0 0 0 0 &gic GIC_SPI 106 IRQ_TYPE_NONE>;
+			interrupt-map-mask = <0 0 0 7>;
+			interrupt-map = <0 0 0 1 &pcie1 1>,
+					<0 0 0 2 &pcie1 2>,
+					<0 0 0 3 &pcie1 3>,
+					<0 0 0 4 &pcie1 4>;
+			interrupts = <GIC_SPI 106 IRQ_TYPE_NONE>;
 
 			linux,pci-domain = <1>;
 
-- 
2.1.4
