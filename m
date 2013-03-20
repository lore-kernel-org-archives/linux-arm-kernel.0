From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Wed, 20 Mar 2013 19:36:25 -0300
Subject: [PATCH 04/16] thermal: mvebu: Remove unneeded variable initialization
In-Reply-To: <1363818997-23137-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1363818997-23137-1-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <1363818997-23137-5-git-send-email-ezequiel.garcia@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This variable is used only after it's properly initialized,
so there's no need to set it to NULL in its declaration.

Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 drivers/thermal/mvebu_thermal.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/thermal/mvebu_thermal.c b/drivers/thermal/mvebu_thermal.c
index 77c488c..d54f90c 100644
--- a/drivers/thermal/mvebu_thermal.c
+++ b/drivers/thermal/mvebu_thermal.c
@@ -72,7 +72,7 @@ MODULE_DEVICE_TABLE(of, mvebu_thermal_id_table);
 
 static int mvebu_thermal_probe(struct platform_device *pdev)
 {
-	struct thermal_zone_device *thermal = NULL;
+	struct thermal_zone_device *thermal;
 	struct mvebu_thermal_priv *priv;
 	struct resource *res;
 
-- 
1.7.8.6
