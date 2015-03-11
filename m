From: rjui@broadcom.com (Ray Jui)
Date: Wed, 11 Mar 2015 11:06:09 -0700
Subject: [PATCH v6 4/4] ARM: dts: enable PCIe support for Cygnus
In-Reply-To: <1426097169-20805-1-git-send-email-rjui@broadcom.com>
References: <1426097169-20805-1-git-send-email-rjui@broadcom.com>
Message-ID: <1426097169-20805-5-git-send-email-rjui@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add PCIe device nodes in bcm-cygnus.dtsi but keep them disabled there.
Only enable them for bcm958300k where PCIe interfaces are populated

Signed-off-by: Ray Jui <rjui@broadcom.com>
Reviewed-by: Scott Branden <sbranden@broadcom.com>
---
 arch/arm/boot/dts/bcm-cygnus.dtsi |   42 +++++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/bcm958300k.dts  |    8 +++++++
 2 files changed, 50 insertions(+)

diff --git a/arch/arm/boot/dts/bcm-cygnus.dtsi b/arch/arm/boot/dts/bcm-cygnus.dtsi
index ff5fb6a..ee0c6e4 100644
--- a/arch/arm/boot/dts/bcm-cygnus.dtsi
+++ b/arch/arm/boot/dts/bcm-cygnus.dtsi
@@ -90,6 +90,48 @@
 		status = "disabled";
 	};
 
+	pcie0: pcie at 18012000 {
+		compatible = "brcm,iproc-pcie";
+		reg = <0x18012000 0x1000>;
+
+		#interrupt-cells = <1>;
+		interrupt-map-mask = <0 0 0 0>;
+		interrupt-map = <0 0 0 0 &gic GIC_SPI 100 IRQ_TYPE_NONE>;
+
+		linux,pci-domain = <0>;
+
+		bus-range = <0x00 0xff>;
+
+		#address-cells = <3>;
+		#size-cells = <2>;
+		device_type = "pci";
+		ranges = <0x81000000 0 0	  0x28000000 0 0x00010000
+			  0x82000000 0 0x20000000 0x20000000 0 0x04000000>;
+
+		status = "disabled";
+	};
+
+	pcie1: pcie at 18013000 {
+		compatible = "brcm,iproc-pcie";
+		reg = <0x18013000 0x1000>;
+
+		#interrupt-cells = <1>;
+		interrupt-map-mask = <0 0 0 0>;
+		interrupt-map = <0 0 0 0 &gic GIC_SPI 106 IRQ_TYPE_NONE>;
+
+		linux,pci-domain = <1>;
+
+		bus-range = <0x00 0xff>;
+
+		#address-cells = <3>;
+		#size-cells = <2>;
+		device_type = "pci";
+		ranges = <0x81000000 0 0	  0x48000000 0 0x00010000
+			  0x82000000 0 0x40000000 0x40000000 0 0x04000000>;
+
+		status = "disabled";
+	};
+
 	uart0: serial at 18020000 {
 		compatible = "snps,dw-apb-uart";
 		reg = <0x18020000 0x100>;
diff --git a/arch/arm/boot/dts/bcm958300k.dts b/arch/arm/boot/dts/bcm958300k.dts
index f1bb36f..c9eb856 100644
--- a/arch/arm/boot/dts/bcm958300k.dts
+++ b/arch/arm/boot/dts/bcm958300k.dts
@@ -47,6 +47,14 @@
 		bootargs = "console=ttyS0,115200";
 	};
 
+	pcie0: pcie at 18012000 {
+		status = "okay";
+	};
+
+	pcie1: pcie at 18013000 {
+		status = "okay";
+	};
+
 	uart3: serial at 18023000 {
 		status = "okay";
 	};
-- 
1.7.9.5
