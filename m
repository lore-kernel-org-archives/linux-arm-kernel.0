From: sjoerd.simons@collabora.co.uk (Sjoerd Simons)
Date: Mon, 25 Aug 2014 09:38:49 +0200
Subject: [PATCH v2] phy: exynos5-usbdrd: Add MODULE_DEVICE_TABLE entry
In-Reply-To: <53F8BFF3.8020001@suse.de>
References: <53F8BFF3.8020001@suse.de>
Message-ID: <1408952329-7697-1-git-send-email-sjoerd.simons@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a MODULE_DEVICE_TABLE call for OF match tables. This allows the
module to be autoloaded based on devicetree information.

Signed-off-by: Sjoerd Simons <sjoerd.simons@collabora.co.uk>
---
Changes since v1:
  - Fix an indentation nitpick spotted by Andreas F?rber

 drivers/phy/phy-exynos5-usbdrd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/phy/phy-exynos5-usbdrd.c b/drivers/phy/phy-exynos5-usbdrd.c
index b05302b..392101c 100644
--- a/drivers/phy/phy-exynos5-usbdrd.c
+++ b/drivers/phy/phy-exynos5-usbdrd.c
@@ -542,6 +542,7 @@ static const struct of_device_id exynos5_usbdrd_phy_of_match[] = {
 	},
 	{ },
 };
+MODULE_DEVICE_TABLE(of, exynos5_usbdrd_phy_of_match);
 
 static int exynos5_usbdrd_phy_probe(struct platform_device *pdev)
 {
-- 
2.1.0
