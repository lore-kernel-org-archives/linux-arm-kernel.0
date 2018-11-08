From: hkallweit1@gmail.com (Heiner Kallweit)
Date: Fri, 9 Nov 2018 00:29:07 +0100
Subject: [PATCH net-next v2 2/2] net: phy: remove flag PHY_HAS_INTERRUPT from
 driver configs
In-Reply-To: <a02d084d-291a-dd62-c370-c1a2dec451c7@gmail.com>
References: <a02d084d-291a-dd62-c370-c1a2dec451c7@gmail.com>
Message-ID: <65e656a4-e5b5-4a51-68e3-515649fc34ef@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that flag PHY_HAS_INTERRUPT has been replaced with a check for
callbacks config_intr and ack_interrupt, we can remove setting this
flag from all driver configs.
Last but not least remove flag PHY_HAS_INTERRUPT completely.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
v2:
- remove flag from all driver configs, not only Realtek
- remove flag completely to prevent further use
---
 drivers/net/phy/amd.c          |  1 -
 drivers/net/phy/aquantia.c     |  6 ------
 drivers/net/phy/at803x.c       |  3 ---
 drivers/net/phy/bcm63xx.c      |  4 ++--
 drivers/net/phy/bcm87xx.c      |  2 --
 drivers/net/phy/broadcom.c     | 16 ----------------
 drivers/net/phy/cicada.c       |  2 --
 drivers/net/phy/davicom.c      |  4 ----
 drivers/net/phy/dp83640.c      |  1 -
 drivers/net/phy/dp83822.c      |  1 -
 drivers/net/phy/dp83848.c      |  1 -
 drivers/net/phy/dp83867.c      |  1 -
 drivers/net/phy/dp83tc811.c    |  1 -
 drivers/net/phy/icplus.c       |  1 -
 drivers/net/phy/intel-xway.c   | 10 ----------
 drivers/net/phy/lxt.c          |  2 --
 drivers/net/phy/marvell.c      | 15 ---------------
 drivers/net/phy/meson-gxl.c    |  2 +-
 drivers/net/phy/micrel.c       | 14 --------------
 drivers/net/phy/microchip.c    |  1 -
 drivers/net/phy/microchip_t1.c |  1 -
 drivers/net/phy/mscc.c         |  6 ------
 drivers/net/phy/national.c     |  1 -
 drivers/net/phy/qsemi.c        |  1 -
 drivers/net/phy/realtek.c      |  7 -------
 drivers/net/phy/smsc.c         |  7 +------
 drivers/net/phy/ste10Xp.c      |  2 --
 drivers/net/phy/vitesse.c      |  9 ---------
 include/linux/phy.h            |  5 ++---
 29 files changed, 6 insertions(+), 121 deletions(-)

