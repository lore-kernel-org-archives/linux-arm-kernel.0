From: peter.griffin@linaro.org (Peter Griffin)
Date: Fri, 15 Aug 2014 13:40:16 +0100
Subject: [PATCH 9/9] phy: phy-spear1340-miphy: Use module_platform_driver to
 register driver.
In-Reply-To: <1408106416-19044-1-git-send-email-peter.griffin@linaro.org>
References: <1408106416-19044-1-git-send-email-peter.griffin@linaro.org>
Message-ID: <1408106416-19044-10-git-send-email-peter.griffin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Using the module_platform_driver macro to register the driver as this gets
rid of a lot of the boilerplate code.

Also remove .owner field as this gets overridden in __platform_driver_register.

Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
---
 drivers/phy/phy-spear1340-miphy.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/phy/phy-spear1340-miphy.c b/drivers/phy/phy-spear1340-miphy.c
index ee4d66f..1ecd094 100644
--- a/drivers/phy/phy-spear1340-miphy.c
+++ b/drivers/phy/phy-spear1340-miphy.c
@@ -282,23 +282,12 @@ static struct platform_driver spear1340_miphy_driver = {
 	.probe		= spear1340_miphy_probe,
 	.driver = {
 		.name = "spear1340-miphy",
-		.owner = THIS_MODULE,
 		.pm = &spear1340_miphy_pm_ops,
 		.of_match_table = of_match_ptr(spear1340_miphy_of_match),
 	},
 };
 
-static int __init spear1340_miphy_phy_init(void)
-{
-	return platform_driver_register(&spear1340_miphy_driver);
-}
-module_init(spear1340_miphy_phy_init);
-
-static void __exit spear1340_miphy_phy_exit(void)
-{
-	platform_driver_unregister(&spear1340_miphy_driver);
-}
-module_exit(spear1340_miphy_phy_exit);
+module_platform_driver(spear1340_miphy_driver);
 
 MODULE_DESCRIPTION("ST SPEAR1340-MIPHY driver");
 MODULE_AUTHOR("Pratyush Anand <pratyush.anand@st.com>");
-- 
1.9.1
