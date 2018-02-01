From: robh@kernel.org (Rob Herring)
Date: Thu,  1 Feb 2018 15:32:40 -0600
Subject: [PATCH RESEND] arm64: dts: cavium: fix PCI bus dtc warnings
Message-ID: <20180201213240.28862-1-robh@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

dtc recently added PCI bus checks. Fix these warnings:

arch/arm64/boot/dts/cavium/thunder2-99xx.dtb: Warning (pci_bridge): Node /pci missing bus-range for PCI bridge
arch/arm64/boot/dts/cavium/thunder2-99xx.dtb: Warning (unit_address_vs_reg): Node /pci has a reg or ranges property, but no unit name

Signed-off-by: Rob Herring <robh@kernel.org>
Cc: Jayachandran C <jnair@caviumnetworks.com>
---
Arnd, Olof,

Going thru my backlog of patches and found this one never made it 
upstream. Please apply.

Rob

 arch/arm64/boot/dts/cavium/thunder2-99xx.dtsi | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/cavium/thunder2-99xx.dtsi b/arch/arm64/boot/dts/cavium/thunder2-99xx.dtsi
index 4220fbdcb24a..ff5c4c47b22b 100644
--- a/arch/arm64/boot/dts/cavium/thunder2-99xx.dtsi
+++ b/arch/arm64/boot/dts/cavium/thunder2-99xx.dtsi
@@ -98,7 +98,7 @@
 		clock-output-names = "clk125mhz";
 	};
 
-	pci {
+	pcie at 30000000 {
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
2.14.1