diff --git a/drivers/net/phy/amd.c b/drivers/net/phy/amd.c
index 6fe5dc920..9d0504f3e 100644
--- a/drivers/net/phy/amd.c
+++ b/drivers/net/phy/amd.c
@@ -66,7 +66,6 @@ static struct phy_driver am79c_driver[] = { {
 	.name		= "AM79C874",
 	.phy_id_mask	= 0xfffffff0,
 	.features	= PHY_BASIC_FEATURES,
-	.flags		= PHY_HAS_INTERRUPT,
 	.config_init	= am79c_config_init,
 	.ack_interrupt	= am79c_ack_interrupt,
 	.config_intr	= am79c_config_intr,
diff --git a/drivers/net/phy/aquantia.c b/drivers/net/phy/aquantia.c
index 632472cab..efc0fbde9 100644
--- a/drivers/net/phy/aquantia.c
+++ b/drivers/net/phy/aquantia.c
@@ -116,7 +116,6 @@ static struct phy_driver aquantia_driver[] = {
 	.phy_id_mask	= 0xfffffff0,
 	.name		= "Aquantia AQ1202",
 	.features	= PHY_10GBIT_FULL_FEATURES,
-	.flags		= PHY_HAS_INTERRUPT,
 	.aneg_done	= genphy_c45_aneg_done,
 	.config_aneg    = aquantia_config_aneg,
 	.config_intr	= aquantia_config_intr,
@@ -128,7 +127,6 @@ static struct phy_driver aquantia_driver[] = {
 	.phy_id_mask	= 0xfffffff0,
 	.name		= "Aquantia AQ2104",
 	.features	= PHY_10GBIT_FULL_FEATURES,
-	.flags		= PHY_HAS_INTERRUPT,
 	.aneg_done	= genphy_c45_aneg_done,
 	.config_aneg    = aquantia_config_aneg,
 	.config_intr	= aquantia_config_intr,
@@ -140,7 +138,6 @@ static struct phy_driver aquantia_driver[] = {
 	.phy_id_mask	= 0xfffffff0,
 	.name		= "Aquantia AQR105",
 	.features	= PHY_10GBIT_FULL_FEATURES,
-	.flags		= PHY_HAS_INTERRUPT,
 	.aneg_done	= genphy_c45_aneg_done,
 	.config_aneg    = aquantia_config_aneg,
 	.config_intr	= aquantia_config_intr,
@@ -152,7 +149,6 @@ static struct phy_driver aquantia_driver[] = {
 	.phy_id_mask	= 0xfffffff0,
 	.name		= "Aquantia AQR106",
 	.features	= PHY_10GBIT_FULL_FEATURES,
-	.flags		= PHY_HAS_INTERRUPT,
 	.aneg_done	= genphy_c45_aneg_done,
 	.config_aneg    = aquantia_config_aneg,
 	.config_intr	= aquantia_config_intr,
@@ -164,7 +160,6 @@ static struct phy_driver aquantia_driver[] = {
 	.phy_id_mask	= 0xfffffff0,
 	.name		= "Aquantia AQR107",
 	.features	= PHY_10GBIT_FULL_FEATURES,
-	.flags		= PHY_HAS_INTERRUPT,
 	.aneg_done	= genphy_c45_aneg_done,
 	.config_aneg    = aquantia_config_aneg,
 	.config_intr	= aquantia_config_intr,
@@ -176,7 +171,6 @@ static struct phy_driver aquantia_driver[] = {
 	.phy_id_mask	= 0xfffffff0,
 	.name		= "Aquantia AQR405",
 	.features	= PHY_10GBIT_FULL_FEATURES,
-	.flags		= PHY_HAS_INTERRUPT,
 	.aneg_done	= genphy_c45_aneg_done,
 	.config_aneg    = aquantia_config_aneg,
 	.config_intr	= aquantia_config_intr,
diff --git a/drivers/net/phy/at803x.c b/drivers/net/phy/at803x.c
index e74a047a8..f9432d053 100644
--- a/drivers/net/phy/at803x.c
+++ b/drivers/net/phy/at803x.c
@@ -379,7 +379,6 @@ static struct phy_driver at803x_driver[] = {
 	.suspend		= at803x_suspend,
 	.resume			= at803x_resume,
 	.features		= PHY_GBIT_FEATURES,
-	.flags			= PHY_HAS_INTERRUPT,
 	.ack_interrupt		= at803x_ack_interrupt,
 	.config_intr		= at803x_config_intr,
 }, {
@@ -395,7 +394,6 @@ static struct phy_driver at803x_driver[] = {
 	.suspend		= at803x_suspend,
 	.resume			= at803x_resume,
 	.features		= PHY_BASIC_FEATURES,
-	.flags			= PHY_HAS_INTERRUPT,
 	.ack_interrupt		= at803x_ack_interrupt,
 	.config_intr		= at803x_config_intr,
 }, {
@@ -410,7 +408,6 @@ static struct phy_driver at803x_driver[] = {
 	.suspend		= at803x_suspend,
 	.resume			= at803x_resume,
 	.features		= PHY_GBIT_FEATURES,
-	.flags			= PHY_HAS_INTERRUPT,
 	.aneg_done		= at803x_aneg_done,
 	.ack_interrupt		= &at803x_ack_interrupt,
 	.config_intr		= &at803x_config_intr,
diff --git a/drivers/net/phy/bcm63xx.c b/drivers/net/phy/bcm63xx.c
index d95bffdec..6a547b87f 100644
--- a/drivers/net/phy/bcm63xx.c
+++ b/drivers/net/phy/bcm63xx.c
@@ -69,7 +69,7 @@ static struct phy_driver bcm63xx_driver[] = {
 	.phy_id_mask	= 0xfffffc00,
 	.name		= "Broadcom BCM63XX (1)",
 	.features	= PHY_BASIC_FEATURES,
-	.flags		= PHY_HAS_INTERRUPT | PHY_IS_INTERNAL,
+	.flags		= PHY_IS_INTERNAL,
 	.config_init	= bcm63xx_config_init,
 	.ack_interrupt	= bcm_phy_ack_intr,
 	.config_intr	= bcm63xx_config_intr,
@@ -78,7 +78,7 @@ static struct phy_driver bcm63xx_driver[] = {
 	.phy_id		= 0x002bdc00,
 	.phy_id_mask	= 0xfffffc00,
 	.features	= PHY_BASIC_FEATURES,
-	.flags		= PHY_HAS_INTERRUPT | PHY_IS_INTERNAL,
+	.flags		= PHY_IS_INTERNAL,
 	.config_init	= bcm63xx_config_init,
 	.ack_interrupt	= bcm_phy_ack_intr,
 	.config_intr	= bcm63xx_config_intr,
diff --git a/drivers/net/phy/bcm87xx.c b/drivers/net/phy/bcm87xx.c
index f7ebdcff5..64d5ba7bf 100644
--- a/drivers/net/phy/bcm87xx.c
+++ b/drivers/net/phy/bcm87xx.c
@@ -193,7 +193,6 @@ static struct phy_driver bcm87xx_driver[] = {
 	.phy_id		= PHY_ID_BCM8706,
 	.phy_id_mask	= 0xffffffff,
 	.name		= "Broadcom BCM8706",
-	.flags		= PHY_HAS_INTERRUPT,
 	.config_init	= bcm87xx_config_init,
 	.config_aneg	= bcm87xx_config_aneg,
 	.read_status	= bcm87xx_read_status,
@@ -205,7 +204,6 @@ static struct phy_driver bcm87xx_driver[] = {
 	.phy_id		= PHY_ID_BCM8727,
 	.phy_id_mask	= 0xffffffff,
 	.name		= "Broadcom BCM8727",
-	.flags		= PHY_HAS_INTERRUPT,
 	.config_init	= bcm87xx_config_init,
 	.config_aneg	= bcm87xx_config_aneg,
 	.read_status	= bcm87xx_read_status,
diff --git a/drivers/net/phy/broadcom.c b/drivers/net/phy/broadcom.c
index 704537010..aa73c5cc5 100644
--- a/drivers/net/phy/broadcom.c
+++ b/drivers/net/phy/broadcom.c
@@ -602,7 +602,6 @@ static struct phy_driver broadcom_drivers[] = {
 	.phy_id_mask	= 0xfffffff0,
 	.name		= "Broadcom BCM5411",
 	.features	= PHY_GBIT_FEATURES,
-	.flags		= PHY_HAS_INTERRUPT,
 	.config_init	= bcm54xx_config_init,
 	.ack_interrupt	= bcm_phy_ack_intr,
 	.config_intr	= bcm_phy_config_intr,
@@ -611,7 +610,6 @@ static struct phy_driver broadcom_drivers[] = {
 	.phy_id_mask	= 0xfffffff0,
 	.name		= "Broadcom BCM5421",
 	.features	= PHY_GBIT_FEATURES,
-	.flags		= PHY_HAS_INTERRUPT,
 	.config_init	= bcm54xx_config_init,
 	.ack_interrupt	= bcm_phy_ack_intr,
 	.config_intr	= bcm_phy_config_intr,
@@ -620,7 +618,6 @@ static struct phy_driver broadcom_drivers[] = {
 	.phy_id_mask	= 0xfffffff0,
 	.name		= "Broadcom BCM54210E",
 	.features	= PHY_GBIT_FEATURES,
-	.flags		= PHY_HAS_INTERRUPT,
 	.config_init	= bcm54xx_config_init,
 	.ack_interrupt	= bcm_phy_ack_intr,
 	.config_intr	= bcm_phy_config_intr,
@@ -629,7 +626,6 @@ static struct phy_driver broadcom_drivers[] = {
 	.phy_id_mask	= 0xfffffff0,
 	.name		= "Broadcom BCM5461",
 	.features	= PHY_GBIT_FEATURES,
-	.flags		= PHY_HAS_INTERRUPT,
 	.config_init	= bcm54xx_config_init,
 	.ack_interrupt	= bcm_phy_ack_intr,
 	.config_intr	= bcm_phy_config_intr,
@@ -638,7 +634,6 @@ static struct phy_driver broadcom_drivers[] = {
 	.phy_id_mask	= 0xfffffff0,
 	.name		= "Broadcom BCM54612E",
 	.features	= PHY_GBIT_FEATURES,
-	.flags		= PHY_HAS_INTERRUPT,
 	.config_init	= bcm54xx_config_init,
 	.ack_interrupt	= bcm_phy_ack_intr,
 	.config_intr	= bcm_phy_config_intr,
@@ -647,7 +642,6 @@ static struct phy_driver broadcom_drivers[] = {
 	.phy_id_mask	= 0xfffffff0,
 	.name		= "Broadcom BCM54616S",
 	.features	= PHY_GBIT_FEATURES,
-	.flags		= PHY_HAS_INTERRUPT,
 	.config_init	= bcm54xx_config_init,
 	.config_aneg	= bcm54616s_config_aneg,
 	.ack_interrupt	= bcm_phy_ack_intr,
@@ -657,7 +651,6 @@ static struct phy_driver broadcom_drivers[] = {
 	.phy_id_mask	= 0xfffffff0,
 	.name		= "Broadcom BCM5464",
 	.features	= PHY_GBIT_FEATURES,
-	.flags		= PHY_HAS_INTERRUPT,
 	.config_init	= bcm54xx_config_init,
 	.ack_interrupt	= bcm_phy_ack_intr,
 	.config_intr	= bcm_phy_config_intr,
@@ -666,7 +659,6 @@ static struct phy_driver broadcom_drivers[] = {
 	.phy_id_mask	= 0xfffffff0,
 	.name		= "Broadcom BCM5481",
 	.features	= PHY_GBIT_FEATURES,
-	.flags		= PHY_HAS_INTERRUPT,
 	.config_init	= bcm54xx_config_init,
 	.config_aneg	= bcm5481_config_aneg,
 	.ack_interrupt	= bcm_phy_ack_intr,
@@ -676,7 +668,6 @@ static struct phy_driver broadcom_drivers[] = {
 	.phy_id_mask    = 0xfffffff0,
 	.name           = "Broadcom BCM54810",
 	.features       = PHY_GBIT_FEATURES,
-	.flags          = PHY_HAS_INTERRUPT,
 	.config_init    = bcm54xx_config_init,
 	.config_aneg    = bcm5481_config_aneg,
 	.ack_interrupt  = bcm_phy_ack_intr,
@@ -686,7 +677,6 @@ static struct phy_driver broadcom_drivers[] = {
 	.phy_id_mask	= 0xfffffff0,
 	.name		= "Broadcom BCM5482",
 	.features	= PHY_GBIT_FEATURES,
-	.flags		= PHY_HAS_INTERRUPT,
 	.config_init	= bcm5482_config_init,
 	.read_status	= bcm5482_read_status,
 	.ack_interrupt	= bcm_phy_ack_intr,
@@ -696,7 +686,6 @@ static struct phy_driver broadcom_drivers[] = {
 	.phy_id_mask	= 0xfffffff0,
 	.name		= "Broadcom BCM50610",
 	.features	= PHY_GBIT_FEATURES,
-	.flags		= PHY_HAS_INTERRUPT,
 	.config_init	= bcm54xx_config_init,
 	.ack_interrupt	= bcm_phy_ack_intr,
 	.config_intr	= bcm_phy_config_intr,
@@ -705,7 +694,6 @@ static struct phy_driver broadcom_drivers[] = {
 	.phy_id_mask	= 0xfffffff0,
 	.name		= "Broadcom BCM50610M",
 	.features	= PHY_GBIT_FEATURES,
-	.flags		= PHY_HAS_INTERRUPT,
 	.config_init	= bcm54xx_config_init,
 	.ack_interrupt	= bcm_phy_ack_intr,
 	.config_intr	= bcm_phy_config_intr,
@@ -714,7 +702,6 @@ static struct phy_driver broadcom_drivers[] = {
 	.phy_id_mask	= 0xfffffff0,
 	.name		= "Broadcom BCM57780",
 	.features	= PHY_GBIT_FEATURES,
-	.flags		= PHY_HAS_INTERRUPT,
 	.config_init	= bcm54xx_config_init,
 	.ack_interrupt	= bcm_phy_ack_intr,
 	.config_intr	= bcm_phy_config_intr,
@@ -723,7 +710,6 @@ static struct phy_driver broadcom_drivers[] = {
 	.phy_id_mask	= 0xfffffff0,
 	.name		= "Broadcom BCMAC131",
 	.features	= PHY_BASIC_FEATURES,
-	.flags		= PHY_HAS_INTERRUPT,
 	.config_init	= brcm_fet_config_init,
 	.ack_interrupt	= brcm_fet_ack_interrupt,
 	.config_intr	= brcm_fet_config_intr,
@@ -732,7 +718,6 @@ static struct phy_driver broadcom_drivers[] = {
 	.phy_id_mask	= 0xfffffff0,
 	.name		= "Broadcom BCM5241",
 	.features	= PHY_BASIC_FEATURES,
-	.flags		= PHY_HAS_INTERRUPT,
 	.config_init	= brcm_fet_config_init,
 	.ack_interrupt	= brcm_fet_ack_interrupt,
 	.config_intr	= brcm_fet_config_intr,
@@ -751,7 +736,6 @@ static struct phy_driver broadcom_drivers[] = {
 	.phy_id_mask    = 0xfffffff0,
 	.name           = "Broadcom BCM89610",
 	.features       = PHY_GBIT_FEATURES,
-	.flags          = PHY_HAS_INTERRUPT,
 	.config_init    = bcm54xx_config_init,
 	.ack_interrupt  = bcm_phy_ack_intr,
 	.config_intr    = bcm_phy_config_intr,
diff --git a/drivers/net/phy/cicada.c b/drivers/net/phy/cicada.c
index c05af00bf..fea61c81b 100644
--- a/drivers/net/phy/cicada.c
+++ b/drivers/net/phy/cicada.c
@@ -108,7 +108,6 @@ static struct phy_driver cis820x_driver[] = {
 	.name		= "Cicada Cis8201",
 	.phy_id_mask	= 0x000ffff0,
 	.features	= PHY_GBIT_FEATURES,
-	.flags		= PHY_HAS_INTERRUPT,
 	.config_init	= &cis820x_config_init,
 	.ack_interrupt	= &cis820x_ack_interrupt,
 	.config_intr	= &cis820x_config_intr,
@@ -117,7 +116,6 @@ static struct phy_driver cis820x_driver[] = {
 	.name		= "Cicada Cis8204",
 	.phy_id_mask	= 0x000fffc0,
 	.features	= PHY_GBIT_FEATURES,
-	.flags		= PHY_HAS_INTERRUPT,
 	.config_init	= &cis820x_config_init,
 	.ack_interrupt	= &cis820x_ack_interrupt,
 	.config_intr	= &cis820x_config_intr,
diff --git a/drivers/net/phy/davicom.c b/drivers/net/phy/davicom.c
index 5ee99b3b4..97162008f 100644
--- a/drivers/net/phy/davicom.c
+++ b/drivers/net/phy/davicom.c
@@ -150,7 +150,6 @@ static struct phy_driver dm91xx_driver[] = {
 	.name		= "Davicom DM9161E",
 	.phy_id_mask	= 0x0ffffff0,
 	.features	= PHY_BASIC_FEATURES,
-	.flags		= PHY_HAS_INTERRUPT,
 	.config_init	= dm9161_config_init,
 	.config_aneg	= dm9161_config_aneg,
 	.ack_interrupt	= dm9161_ack_interrupt,
@@ -160,7 +159,6 @@ static struct phy_driver dm91xx_driver[] = {
 	.name		= "Davicom DM9161B/C",
 	.phy_id_mask	= 0x0ffffff0,
 	.features	= PHY_BASIC_FEATURES,
-	.flags		= PHY_HAS_INTERRUPT,
 	.config_init	= dm9161_config_init,
 	.config_aneg	= dm9161_config_aneg,
 	.ack_interrupt	= dm9161_ack_interrupt,
@@ -170,7 +168,6 @@ static struct phy_driver dm91xx_driver[] = {
 	.name		= "Davicom DM9161A",
 	.phy_id_mask	= 0x0ffffff0,
 	.features	= PHY_BASIC_FEATURES,
-	.flags		= PHY_HAS_INTERRUPT,
 	.config_init	= dm9161_config_init,
 	.config_aneg	= dm9161_config_aneg,
 	.ack_interrupt	= dm9161_ack_interrupt,
@@ -180,7 +177,6 @@ static struct phy_driver dm91xx_driver[] = {
 	.name		= "Davicom DM9131",
 	.phy_id_mask	= 0x0ffffff0,
 	.features	= PHY_BASIC_FEATURES,
-	.flags		= PHY_HAS_INTERRUPT,
 	.ack_interrupt	= dm9161_ack_interrupt,
 	.config_intr	= dm9161_config_intr,
 } };
diff --git a/drivers/net/phy/dp83640.c b/drivers/net/phy/dp83640.c
index edd4d44a3..18b41bc34 100644
--- a/drivers/net/phy/dp83640.c
+++ b/drivers/net/phy/dp83640.c
@@ -1521,7 +1521,6 @@ static struct phy_driver dp83640_driver = {
 	.phy_id_mask	= 0xfffffff0,
 	.name		= "NatSemi DP83640",
 	.features	= PHY_BASIC_FEATURES,
-	.flags		= PHY_HAS_INTERRUPT,
 	.probe		= dp83640_probe,
 	.remove		= dp83640_remove,
 	.soft_reset	= dp83640_soft_reset,
diff --git a/drivers/net/phy/dp83822.c b/drivers/net/phy/dp83822.c
index 6e8a2a4f3..24c7f149f 100644
--- a/drivers/net/phy/dp83822.c
+++ b/drivers/net/phy/dp83822.c
@@ -318,7 +318,6 @@ static struct phy_driver dp83822_driver[] = {
 		.phy_id_mask = 0xfffffff0,
 		.name = "TI DP83822",
 		.features = PHY_BASIC_FEATURES,
-		.flags = PHY_HAS_INTERRUPT,
 		.config_init = dp83822_config_init,
 		.soft_reset = dp83822_phy_reset,
 		.get_wol = dp83822_get_wol,
diff --git a/drivers/net/phy/dp83848.c b/drivers/net/phy/dp83848.c
index 6e8e42361..a6b55909d 100644
--- a/drivers/net/phy/dp83848.c
+++ b/drivers/net/phy/dp83848.c
@@ -108,7 +108,6 @@ MODULE_DEVICE_TABLE(mdio, dp83848_tbl);
 		.phy_id_mask	= 0xfffffff0,			\
 		.name		= _name,			\
 		.features	= PHY_BASIC_FEATURES,		\
-		.flags		= PHY_HAS_INTERRUPT,		\
 								\
 		.soft_reset	= genphy_soft_reset,		\
 		.config_init	= _config_init,			\
diff --git a/drivers/net/phy/dp83867.c b/drivers/net/phy/dp83867.c
index b3935778b..da6a67d47 100644
--- a/drivers/net/phy/dp83867.c
+++ b/drivers/net/phy/dp83867.c
@@ -334,7 +334,6 @@ static struct phy_driver dp83867_driver[] = {
 		.phy_id_mask	= 0xfffffff0,
 		.name		= "TI DP83867",
 		.features	= PHY_GBIT_FEATURES,
-		.flags		= PHY_HAS_INTERRUPT,
 
 		.config_init	= dp83867_config_init,
 		.soft_reset	= dp83867_phy_reset,
diff --git a/drivers/net/phy/dp83tc811.c b/drivers/net/phy/dp83tc811.c
index 78cad134a..da1335699 100644
--- a/drivers/net/phy/dp83tc811.c
+++ b/drivers/net/phy/dp83tc811.c
@@ -346,7 +346,6 @@ static struct phy_driver dp83811_driver[] = {
 		.phy_id_mask = 0xfffffff0,
 		.name = "TI DP83TC811",
 		.features = PHY_BASIC_FEATURES,
-		.flags = PHY_HAS_INTERRUPT,
 		.config_init = dp83811_config_init,
 		.config_aneg = dp83811_config_aneg,
 		.soft_reset = dp83811_phy_reset,
diff --git a/drivers/net/phy/icplus.c b/drivers/net/phy/icplus.c
index 791587a49..21ce68964 100644
--- a/drivers/net/phy/icplus.c
+++ b/drivers/net/phy/icplus.c
@@ -234,7 +234,6 @@ static struct phy_driver icplus_driver[] = {
 	.name		= "ICPlus IP101A/G",
 	.phy_id_mask	= 0x0ffffff0,
 	.features	= PHY_BASIC_FEATURES,
-	.flags		= PHY_HAS_INTERRUPT,
 	.ack_interrupt	= ip101a_g_ack_interrupt,
 	.config_init	= &ip101a_g_config_init,
 	.suspend	= genphy_suspend,
diff --git a/drivers/net/phy/intel-xway.c b/drivers/net/phy/intel-xway.c
index 7d936fb61..fc0f5024a 100644
--- a/drivers/net/phy/intel-xway.c
+++ b/drivers/net/phy/intel-xway.c
@@ -242,7 +242,6 @@ static struct phy_driver xway_gphy[] = {
 		.phy_id_mask	= 0xffffffff,
 		.name		= "Intel XWAY PHY11G (PEF 7071/PEF 7072) v1.3",
 		.features	= PHY_GBIT_FEATURES,
-		.flags		= PHY_HAS_INTERRUPT,
 		.config_init	= xway_gphy_config_init,
 		.config_aneg	= xway_gphy14_config_aneg,
 		.ack_interrupt	= xway_gphy_ack_interrupt,
@@ -255,7 +254,6 @@ static struct phy_driver xway_gphy[] = {
 		.phy_id_mask	= 0xffffffff,
 		.name		= "Intel XWAY PHY22F (PEF 7061) v1.3",
 		.features	= PHY_BASIC_FEATURES,
-		.flags		= PHY_HAS_INTERRUPT,
 		.config_init	= xway_gphy_config_init,
 		.config_aneg	= xway_gphy14_config_aneg,
 		.ack_interrupt	= xway_gphy_ack_interrupt,
@@ -268,7 +266,6 @@ static struct phy_driver xway_gphy[] = {
 		.phy_id_mask	= 0xffffffff,
 		.name		= "Intel XWAY PHY11G (PEF 7071/PEF 7072) v1.4",
 		.features	= PHY_GBIT_FEATURES,
-		.flags		= PHY_HAS_INTERRUPT,
 		.config_init	= xway_gphy_config_init,
 		.config_aneg	= xway_gphy14_config_aneg,
 		.ack_interrupt	= xway_gphy_ack_interrupt,
@@ -281,7 +278,6 @@ static struct phy_driver xway_gphy[] = {
 		.phy_id_mask	= 0xffffffff,
 		.name		= "Intel XWAY PHY22F (PEF 7061) v1.4",
 		.features	= PHY_BASIC_FEATURES,
-		.flags		= PHY_HAS_INTERRUPT,
 		.config_init	= xway_gphy_config_init,
 		.config_aneg	= xway_gphy14_config_aneg,
 		.ack_interrupt	= xway_gphy_ack_interrupt,
@@ -294,7 +290,6 @@ static struct phy_driver xway_gphy[] = {
 		.phy_id_mask	= 0xffffffff,
 		.name		= "Intel XWAY PHY11G (PEF 7071/PEF 7072) v1.5 / v1.6",
 		.features	= PHY_GBIT_FEATURES,
-		.flags		= PHY_HAS_INTERRUPT,
 		.config_init	= xway_gphy_config_init,
 		.ack_interrupt	= xway_gphy_ack_interrupt,
 		.did_interrupt	= xway_gphy_did_interrupt,
@@ -306,7 +301,6 @@ static struct phy_driver xway_gphy[] = {
 		.phy_id_mask	= 0xffffffff,
 		.name		= "Intel XWAY PHY22F (PEF 7061) v1.5 / v1.6",
 		.features	= PHY_BASIC_FEATURES,
-		.flags		= PHY_HAS_INTERRUPT,
 		.config_init	= xway_gphy_config_init,
 		.ack_interrupt	= xway_gphy_ack_interrupt,
 		.did_interrupt	= xway_gphy_did_interrupt,
@@ -318,7 +312,6 @@ static struct phy_driver xway_gphy[] = {
 		.phy_id_mask	= 0xffffffff,
 		.name		= "Intel XWAY PHY11G (xRX v1.1 integrated)",
 		.features	= PHY_GBIT_FEATURES,
-		.flags		= PHY_HAS_INTERRUPT,
 		.config_init	= xway_gphy_config_init,
 		.ack_interrupt	= xway_gphy_ack_interrupt,
 		.did_interrupt	= xway_gphy_did_interrupt,
@@ -330,7 +323,6 @@ static struct phy_driver xway_gphy[] = {
 		.phy_id_mask	= 0xffffffff,
 		.name		= "Intel XWAY PHY22F (xRX v1.1 integrated)",
 		.features	= PHY_BASIC_FEATURES,
-		.flags		= PHY_HAS_INTERRUPT,
 		.config_init	= xway_gphy_config_init,
 		.ack_interrupt	= xway_gphy_ack_interrupt,
 		.did_interrupt	= xway_gphy_did_interrupt,
@@ -342,7 +334,6 @@ static struct phy_driver xway_gphy[] = {
 		.phy_id_mask	= 0xffffffff,
 		.name		= "Intel XWAY PHY11G (xRX v1.2 integrated)",
 		.features	= PHY_GBIT_FEATURES,
-		.flags		= PHY_HAS_INTERRUPT,
 		.config_init	= xway_gphy_config_init,
 		.ack_interrupt	= xway_gphy_ack_interrupt,
 		.did_interrupt	= xway_gphy_did_interrupt,
@@ -354,7 +345,6 @@ static struct phy_driver xway_gphy[] = {
 		.phy_id_mask	= 0xffffffff,
 		.name		= "Intel XWAY PHY22F (xRX v1.2 integrated)",
 		.features	= PHY_BASIC_FEATURES,
-		.flags		= PHY_HAS_INTERRUPT,
 		.config_init	= xway_gphy_config_init,
 		.ack_interrupt	= xway_gphy_ack_interrupt,
 		.did_interrupt	= xway_gphy_did_interrupt,
diff --git a/drivers/net/phy/lxt.c b/drivers/net/phy/lxt.c
index c14b254b2..c9e2c84c2 100644
--- a/drivers/net/phy/lxt.c
+++ b/drivers/net/phy/lxt.c
@@ -257,7 +257,6 @@ static struct phy_driver lxt97x_driver[] = {
 	.name		= "LXT970",
 	.phy_id_mask	= 0xfffffff0,
 	.features	= PHY_BASIC_FEATURES,
-	.flags		= PHY_HAS_INTERRUPT,
 	.config_init	= lxt970_config_init,
 	.ack_interrupt	= lxt970_ack_interrupt,
 	.config_intr	= lxt970_config_intr,
@@ -266,7 +265,6 @@ static struct phy_driver lxt97x_driver[] = {
 	.name		= "LXT971",
 	.phy_id_mask	= 0xfffffff0,
 	.features	= PHY_BASIC_FEATURES,
-	.flags		= PHY_HAS_INTERRUPT,
 	.ack_interrupt	= lxt971_ack_interrupt,
 	.config_intr	= lxt971_config_intr,
 }, {
diff --git a/drivers/net/phy/marvell.c b/drivers/net/phy/marvell.c
index cbec29610..463c616a7 100644
--- a/drivers/net/phy/marvell.c
+++ b/drivers/net/phy/marvell.c
@@ -2005,7 +2005,6 @@ static struct phy_driver marvell_drivers[] = {
 		.phy_id_mask = MARVELL_PHY_ID_MASK,
 		.name = "Marvell 88E1101",
 		.features = PHY_GBIT_FEATURES,
-		.flags = PHY_HAS_INTERRUPT,
 		.probe = marvell_probe,
 		.config_init = &marvell_config_init,
 		.config_aneg = &m88e1101_config_aneg,
@@ -2024,7 +2023,6 @@ static struct phy_driver marvell_drivers[] = {
 		.phy_id_mask = MARVELL_PHY_ID_MASK,
 		.name = "Marvell 88E1112",
 		.features = PHY_GBIT_FEATURES,
-		.flags = PHY_HAS_INTERRUPT,
 		.probe = marvell_probe,
 		.config_init = &m88e1111_config_init,
 		.config_aneg = &marvell_config_aneg,
@@ -2043,7 +2041,6 @@ static struct phy_driver marvell_drivers[] = {
 		.phy_id_mask = MARVELL_PHY_ID_MASK,
 		.name = "Marvell 88E1111",
 		.features = PHY_GBIT_FEATURES,
-		.flags = PHY_HAS_INTERRUPT,
 		.probe = marvell_probe,
 		.config_init = &m88e1111_config_init,
 		.config_aneg = &marvell_config_aneg,
@@ -2063,7 +2060,6 @@ static struct phy_driver marvell_drivers[] = {
 		.phy_id_mask = MARVELL_PHY_ID_MASK,
 		.name = "Marvell 88E1118",
 		.features = PHY_GBIT_FEATURES,
-		.flags = PHY_HAS_INTERRUPT,
 		.probe = marvell_probe,
 		.config_init = &m88e1118_config_init,
 		.config_aneg = &m88e1118_config_aneg,
@@ -2082,7 +2078,6 @@ static struct phy_driver marvell_drivers[] = {
 		.phy_id_mask = MARVELL_PHY_ID_MASK,
 		.name = "Marvell 88E1121R",
 		.features = PHY_GBIT_FEATURES,
-		.flags = PHY_HAS_INTERRUPT,
 		.probe = &m88e1121_probe,
 		.config_init = &marvell_config_init,
 		.config_aneg = &m88e1121_config_aneg,
@@ -2103,7 +2098,6 @@ static struct phy_driver marvell_drivers[] = {
 		.phy_id_mask = MARVELL_PHY_ID_MASK,
 		.name = "Marvell 88E1318S",
 		.features = PHY_GBIT_FEATURES,
-		.flags = PHY_HAS_INTERRUPT,
 		.probe = marvell_probe,
 		.config_init = &m88e1318_config_init,
 		.config_aneg = &m88e1318_config_aneg,
@@ -2126,7 +2120,6 @@ static struct phy_driver marvell_drivers[] = {
 		.phy_id_mask = MARVELL_PHY_ID_MASK,
 		.name = "Marvell 88E1145",
 		.features = PHY_GBIT_FEATURES,
-		.flags = PHY_HAS_INTERRUPT,
 		.probe = marvell_probe,
 		.config_init = &m88e1145_config_init,
 		.config_aneg = &m88e1101_config_aneg,
@@ -2146,7 +2139,6 @@ static struct phy_driver marvell_drivers[] = {
 		.phy_id_mask = MARVELL_PHY_ID_MASK,
 		.name = "Marvell 88E1149R",
 		.features = PHY_GBIT_FEATURES,
-		.flags = PHY_HAS_INTERRUPT,
 		.probe = marvell_probe,
 		.config_init = &m88e1149_config_init,
 		.config_aneg = &m88e1118_config_aneg,
@@ -2165,7 +2157,6 @@ static struct phy_driver marvell_drivers[] = {
 		.phy_id_mask = MARVELL_PHY_ID_MASK,
 		.name = "Marvell 88E1240",
 		.features = PHY_GBIT_FEATURES,
-		.flags = PHY_HAS_INTERRUPT,
 		.probe = marvell_probe,
 		.config_init = &m88e1111_config_init,
 		.config_aneg = &marvell_config_aneg,
@@ -2184,7 +2175,6 @@ static struct phy_driver marvell_drivers[] = {
 		.phy_id_mask = MARVELL_PHY_ID_MASK,
 		.name = "Marvell 88E1116R",
 		.features = PHY_GBIT_FEATURES,
-		.flags = PHY_HAS_INTERRUPT,
 		.probe = marvell_probe,
 		.config_init = &m88e1116r_config_init,
 		.ack_interrupt = &marvell_ack_interrupt,
@@ -2202,7 +2192,6 @@ static struct phy_driver marvell_drivers[] = {
 		.phy_id_mask = MARVELL_PHY_ID_MASK,
 		.name = "Marvell 88E1510",
 		.features = PHY_GBIT_FIBRE_FEATURES,
-		.flags = PHY_HAS_INTERRUPT,
 		.probe = &m88e1510_probe,
 		.config_init = &m88e1510_config_init,
 		.config_aneg = &m88e1510_config_aneg,
@@ -2226,7 +2215,6 @@ static struct phy_driver marvell_drivers[] = {
 		.phy_id_mask = MARVELL_PHY_ID_MASK,
 		.name = "Marvell 88E1540",
 		.features = PHY_GBIT_FEATURES,
-		.flags = PHY_HAS_INTERRUPT,
 		.probe = m88e1510_probe,
 		.config_init = &marvell_config_init,
 		.config_aneg = &m88e1510_config_aneg,
@@ -2248,7 +2236,6 @@ static struct phy_driver marvell_drivers[] = {
 		.name = "Marvell 88E1545",
 		.probe = m88e1510_probe,
 		.features = PHY_GBIT_FEATURES,
-		.flags = PHY_HAS_INTERRUPT,
 		.config_init = &marvell_config_init,
 		.config_aneg = &m88e1510_config_aneg,
 		.read_status = &marvell_read_status,
@@ -2268,7 +2255,6 @@ static struct phy_driver marvell_drivers[] = {
 		.phy_id_mask = MARVELL_PHY_ID_MASK,
 		.name = "Marvell 88E3016",
 		.features = PHY_BASIC_FEATURES,
-		.flags = PHY_HAS_INTERRUPT,
 		.probe = marvell_probe,
 		.config_init = &m88e3016_config_init,
 		.aneg_done = &marvell_aneg_done,
@@ -2289,7 +2275,6 @@ static struct phy_driver marvell_drivers[] = {
 		.phy_id_mask = MARVELL_PHY_ID_MASK,
 		.name = "Marvell 88E6390",
 		.features = PHY_GBIT_FEATURES,
-		.flags = PHY_HAS_INTERRUPT,
 		.probe = m88e6390_probe,
 		.config_init = &marvell_config_init,
 		.config_aneg = &m88e1510_config_aneg,
diff --git a/drivers/net/phy/meson-gxl.c b/drivers/net/phy/meson-gxl.c
index ddc2c5ea3..b03bcf2c3 100644
--- a/drivers/net/phy/meson-gxl.c
+++ b/drivers/net/phy/meson-gxl.c
@@ -232,7 +232,7 @@ static struct phy_driver meson_gxl_phy[] = {
 		.phy_id_mask	= 0xfffffff0,
 		.name		= "Meson GXL Internal PHY",
 		.features	= PHY_BASIC_FEATURES,
-		.flags		= PHY_IS_INTERNAL | PHY_HAS_INTERRUPT,
+		.flags		= PHY_IS_INTERNAL,
 		.config_init	= meson_gxl_config_init,
 		.aneg_done      = genphy_aneg_done,
 		.read_status	= meson_gxl_read_status,
diff --git a/drivers/net/phy/micrel.c b/drivers/net/phy/micrel.c
index 9265dea79..cb5783905 100644
--- a/drivers/net/phy/micrel.c
+++ b/drivers/net/phy/micrel.c
@@ -918,7 +918,6 @@ static struct phy_driver ksphy_driver[] = {
 	.phy_id_mask	= MICREL_PHY_ID_MASK,
 	.name		= "Micrel KS8737",
 	.features	= PHY_BASIC_FEATURES,
-	.flags		= PHY_HAS_INTERRUPT,
 	.driver_data	= &ks8737_type,
 	.config_init	= kszphy_config_init,
 	.ack_interrupt	= kszphy_ack_interrupt,
@@ -930,7 +929,6 @@ static struct phy_driver ksphy_driver[] = {
 	.phy_id_mask	= 0x00ffffff,
 	.name		= "Micrel KSZ8021 or KSZ8031",
 	.features	= PHY_BASIC_FEATURES,
-	.flags		= PHY_HAS_INTERRUPT,
 	.driver_data	= &ksz8021_type,
 	.probe		= kszphy_probe,
 	.config_init	= kszphy_config_init,
@@ -946,7 +944,6 @@ static struct phy_driver ksphy_driver[] = {
 	.phy_id_mask	= 0x00ffffff,
 	.name		= "Micrel KSZ8031",
 	.features	= PHY_BASIC_FEATURES,
-	.flags		= PHY_HAS_INTERRUPT,
 	.driver_data	= &ksz8021_type,
 	.probe		= kszphy_probe,
 	.config_init	= kszphy_config_init,
@@ -962,7 +959,6 @@ static struct phy_driver ksphy_driver[] = {
 	.phy_id_mask	= MICREL_PHY_ID_MASK,
 	.name		= "Micrel KSZ8041",
 	.features	= PHY_BASIC_FEATURES,
-	.flags		= PHY_HAS_INTERRUPT,
 	.driver_data	= &ksz8041_type,
 	.probe		= kszphy_probe,
 	.config_init	= ksz8041_config_init,
@@ -979,7 +975,6 @@ static struct phy_driver ksphy_driver[] = {
 	.phy_id_mask	= MICREL_PHY_ID_MASK,
 	.name		= "Micrel KSZ8041RNLI",
 	.features	= PHY_BASIC_FEATURES,
-	.flags		= PHY_HAS_INTERRUPT,
 	.driver_data	= &ksz8041_type,
 	.probe		= kszphy_probe,
 	.config_init	= kszphy_config_init,
@@ -995,7 +990,6 @@ static struct phy_driver ksphy_driver[] = {
 	.phy_id_mask	= MICREL_PHY_ID_MASK,
 	.name		= "Micrel KSZ8051",
 	.features	= PHY_BASIC_FEATURES,
-	.flags		= PHY_HAS_INTERRUPT,
 	.driver_data	= &ksz8051_type,
 	.probe		= kszphy_probe,
 	.config_init	= kszphy_config_init,
@@ -1011,7 +1005,6 @@ static struct phy_driver ksphy_driver[] = {
 	.name		= "Micrel KSZ8001 or KS8721",
 	.phy_id_mask	= 0x00fffffc,
 	.features	= PHY_BASIC_FEATURES,
-	.flags		= PHY_HAS_INTERRUPT,
 	.driver_data	= &ksz8041_type,
 	.probe		= kszphy_probe,
 	.config_init	= kszphy_config_init,
@@ -1027,7 +1020,6 @@ static struct phy_driver ksphy_driver[] = {
 	.name		= "Micrel KSZ8081 or KSZ8091",
 	.phy_id_mask	= MICREL_PHY_ID_MASK,
 	.features	= PHY_BASIC_FEATURES,
-	.flags		= PHY_HAS_INTERRUPT,
 	.driver_data	= &ksz8081_type,
 	.probe		= kszphy_probe,
 	.config_init	= kszphy_config_init,
@@ -1043,7 +1035,6 @@ static struct phy_driver ksphy_driver[] = {
 	.name		= "Micrel KSZ8061",
 	.phy_id_mask	= MICREL_PHY_ID_MASK,
 	.features	= PHY_BASIC_FEATURES,
-	.flags		= PHY_HAS_INTERRUPT,
 	.config_init	= kszphy_config_init,
 	.ack_interrupt	= kszphy_ack_interrupt,
 	.config_intr	= kszphy_config_intr,
@@ -1054,7 +1045,6 @@ static struct phy_driver ksphy_driver[] = {
 	.phy_id_mask	= 0x000ffffe,
 	.name		= "Micrel KSZ9021 Gigabit PHY",
 	.features	= PHY_GBIT_FEATURES,
-	.flags		= PHY_HAS_INTERRUPT,
 	.driver_data	= &ksz9021_type,
 	.probe		= kszphy_probe,
 	.config_init	= ksz9021_config_init,
@@ -1072,7 +1062,6 @@ static struct phy_driver ksphy_driver[] = {
 	.phy_id_mask	= MICREL_PHY_ID_MASK,
 	.name		= "Micrel KSZ9031 Gigabit PHY",
 	.features	= PHY_GBIT_FEATURES,
-	.flags		= PHY_HAS_INTERRUPT,
 	.driver_data	= &ksz9021_type,
 	.probe		= kszphy_probe,
 	.config_init	= ksz9031_config_init,
@@ -1089,7 +1078,6 @@ static struct phy_driver ksphy_driver[] = {
 	.phy_id_mask	= MICREL_PHY_ID_MASK,
 	.name		= "Microchip KSZ9131 Gigabit PHY",
 	.features	= PHY_GBIT_FEATURES,
-	.flags		= PHY_HAS_INTERRUPT,
 	.driver_data	= &ksz9021_type,
 	.probe		= kszphy_probe,
 	.config_init	= ksz9131_config_init,
@@ -1115,7 +1103,6 @@ static struct phy_driver ksphy_driver[] = {
 	.phy_id_mask	= MICREL_PHY_ID_MASK,
 	.name		= "Micrel KSZ886X Switch",
 	.features	= PHY_BASIC_FEATURES,
-	.flags		= PHY_HAS_INTERRUPT,
 	.config_init	= kszphy_config_init,
 	.suspend	= genphy_suspend,
 	.resume		= genphy_resume,
@@ -1124,7 +1111,6 @@ static struct phy_driver ksphy_driver[] = {
 	.phy_id_mask	= MICREL_PHY_ID_MASK,
 	.name		= "Micrel KSZ8795",
 	.features	= PHY_BASIC_FEATURES,
-	.flags		= PHY_HAS_INTERRUPT,
 	.config_init	= kszphy_config_init,
 	.config_aneg	= ksz8873mll_config_aneg,
 	.read_status	= ksz8873mll_read_status,
diff --git a/drivers/net/phy/microchip.c b/drivers/net/phy/microchip.c
index 04b12e34d..7557bebd5 100644
--- a/drivers/net/phy/microchip.c
+++ b/drivers/net/phy/microchip.c
@@ -346,7 +346,6 @@ static struct phy_driver microchip_phy_driver[] = {
 	.name		= "Microchip LAN88xx",
 
 	.features	= PHY_GBIT_FEATURES,
-	.flags		= PHY_HAS_INTERRUPT,
 
 	.probe		= lan88xx_probe,
 	.remove		= lan88xx_remove,
diff --git a/drivers/net/phy/microchip_t1.c b/drivers/net/phy/microchip_t1.c
index c600a8509..3d09b4716 100644
--- a/drivers/net/phy/microchip_t1.c
+++ b/drivers/net/phy/microchip_t1.c
@@ -47,7 +47,6 @@ static struct phy_driver microchip_t1_phy_driver[] = {
 		.name           = "Microchip LAN87xx T1",
 
 		.features       = PHY_BASIC_T1_FEATURES,
-		.flags          = PHY_HAS_INTERRUPT,
 
 		.config_init    = genphy_config_init,
 		.config_aneg    = genphy_config_aneg,
diff --git a/drivers/net/phy/mscc.c b/drivers/net/phy/mscc.c
index a2e59f4f6..62269e578 100644
--- a/drivers/net/phy/mscc.c
+++ b/drivers/net/phy/mscc.c
@@ -1833,7 +1833,6 @@ static struct phy_driver vsc85xx_driver[] = {
 	.name		= "Microsemi FE VSC8530",
 	.phy_id_mask	= 0xfffffff0,
 	.features	= PHY_BASIC_FEATURES,
-	.flags		= PHY_HAS_INTERRUPT,
 	.soft_reset	= &genphy_soft_reset,
 	.config_init	= &vsc85xx_config_init,
 	.config_aneg    = &vsc85xx_config_aneg,
@@ -1859,7 +1858,6 @@ static struct phy_driver vsc85xx_driver[] = {
 	.name		= "Microsemi VSC8531",
 	.phy_id_mask    = 0xfffffff0,
 	.features	= PHY_GBIT_FEATURES,
-	.flags		= PHY_HAS_INTERRUPT,
 	.soft_reset	= &genphy_soft_reset,
 	.config_init    = &vsc85xx_config_init,
 	.config_aneg    = &vsc85xx_config_aneg,
@@ -1885,7 +1883,6 @@ static struct phy_driver vsc85xx_driver[] = {
 	.name		= "Microsemi FE VSC8540 SyncE",
 	.phy_id_mask	= 0xfffffff0,
 	.features	= PHY_BASIC_FEATURES,
-	.flags		= PHY_HAS_INTERRUPT,
 	.soft_reset	= &genphy_soft_reset,
 	.config_init	= &vsc85xx_config_init,
 	.config_aneg	= &vsc85xx_config_aneg,
@@ -1911,7 +1908,6 @@ static struct phy_driver vsc85xx_driver[] = {
 	.name		= "Microsemi VSC8541 SyncE",
 	.phy_id_mask    = 0xfffffff0,
 	.features	= PHY_GBIT_FEATURES,
-	.flags		= PHY_HAS_INTERRUPT,
 	.soft_reset	= &genphy_soft_reset,
 	.config_init    = &vsc85xx_config_init,
 	.config_aneg    = &vsc85xx_config_aneg,
@@ -1937,7 +1933,6 @@ static struct phy_driver vsc85xx_driver[] = {
 	.name		= "Microsemi GE VSC8574 SyncE",
 	.phy_id_mask	= 0xfffffff0,
 	.features	= PHY_GBIT_FEATURES,
-	.flags		= PHY_HAS_INTERRUPT,
 	.soft_reset	= &genphy_soft_reset,
 	.config_init    = &vsc8584_config_init,
 	.config_aneg    = &vsc85xx_config_aneg,
@@ -1964,7 +1959,6 @@ static struct phy_driver vsc85xx_driver[] = {
 	.name		= "Microsemi GE VSC8584 SyncE",
 	.phy_id_mask	= 0xfffffff0,
 	.features	= PHY_GBIT_FEATURES,
-	.flags		= PHY_HAS_INTERRUPT,
 	.soft_reset	= &genphy_soft_reset,
 	.config_init    = &vsc8584_config_init,
 	.config_aneg    = &vsc85xx_config_aneg,
diff --git a/drivers/net/phy/national.c b/drivers/net/phy/national.c
index 2b1e33696..139bed2c8 100644
--- a/drivers/net/phy/national.c
+++ b/drivers/net/phy/national.c
@@ -134,7 +134,6 @@ static struct phy_driver dp83865_driver[] = { {
 	.phy_id_mask = 0xfffffff0,
 	.name = "NatSemi DP83865",
 	.features = PHY_GBIT_FEATURES,
-	.flags = PHY_HAS_INTERRUPT,
 	.config_init = ns_config_init,
 	.ack_interrupt = ns_ack_interrupt,
 	.config_intr = ns_config_intr,
diff --git a/drivers/net/phy/qsemi.c b/drivers/net/phy/qsemi.c
index 889a4dce1..cfe2313db 100644
--- a/drivers/net/phy/qsemi.c
+++ b/drivers/net/phy/qsemi.c
@@ -116,7 +116,6 @@ static struct phy_driver qs6612_driver[] = { {
 	.name		= "QS6612",
 	.phy_id_mask	= 0xfffffff0,
 	.features	= PHY_BASIC_FEATURES,
-	.flags		= PHY_HAS_INTERRUPT,
 	.config_init	= qs6612_config_init,
 	.ack_interrupt	= qs6612_ack_interrupt,
 	.config_intr	= qs6612_config_intr,
diff --git a/drivers/net/phy/realtek.c b/drivers/net/phy/realtek.c
index abff4cdc9..3985b4a4d 100644
--- a/drivers/net/phy/realtek.c
+++ b/drivers/net/phy/realtek.c
@@ -216,12 +216,10 @@ static struct phy_driver realtek_drvs[] = {
 		.phy_id         = 0x00008201,
 		.name           = "RTL8201CP Ethernet",
 		.features       = PHY_BASIC_FEATURES,
-		.flags          = PHY_HAS_INTERRUPT,
 	}, {
 		.phy_id		= 0x001cc816,
 		.name		= "RTL8201F Fast Ethernet",
 		.features	= PHY_BASIC_FEATURES,
-		.flags		= PHY_HAS_INTERRUPT,
 		.ack_interrupt	= &rtl8201_ack_interrupt,
 		.config_intr	= &rtl8201_config_intr,
 		.suspend	= genphy_suspend,
@@ -239,7 +237,6 @@ static struct phy_driver realtek_drvs[] = {
 		.phy_id		= 0x001cc912,
 		.name		= "RTL8211B Gigabit Ethernet",
 		.features	= PHY_GBIT_FEATURES,
-		.flags		= PHY_HAS_INTERRUPT,
 		.ack_interrupt	= &rtl821x_ack_interrupt,
 		.config_intr	= &rtl8211b_config_intr,
 		.read_mmd	= &genphy_read_mmd_unsupported,
@@ -257,7 +254,6 @@ static struct phy_driver realtek_drvs[] = {
 		.phy_id		= 0x001cc914,
 		.name		= "RTL8211DN Gigabit Ethernet",
 		.features	= PHY_GBIT_FEATURES,
-		.flags		= PHY_HAS_INTERRUPT,
 		.ack_interrupt	= rtl821x_ack_interrupt,
 		.config_intr	= rtl8211e_config_intr,
 		.suspend	= genphy_suspend,
@@ -266,7 +262,6 @@ static struct phy_driver realtek_drvs[] = {
 		.phy_id		= 0x001cc915,
 		.name		= "RTL8211E Gigabit Ethernet",
 		.features	= PHY_GBIT_FEATURES,
-		.flags		= PHY_HAS_INTERRUPT,
 		.ack_interrupt	= &rtl821x_ack_interrupt,
 		.config_intr	= &rtl8211e_config_intr,
 		.suspend	= genphy_suspend,
@@ -275,7 +270,6 @@ static struct phy_driver realtek_drvs[] = {
 		.phy_id		= 0x001cc916,
 		.name		= "RTL8211F Gigabit Ethernet",
 		.features	= PHY_GBIT_FEATURES,
-		.flags		= PHY_HAS_INTERRUPT,
 		.config_init	= &rtl8211f_config_init,
 		.ack_interrupt	= &rtl8211f_ack_interrupt,
 		.config_intr	= &rtl8211f_config_intr,
@@ -287,7 +281,6 @@ static struct phy_driver realtek_drvs[] = {
 		.phy_id		= 0x001cc961,
 		.name		= "RTL8366RB Gigabit Ethernet",
 		.features	= PHY_GBIT_FEATURES,
-		.flags		= PHY_HAS_INTERRUPT,
 		.config_init	= &rtl8366rb_config_init,
 		.suspend	= genphy_suspend,
 		.resume		= genphy_resume,
diff --git a/drivers/net/phy/smsc.c b/drivers/net/phy/smsc.c
index c32820838..f9477ff55 100644
--- a/drivers/net/phy/smsc.c
+++ b/drivers/net/phy/smsc.c
@@ -219,7 +219,6 @@ static struct phy_driver smsc_phy_driver[] = {
 	.name		= "SMSC LAN83C185",
 
 	.features	= PHY_BASIC_FEATURES,
-	.flags		= PHY_HAS_INTERRUPT,
 
 	.probe		= smsc_phy_probe,
 
@@ -239,7 +238,6 @@ static struct phy_driver smsc_phy_driver[] = {
 	.name		= "SMSC LAN8187",
 
 	.features	= PHY_BASIC_FEATURES,
-	.flags		= PHY_HAS_INTERRUPT,
 
 	.probe		= smsc_phy_probe,
 
@@ -264,7 +262,6 @@ static struct phy_driver smsc_phy_driver[] = {
 	.name		= "SMSC LAN8700",
 
 	.features	= PHY_BASIC_FEATURES,
-	.flags		= PHY_HAS_INTERRUPT,
 
 	.probe		= smsc_phy_probe,
 
@@ -290,7 +287,6 @@ static struct phy_driver smsc_phy_driver[] = {
 	.name		= "SMSC LAN911x Internal PHY",
 
 	.features	= PHY_BASIC_FEATURES,
-	.flags		= PHY_HAS_INTERRUPT,
 
 	.probe		= smsc_phy_probe,
 
@@ -309,7 +305,7 @@ static struct phy_driver smsc_phy_driver[] = {
 	.name		= "SMSC LAN8710/LAN8720",
 
 	.features	= PHY_BASIC_FEATURES,
-	.flags		= PHY_HAS_INTERRUPT | PHY_RST_AFTER_CLK_EN,
+	.flags		= PHY_RST_AFTER_CLK_EN,
 
 	.probe		= smsc_phy_probe,
 
@@ -335,7 +331,6 @@ static struct phy_driver smsc_phy_driver[] = {
 	.name		= "SMSC LAN8740",
 
 	.features	= PHY_BASIC_FEATURES,
-	.flags		= PHY_HAS_INTERRUPT,
 
 	.probe		= smsc_phy_probe,
 
diff --git a/drivers/net/phy/ste10Xp.c b/drivers/net/phy/ste10Xp.c
index 2fe9a87b5..33d733684 100644
--- a/drivers/net/phy/ste10Xp.c
+++ b/drivers/net/phy/ste10Xp.c
@@ -87,7 +87,6 @@ static struct phy_driver ste10xp_pdriver[] = {
 	.phy_id_mask = 0xfffffff0,
 	.name = "STe101p",
 	.features = PHY_BASIC_FEATURES,
-	.flags = PHY_HAS_INTERRUPT,
 	.config_init = ste10Xp_config_init,
 	.ack_interrupt = ste10Xp_ack_interrupt,
 	.config_intr = ste10Xp_config_intr,
@@ -98,7 +97,6 @@ static struct phy_driver ste10xp_pdriver[] = {
 	.phy_id_mask = 0xffffffff,
 	.name = "STe100p",
 	.features = PHY_BASIC_FEATURES,
-	.flags = PHY_HAS_INTERRUPT,
 	.config_init = ste10Xp_config_init,
 	.ack_interrupt = ste10Xp_ack_interrupt,
 	.config_intr = ste10Xp_config_intr,
diff --git a/drivers/net/phy/vitesse.c b/drivers/net/phy/vitesse.c
index fbf9ad429..4ca513feb 100644
--- a/drivers/net/phy/vitesse.c
+++ b/drivers/net/phy/vitesse.c
@@ -399,7 +399,6 @@ static struct phy_driver vsc82xx_driver[] = {
 	.name           = "Vitesse VSC8234",
 	.phy_id_mask    = 0x000ffff0,
 	.features       = PHY_GBIT_FEATURES,
-	.flags          = PHY_HAS_INTERRUPT,
 	.config_init    = &vsc824x_config_init,
 	.config_aneg    = &vsc82x4_config_aneg,
 	.ack_interrupt  = &vsc824x_ack_interrupt,
@@ -409,7 +408,6 @@ static struct phy_driver vsc82xx_driver[] = {
 	.name		= "Vitesse VSC8244",
 	.phy_id_mask	= 0x000fffc0,
 	.features	= PHY_GBIT_FEATURES,
-	.flags		= PHY_HAS_INTERRUPT,
 	.config_init	= &vsc824x_config_init,
 	.config_aneg	= &vsc82x4_config_aneg,
 	.ack_interrupt	= &vsc824x_ack_interrupt,
@@ -419,7 +417,6 @@ static struct phy_driver vsc82xx_driver[] = {
 	.name		= "Vitesse VSC8514",
 	.phy_id_mask	= 0x000ffff0,
 	.features	= PHY_GBIT_FEATURES,
-	.flags		= PHY_HAS_INTERRUPT,
 	.config_init	= &vsc824x_config_init,
 	.config_aneg	= &vsc82x4_config_aneg,
 	.ack_interrupt	= &vsc824x_ack_interrupt,
@@ -429,7 +426,6 @@ static struct phy_driver vsc82xx_driver[] = {
 	.name           = "Vitesse VSC8572",
 	.phy_id_mask    = 0x000ffff0,
 	.features       = PHY_GBIT_FEATURES,
-	.flags          = PHY_HAS_INTERRUPT,
 	.config_init    = &vsc824x_config_init,
 	.config_aneg    = &vsc82x4_config_aneg,
 	.ack_interrupt  = &vsc824x_ack_interrupt,
@@ -439,7 +435,6 @@ static struct phy_driver vsc82xx_driver[] = {
 	.name           = "Vitesse VSC8574",
 	.phy_id_mask    = 0x000ffff0,
 	.features       = PHY_GBIT_FEATURES,
-	.flags          = PHY_HAS_INTERRUPT,
 	.config_init    = &vsc824x_config_init,
 	.config_aneg    = &vsc82x4_config_aneg,
 	.ack_interrupt  = &vsc824x_ack_interrupt,
@@ -449,7 +444,6 @@ static struct phy_driver vsc82xx_driver[] = {
 	.name           = "Vitesse VSC8601",
 	.phy_id_mask    = 0x000ffff0,
 	.features       = PHY_GBIT_FEATURES,
-	.flags          = PHY_HAS_INTERRUPT,
 	.config_init    = &vsc8601_config_init,
 	.ack_interrupt  = &vsc824x_ack_interrupt,
 	.config_intr    = &vsc82xx_config_intr,
@@ -494,7 +488,6 @@ static struct phy_driver vsc82xx_driver[] = {
 	.name           = "Vitesse VSC8662",
 	.phy_id_mask    = 0x000ffff0,
 	.features       = PHY_GBIT_FEATURES,
-	.flags          = PHY_HAS_INTERRUPT,
 	.config_init    = &vsc824x_config_init,
 	.config_aneg    = &vsc82x4_config_aneg,
 	.ack_interrupt  = &vsc824x_ack_interrupt,
@@ -505,7 +498,6 @@ static struct phy_driver vsc82xx_driver[] = {
 	.phy_id_mask	= 0x000ffff0,
 	.name		= "Vitesse VSC8221",
 	.features	= PHY_GBIT_FEATURES,
-	.flags		= PHY_HAS_INTERRUPT,
 	.config_init	= &vsc8221_config_init,
 	.ack_interrupt	= &vsc824x_ack_interrupt,
 	.config_intr	= &vsc82xx_config_intr,
@@ -515,7 +507,6 @@ static struct phy_driver vsc82xx_driver[] = {
 	.phy_id_mask	= 0x000ffff0,
 	.name		= "Vitesse VSC8211",
 	.features	= PHY_GBIT_FEATURES,
-	.flags		= PHY_HAS_INTERRUPT,
 	.config_init	= &vsc8221_config_init,
 	.ack_interrupt	= &vsc824x_ack_interrupt,
 	.config_intr	= &vsc82xx_config_intr,
diff --git a/include/linux/phy.h b/include/linux/phy.h
index fc90af152..649c1ee77 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -66,9 +66,8 @@ extern __ETHTOOL_DECLARE_LINK_MODE_MASK(phy_10gbit_full_features) __ro_after_ini
 #define PHY_POLL		-1
 #define PHY_IGNORE_INTERRUPT	-2
 
-#define PHY_HAS_INTERRUPT	0x00000001
-#define PHY_IS_INTERNAL		0x00000002
-#define PHY_RST_AFTER_CLK_EN	0x00000004
+#define PHY_IS_INTERNAL		0x00000001
+#define PHY_RST_AFTER_CLK_EN	0x00000002
 #define MDIO_DEVICE_IS_PHY	0x80000000
 
 /* Interface Mode definitions */
-- 
2.19.1
