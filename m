From: arno@natisbad.org (Arnaud Ebalard)
Date: Tue, 16 Dec 2014 01:24:01 +0100
Subject: [PATCHv1 5/7] regulator: isl9305: deprecate use of isl in compatible
 string for isil
In-Reply-To: <cover.1418688042.git.arno@natisbad.org>
References: <cover.1418688042.git.arno@natisbad.org>
Message-ID: <910bc2f86cac0eb42e3df671c28da74542f8ba61.1418688043.git.arno@natisbad.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


"isil" and "isl" prefixes are used at various locations inside the kernel
to reference Intersil corporation. This patch is part of a series fixing
those locations were "isl" is used in compatible strings to use the now
expected "isil" prefix instead (NASDAQ symbol for Intersil and most used
version). The old compatible string is kept for backward compatibility.

Signed-off-by: Arnaud Ebalard <arno@natisbad.org>
---
 Documentation/devicetree/bindings/regulator/isl9305.txt | 4 ++--
 drivers/regulator/isl9305.c                             | 6 ++++--
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/regulator/isl9305.txt b/Documentation/devicetree/bindings/regulator/isl9305.txt
index a626fc1bbf0d..d6e7c9ec9413 100644
--- a/Documentation/devicetree/bindings/regulator/isl9305.txt
+++ b/Documentation/devicetree/bindings/regulator/isl9305.txt
@@ -2,7 +2,7 @@ Intersil ISL9305/ISL9305H voltage regulator
 
 Required properties:
 
-- compatible: "isl,isl9305" or "isl,isl9305h"
+- compatible: "isil,isl9305" or "isil,isl9305h"
 - reg: I2C slave address, usually 0x68.
 - regulators: A node that houses a sub-node for each regulator within the
   device. Each sub-node is identified using the node's name, with valid
@@ -19,7 +19,7 @@ Optional properties:
 Example
 
 	pmic: isl9305 at 68 {
-		compatible = "isl,isl9305";
+		compatible = "isil,isl9305";
 		reg = <0x68>;
 
 		VINDCD1-supply = <&system_power>;
diff --git a/drivers/regulator/isl9305.c b/drivers/regulator/isl9305.c
index 92fefd98da58..6e3a15fe00f1 100644
--- a/drivers/regulator/isl9305.c
+++ b/drivers/regulator/isl9305.c
@@ -177,8 +177,10 @@ static int isl9305_i2c_probe(struct i2c_client *i2c,
 
 #ifdef CONFIG_OF
 static const struct of_device_id isl9305_dt_ids[] = {
-	{ .compatible = "isl,isl9305" },
-	{ .compatible = "isl,isl9305h" },
+	{ .compatible = "isl,isl9305" }, /* for backward compat., don't use */
+	{ .compatible = "isil,isl9305" },
+	{ .compatible = "isl,isl9305h" }, /* for backward compat., don't use */
+	{ .compatible = "isil,isl9305h" },
 	{},
 };
 #endif
-- 
2.1.1
