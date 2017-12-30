From: contact@paulk.fr (Paul Kocialkowski)
Date: Sat, 30 Dec 2017 16:23:28 +0100
Subject: [PATCH 1/3] dt-bindings: mfd: axp20x: Document backup battery
 charging property
In-Reply-To: <20171230152330.28946-1-contact@paulk.fr>
References: <20171230152330.28946-1-contact@paulk.fr>
Message-ID: <20171230152330.28946-2-contact@paulk.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds documentation for the "backup" property of the axp20x driver,
that controls the charging mechanism for the backup battery on axp20x.

Signed-off-by: Paul Kocialkowski <contact@paulk.fr>

diff --git a/Documentation/devicetree/bindings/mfd/axp20x.txt b/Documentation/devicetree/bindings/mfd/axp20x.txt
index 9455503b0299..382776b29932 100644
--- a/Documentation/devicetree/bindings/mfd/axp20x.txt
+++ b/Documentation/devicetree/bindings/mfd/axp20x.txt
@@ -58,6 +58,11 @@ Optional properties:
 	      See Documentation/devicetree/bindings/regulator/regulator.txt
 	      for more information on standard regulator bindings.
 
+- backup: An array of two integers for backup battery charging (axp20x-only),
+	  describing the charging voltage in mV first and the charging current
+	  in uA second. Backup battery charging is only enabled when these two
+	  fields are filled.
+
 Optional properties for DCDC regulators:
 - x-powers,dcdc-workmode: 1 for PWM mode, 0 for AUTO (PWM/PFM) mode
 			  Default: Current hardware setting
@@ -256,4 +261,6 @@ axp209: pmic at 34 {
 			/* unused but preferred to be managed by OS */
 		};
 	};
+
+	backup = <3000 200>;
 };
-- 
2.15.1
