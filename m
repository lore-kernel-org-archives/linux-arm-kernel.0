From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Sat, 11 Oct 2014 17:41:10 +0200
Subject: [PATCH 2/5] phy: berlin-sata: Add support for BG2 SATA PHY
In-Reply-To: <1413042073-14253-1-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1413042073-14253-1-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <1413042073-14253-3-git-send-email-sebastian.hesselbarth@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Berlin BG2 also has a SATA PHY compatible with the current driver
except different PHY_BASE. Add a new compatible to the driver
reflecting the different PHY_BASE.

Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
---
Cc: Kishon Vijay Abraham I <kishon@ti.com> 
Cc: "Antoine T?nart" <antoine.tenart@free-electrons.com>
Cc: devicetree at vger.kernel.org
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-kernel at vger.kernel.org 
---
 drivers/phy/phy-berlin-sata.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/phy/phy-berlin-sata.c b/drivers/phy/phy-berlin-sata.c
index 9682b0f66177..71568f5444ac 100644
--- a/drivers/phy/phy-berlin-sata.c
+++ b/drivers/phy/phy-berlin-sata.c
@@ -30,6 +30,7 @@
 #define MBUS_WRITE_REQUEST_SIZE_128	(BIT(2) << 16)
 #define MBUS_READ_REQUEST_SIZE_128	(BIT(2) << 19)
 
+#define BG2_PHY_BASE		0x080
 #define BG2Q_PHY_BASE		0x200
 
 /* register 0x01 */
@@ -186,10 +187,15 @@ static u32 phy_berlin_power_down_bits[] = {
 	POWER_DOWN_PHY1,
 };
 
+static u32 bg2_sata_phy_base = BG2_PHY_BASE;
 static u32 bg2q_sata_phy_base = BG2Q_PHY_BASE;
 
 static const struct of_device_id phy_berlin_sata_of_match[] = {
 	{
+		.compatible = "marvell,berlin2-sata-phy",
+		.data = &bg2_sata_phy_base,
+	},
+	{
 		.compatible = "marvell,berlin2q-sata-phy",
 		.data = &bg2q_sata_phy_base,
 	},
-- 
2.1.1
