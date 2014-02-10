From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Mon, 10 Feb 2014 16:24:58 -0300
Subject: [PATCH 2/2] bus: mvebu: Add support for the Armada 38x SoCs
In-Reply-To: <1392060298-27094-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1392060298-27094-1-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <1392060298-27094-3-git-send-email-ezequiel.garcia@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

The mvebu-mbus driver handles the special MBus mechanism of Marvell
EBU SoCs. The two new members of the EBU family, the Armada 380 and
Armada 385, are identical in terms of MBus handling, and share the
same number of windows and register organization as Armada 370/XP.

Therefore, this commit adds a new "marvell,armada380-mbus" compatible
string, which for now uses the same data structure as the one for
Armada 370 and Armada XP.

The SoC-specific compatible string is added in order to allow
the support of SoC-specific quirks in the future.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 Documentation/devicetree/bindings/bus/mvebu-mbus.txt | 1 +
 drivers/bus/mvebu-mbus.c                             | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/bus/mvebu-mbus.txt b/Documentation/devicetree/bindings/bus/mvebu-mbus.txt
index ac21b16..d779921 100644
--- a/Documentation/devicetree/bindings/bus/mvebu-mbus.txt
+++ b/Documentation/devicetree/bindings/bus/mvebu-mbus.txt
@@ -8,6 +8,7 @@ Required properties:
 		 marvell,armadaxp-mbus
 		 marvell,armada370-mbus
 		 marvell,armada375-mbus
+		 marvell,armada380-mbus
 		 marvell,armadaxp-mbus
 		 marvell,kirkwood-mbus
 		 marvell,dove-mbus
diff --git a/drivers/bus/mvebu-mbus.c b/drivers/bus/mvebu-mbus.c
index 23af1b8..74607c4 100644
--- a/drivers/bus/mvebu-mbus.c
+++ b/drivers/bus/mvebu-mbus.c
@@ -593,6 +593,8 @@ static const struct of_device_id of_mvebu_mbus_ids[] = {
 	  .data = &armada_370_xp_mbus_data, },
 	{ .compatible = "marvell,armada375-mbus",
 	  .data = &armada_370_xp_mbus_data, },
+	{ .compatible = "marvell,armada380-mbus",
+	  .data = &armada_370_xp_mbus_data, },
 	{ .compatible = "marvell,armadaxp-mbus",
 	  .data = &armada_370_xp_mbus_data, },
 	{ .compatible = "marvell,kirkwood-mbus",
-- 
1.8.1.5
