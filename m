From: pramod.kumar@broadcom.com (Pramod Kumar)
Date: Fri,  3 Jun 2016 20:56:03 +0530
Subject: [PATCH v3 2/7] binding: Make "mdio-parent-bus" property from
 mandatory to optional
In-Reply-To: <1464967568-27562-1-git-send-email-pramod.kumar@broadcom.com>
References: <1464967568-27562-1-git-send-email-pramod.kumar@broadcom.com>
Message-ID: <1464967568-27562-3-git-send-email-pramod.kumar@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Change "mdio-parent-bus" from mandatory section to optional
as it won't be required by integrated MDIO multiplexer
which has bus selection and mdio transaction generation logic,
integrated inside.

Signed-off-by: Pramod Kumar <pramod.kumar@broadcom.com>
---
 Documentation/devicetree/bindings/net/mdio-mux.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/net/mdio-mux.txt b/Documentation/devicetree/bindings/net/mdio-mux.txt
index 491f5bd..f58571f 100644
--- a/Documentation/devicetree/bindings/net/mdio-mux.txt
+++ b/Documentation/devicetree/bindings/net/mdio-mux.txt
@@ -5,11 +5,12 @@ numbered uniquely in a device dependent manner.  The nodes for an MDIO
 bus multiplexer/switch will have one child node for each child bus.
 
 Required properties:
-- mdio-parent-bus : phandle to the parent MDIO bus.
 - #address-cells = <1>;
 - #size-cells = <0>;
 
 Optional properties:
+- mdio-parent-bus : phandle to the parent MDIO bus.
+
 - Other properties specific to the multiplexer/switch hardware.
 
 Required properties for child nodes:
-- 
1.9.1
