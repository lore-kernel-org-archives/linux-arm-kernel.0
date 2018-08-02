From: o.rempel@pengutronix.de (Oleksij Rempel)
Date: Thu,  2 Aug 2018 12:34:23 +0200
Subject: [PATCH v9 4/6] regulator: pfuze100: add fsl,
 pmic-stby-poweroff property
In-Reply-To: <20180802103425.3053-1-o.rempel@pengutronix.de>
References: <20180802103425.3053-1-o.rempel@pengutronix.de>
Message-ID: <20180802103425.3053-5-o.rempel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Document the new optional "fsl,pmic-stby-poweroff" property.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/regulator/pfuze100.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/regulator/pfuze100.txt b/Documentation/devicetree/bindings/regulator/pfuze100.txt
index c7610718adff..f9be1acf891c 100644
--- a/Documentation/devicetree/bindings/regulator/pfuze100.txt
+++ b/Documentation/devicetree/bindings/regulator/pfuze100.txt
@@ -12,6 +12,11 @@ Optional properties:
   disabled. This binding is a workaround to keep backward compatibility with
   old dtb's which rely on the fact that the switched regulators are always on
   and don't mark them explicit as "regulator-always-on".
+- fsl,pmic-stby-poweroff: if present, configure the PMIC to shutdown all
+  power rails when PMIC_STBY_REQ line is asserted during the power off sequence.
+  Use this option if the SoC should be powered off by external power
+  management IC (PMIC) on PMIC_STBY_REQ signal.
+  As opposite to PMIC_STBY_REQ boards can implement PMIC_ON_REQ signal.
 
 Required child node:
 - regulators: This is the list of child nodes that specify the regulator
-- 
2.18.0
