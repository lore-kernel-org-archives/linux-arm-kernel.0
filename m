From: pramod.kumar@broadcom.com (Pramod Kumar)
Date: Mon, 30 May 2016 12:40:46 +0530
Subject: [PATCH 2/7] DT: phy.txt: Add mdio-integrated-mux property
In-Reply-To: <1464592251-2688-1-git-send-email-pramod.kumar@broadcom.com>
References: <1464592251-2688-1-git-send-email-pramod.kumar@broadcom.com>
Message-ID: <1464592251-2688-3-git-send-email-pramod.kumar@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This property is used by integrated MDIO multiplexer
which has bus selection and mdio transaction generation logic,
integrated inside.

Signed-off-by: Pramod Kumar <pramod.kumar@broadcom.com>
---
 Documentation/devicetree/bindings/net/mdio-mux.txt | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/net/mdio-mux.txt b/Documentation/devicetree/bindings/net/mdio-mux.txt
index 491f5bd..b5ad83e 100644
--- a/Documentation/devicetree/bindings/net/mdio-mux.txt
+++ b/Documentation/devicetree/bindings/net/mdio-mux.txt
@@ -5,13 +5,20 @@ numbered uniquely in a device dependent manner.  The nodes for an MDIO
 bus multiplexer/switch will have one child node for each child bus.
 
 Required properties:
-- mdio-parent-bus : phandle to the parent MDIO bus.
 - #address-cells = <1>;
 - #size-cells = <0>;
 
 Optional properties:
+- mdio-parent-bus : phandle to the parent MDIO bus. Should be used
+		if parent mdio bus is not part of multiplexer.
+- mdio-integrated-mux: boolean property indicateing that the hardware
+		is an integrated multiplex supporting muxed bus selection
+		and MDIO transaction logic generation.
 - Other properties specific to the multiplexer/switch hardware.
 
+Note: one of mdio-parent-bus and mdio-integrated-mux is mandatory to
+get parent bus regsitered.
+
 Required properties for child nodes:
 - #address-cells = <1>;
 - #size-cells = <0>;
-- 
1.9.1
