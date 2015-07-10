From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Fri, 10 Jul 2015 15:26:27 +0900
Subject: [PATCH] phy: Drop owner assignment from platform_driver
Message-ID: <1436509587-27258-1-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

platform_driver does not need to set an owner because
platform_driver_register() will set it.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

---

The coccinelle script which generated the patch was sent here:
http://www.spinics.net/lists/kernel/msg2029903.html
---
 drivers/phy/phy-berlin-usb.c        | 1 -
 drivers/phy/phy-miphy28lp.c         | 1 -
 drivers/phy/phy-qcom-ufs-qmp-14nm.c | 1 -
 drivers/phy/phy-qcom-ufs-qmp-20nm.c | 1 -
 drivers/phy/phy-rockchip-usb.c      | 1 -
 5 files changed, 5 deletions(-)

diff --git a/drivers/phy/phy-berlin-usb.c b/drivers/phy/phy-berlin-usb.c
index c6fc95b53083..d7431f6ab975 100644
--- a/drivers/phy/phy-berlin-usb.c
+++ b/drivers/phy/phy-berlin-usb.c
@@ -207,7 +207,6 @@ static struct platform_driver phy_berlin_usb_driver = {
 	.probe	= phy_berlin_usb_probe,
 	.driver	= {
 		.name		= "phy-berlin-usb",
-		.owner		= THIS_MODULE,
 		.of_match_table	= phy_berlin_sata_of_match,
 	 },
 };
diff --git a/drivers/phy/phy-miphy28lp.c b/drivers/phy/phy-miphy28lp.c
index 5e257ef7ac05..677c290f4b14 100644
--- a/drivers/phy/phy-miphy28lp.c
+++ b/drivers/phy/phy-miphy28lp.c
@@ -1268,7 +1268,6 @@ static struct platform_driver miphy28lp_driver = {
 	.probe = miphy28lp_probe,
 	.driver = {
 		.name = "miphy28lp-phy",
-		.owner = THIS_MODULE,
 		.of_match_table = miphy28lp_of_match,
 	}
 };
diff --git a/drivers/phy/phy-qcom-ufs-qmp-14nm.c b/drivers/phy/phy-qcom-ufs-qmp-14nm.c
index f5fc50a9fce7..e1eea1b379fc 100644
--- a/drivers/phy/phy-qcom-ufs-qmp-14nm.c
+++ b/drivers/phy/phy-qcom-ufs-qmp-14nm.c
@@ -191,7 +191,6 @@ static struct platform_driver ufs_qcom_phy_qmp_14nm_driver = {
 	.driver = {
 		.of_match_table = ufs_qcom_phy_qmp_14nm_of_match,
 		.name = "ufs_qcom_phy_qmp_14nm",
-		.owner = THIS_MODULE,
 	},
 };
 
diff --git a/drivers/phy/phy-qcom-ufs-qmp-20nm.c b/drivers/phy/phy-qcom-ufs-qmp-20nm.c
index 8332f96b2c4a..fde8c876823b 100644
--- a/drivers/phy/phy-qcom-ufs-qmp-20nm.c
+++ b/drivers/phy/phy-qcom-ufs-qmp-20nm.c
@@ -247,7 +247,6 @@ static struct platform_driver ufs_qcom_phy_qmp_20nm_driver = {
 	.driver = {
 		.of_match_table = ufs_qcom_phy_qmp_20nm_of_match,
 		.name = "ufs_qcom_phy_qmp_20nm",
-		.owner = THIS_MODULE,
 	},
 };
 
diff --git a/drivers/phy/phy-rockchip-usb.c b/drivers/phy/phy-rockchip-usb.c
index 7d4c33643768..bf78721b58f4 100644
--- a/drivers/phy/phy-rockchip-usb.c
+++ b/drivers/phy/phy-rockchip-usb.c
@@ -146,7 +146,6 @@ static struct platform_driver rockchip_usb_driver = {
 	.probe		= rockchip_usb_phy_probe,
 	.driver		= {
 		.name	= "rockchip-usb-phy",
-		.owner	= THIS_MODULE,
 		.of_match_table = rockchip_usb_phy_dt_ids,
 	},
 };
-- 
1.9.1
