From: o.rempel@pengutronix.de (Oleksij Rempel)
Date: Tue, 20 Jun 2017 16:09:08 +0200
Subject: [PATCH v6 4/6] regulator: pfuze100: add fsl,
 pmic-stby-poweroff property
In-Reply-To: <20170620140910.7568-1-o.rempel@pengutronix.de>
References: <20170620140910.7568-1-o.rempel@pengutronix.de>
Message-ID: <20170620140910.7568-5-o.rempel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Document the new optional "fsl,pmic-stby-poweroff" property.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/regulator/pfuze100.txt | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/regulator/pfuze100.txt b/Documentation/devicetree/bindings/regulator/pfuze100.txt
index 444c47831a40..197f1a52e960 100644
--- a/Documentation/devicetree/bindings/regulator/pfuze100.txt
+++ b/Documentation/devicetree/bindings/regulator/pfuze100.txt
@@ -4,6 +4,13 @@ Required properties:
 - compatible: "fsl,pfuze100", "fsl,pfuze200", "fsl,pfuze3000"
 - reg: I2C slave address
 
+Optional properties:
+- fsl,pmic-stby-poweroff: if present, configure the PMIC to shutdown all
+  power rails when PMIC_STBY_REQ line is asserted during the power off sequence.
+  Use this option if the SoC should be powered off by external power
+  management IC (PMIC) on PMIC_STBY_REQ signal.
+  As opposite to PMIC_STBY_REQ boards can implement PMIC_ON_REQ signal.
+
 Required child node:
 - regulators: This is the list of child nodes that specify the regulator
   initialization data for defined regulators. Please refer to below doc
-- 
2.11.0
