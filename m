From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 14 Apr 2014 15:54:04 +0200
Subject: [PATCH v3 07/11] ARM: mvebu: add Armada 38x compatible string to pmsu
In-Reply-To: <1397483648-26611-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1397483648-26611-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1397483648-26611-8-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since the Armada 38x PMSU registers are slightly different than the
Armada 370/XP PMSU ones, we introduce a new compatible string
"armada-380-pmsu" in the PMSU driver. These differences are not
visible for the current usage of the PMSU, but they might become
visible in the future.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 Documentation/devicetree/bindings/arm/armada-370-xp-pmsu.txt | 9 ++++++---
 arch/arm/mach-mvebu/pmsu.c                                   | 1 +
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/armada-370-xp-pmsu.txt b/Documentation/devicetree/bindings/arm/armada-370-xp-pmsu.txt
index 9761887..26799ef 100644
--- a/Documentation/devicetree/bindings/arm/armada-370-xp-pmsu.txt
+++ b/Documentation/devicetree/bindings/arm/armada-370-xp-pmsu.txt
@@ -1,11 +1,14 @@
 Power Management Service Unit(PMSU)
 -----------------------------------
-Available on Marvell SOCs: Armada 370 and Armada XP
+Available on Marvell SOCs: Armada 370, Armada 38x and Armada XP
 
 Required properties:
 
-- compatible: should be "marvell,armada-370-pmsu", whereas
-  "marvell,armada-370-xp-pmsu" is deprecated and will be removed
+- compatible: should be one of:
+  - "marvell,armada-370-pmsu" for Armada 370 or Armada XP
+  - "marvell,armada-380-pmsu" for Armada 38x
+  - "marvell,armada-370-xp-pmsu" was used for Armada 370/XP but is now
+    deprecated and will be removed
 
 - reg: Should contain PMSU registers location and length.
 
diff --git a/arch/arm/mach-mvebu/pmsu.c b/arch/arm/mach-mvebu/pmsu.c
index a1508de..a8796b8 100644
--- a/arch/arm/mach-mvebu/pmsu.c
+++ b/arch/arm/mach-mvebu/pmsu.c
@@ -38,6 +38,7 @@ static void __iomem *pmsu_mp_base;
 static struct of_device_id of_pmsu_table[] = {
 	{ .compatible = "marvell,armada-370-pmsu", },
 	{ .compatible = "marvell,armada-370-xp-pmsu", },
+	{ .compatible = "marvell,armada-380-pmsu", },
 	{ /* end of list */ },
 };
 
-- 
1.8.3.2
