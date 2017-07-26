From: robh@kernel.org (Rob Herring)
Date: Wed, 26 Jul 2017 16:09:43 -0500
Subject: [PATCH v2] arm64: dts: cavium: fix PCI bus dtc warnings
In-Reply-To: <20170726210943.6875-1-robh@kernel.org>
References: <20170726210943.6875-1-robh@kernel.org>
Message-ID: <20170726210943.6875-7-robh@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

dtc recently added PCI bus checks. Fix these warnings:

arch/arm64/boot/dts/cavium/thunder2-99xx.dtb: Warning (pci_bridge): Node /pci missing bus-range for PCI bridge
arch/arm64/boot/dts/cavium/thunder2-99xx.dtb: Warning (unit_address_vs_reg): Node /pci has a reg or ranges property, but no unit name

Signed-off-by: Rob Herring <robh@kernel.org>
Cc: Jayachandran C <jnair@caviumnetworks.com>
---
v2:
- Reapply broadcom vulkan changes to thunder2.

 arch/arm64/boot/dts/cavium/thunder2-99xx.dtsi | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/cavium/thunder2-99xx.dtsi b/arch/arm64/boot/dts/cavium/thunder2-99xx.dtsi
index 4220fbdcb24a..ea50c1320bf7 100644
--- a/arch/arm64/boot/dts/cavium/thunder2-99xx.dtsi
+++ b/arch/arm64/boot/dts/cavium/thunder2-99xx.dtsi
@@ -98,7 +98,7 @@
 		clock-output-names = "clk125mhz";
 	};
 
-	pci {
+	pci at 30000000 {
 		compatible = "pci-host-ecam-generic";
 		device_type = "pci";
 		#interrupt-cells = <1>;
@@ -118,6 +118,7 @@
 		ranges =
 		  <0x02000000    0 0x40000000    0 0x40000000    0 0x20000000
 		   0x43000000 0x40 0x00000000 0x40 0x00000000 0x20 0x00000000>;
+		bus-range = <0 0xff>;
 		interrupt-map-mask = <0 0 0 7>;
 		interrupt-map =
 		      /* addr  pin  ic   icaddr  icintr */
-- 
2.11.0
