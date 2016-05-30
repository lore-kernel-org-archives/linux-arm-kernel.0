From: pramod.kumar@broadcom.com (Pramod Kumar)
Date: Mon, 30 May 2016 12:40:47 +0530
Subject: [PATCH 3/7] binding: mdio-mux: Add DT binding doc for Broadcom MDIO
 bus mutiplexer
In-Reply-To: <1464592251-2688-1-git-send-email-pramod.kumar@broadcom.com>
References: <1464592251-2688-1-git-send-email-pramod.kumar@broadcom.com>
Message-ID: <1464592251-2688-4-git-send-email-pramod.kumar@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add DT binding doc for Broadcom MDIO bus mutiplexer driver.

Signed-off-by: Pramod Kumar <pramod.kumar@broadcom.com>
---
 .../bindings/net/brcm,mdio-mux-iproc.txt           | 64 ++++++++++++++++++++++
 1 file changed, 64 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/brcm,mdio-mux-iproc.txt

diff --git a/Documentation/devicetree/bindings/net/brcm,mdio-mux-iproc.txt b/Documentation/devicetree/bindings/net/brcm,mdio-mux-iproc.txt
new file mode 100644
index 0000000..dd74ee0
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/brcm,mdio-mux-iproc.txt
@@ -0,0 +1,64 @@
+Properties for an MDIO bus mutiplexer found in Broadcom iProc based SoCs.
+
+This MDIO bus multiplexer defines buses that could be internal as well as
+external to SoCs and could accept MDIO transaction compatible to C-22 or
+C-45 Clause. When Child bus is selected, one need to select these two
+properties as well to generate desired MDIO trascation on appropriate bus.
+
+Required properties in addition to the generic multiplexer properties:
+
+MDIO multiplexer node:
+- complatible: brcm,mdio-mux-iproc.
+
+Child bus node:
+-brcm,is-c45: Boolean property indicating PHYs attached to this bus supports
+	      C-45 mdio transaction.
+
+Every non-ethernet PHY requires a compatible so that it could be probed based
+on this compatible string.
+
+Additional information regarding generic multiplexer properties could be found
+at- Documentation/devicetree/bindings/net/mdio-mux.txt
+
+
+for example:
+		mdio_mux_iproc: mdio_mux_iproc at 6602023c {
+			compatible = "brcm,mdio-mux-iproc";
+			reg = <0x6602023c 0x14>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			mdio-integrated-mux;
+
+			mdio at 0 {
+				reg = <0x0>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				pci_phy0: pci-phy at 0 {
+					compatible = "brcm,ns2-pcie-phy";
+					reg = <0x0>;
+					#phy-cells = <0>;
+				};
+			};
+
+			mdio at 7 {
+				reg = <0x7>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				pci_phy1: pci-phy at 0 {
+					compatible = "brcm,ns2-pcie-phy";
+					reg = <0x0>;
+					#phy-cells = <0>;
+				};
+			};
+			mdio at 10 {
+				reg = <0x10>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				gphy0: eth-phy at 10 {
+					reg = <0x10>;
+				};
+			};
+		};
-- 
1.9.1
