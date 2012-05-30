From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 30 May 2012 12:47:26 +0800
Subject: [PATCH 08/22] regulator: Change ab8500 match names to reflect Device
 Tree
In-Reply-To: <1338353260-10097-1-git-send-email-lee.jones@linaro.org>
References: <1338353260-10097-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1338353260-10097-9-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The 'name' field in 'struct of_regulator_match' expects to match with
its corresponding regulator device node in the Device Tree. This patch
renames each of the regulators in the ab8500 regulator driver so this
is true.

Cc: linux-kernel at vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/regulator/ab8500.c |   22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/regulator/ab8500.c b/drivers/regulator/ab8500.c
index e1b8c54..a739f5c 100644
--- a/drivers/regulator/ab8500.c
+++ b/drivers/regulator/ab8500.c
@@ -794,17 +794,17 @@ static __devinit int ab8500_regulator_register(struct platform_device *pdev,
 }
 
 static struct of_regulator_match ab8500_regulator_matches[] = {
-	{ .name	= "LDO-AUX1",    .driver_data = (void *) AB8500_LDO_AUX1, },
-	{ .name	= "LDO-AUX2",    .driver_data = (void *) AB8500_LDO_AUX2, },
-	{ .name	= "LDO-AUX3",    .driver_data = (void *) AB8500_LDO_AUX3, },
-	{ .name	= "LDO-INTCORE", .driver_data = (void *) AB8500_LDO_INTCORE, },
-	{ .name	= "LDO-TVOUT",   .driver_data = (void *) AB8500_LDO_TVOUT, },
-	{ .name = "LDO-USB",     .driver_data = (void *) AB8500_LDO_USB, },
-	{ .name = "LDO-AUDIO",   .driver_data = (void *) AB8500_LDO_AUDIO, },
-	{ .name	= "LDO-ANAMIC1", .driver_data = (void *) AB8500_LDO_ANAMIC1, },
-	{ .name	= "LDO-ANAMIC2", .driver_data = (void *) AB8500_LDO_ANAMIC2, },
-	{ .name	= "LDO-DMIC",    .driver_data = (void *) AB8500_LDO_DMIC, },
-	{ .name	= "LDO-ANA",     .driver_data = (void *) AB8500_LDO_ANA, },
+	{ .name	= "ab8500_ldo_aux1",    .driver_data = (void *) AB8500_LDO_AUX1, },
+	{ .name	= "ab8500_ldo_aux2",    .driver_data = (void *) AB8500_LDO_AUX2, },
+	{ .name	= "ab8500_ldo_aux3",    .driver_data = (void *) AB8500_LDO_AUX3, },
+	{ .name	= "ab8500_ldo_intcore", .driver_data = (void *) AB8500_LDO_INTCORE, },
+	{ .name	= "ab8500_ldo_tvout",   .driver_data = (void *) AB8500_LDO_TVOUT, },
+	{ .name = "ab8500_ldo_usb",     .driver_data = (void *) AB8500_LDO_USB, },
+	{ .name = "ab8500_ldo_audio",   .driver_data = (void *) AB8500_LDO_AUDIO, },
+	{ .name	= "ab8500_ldo_anamic1", .driver_data = (void *) AB8500_LDO_ANAMIC1, },
+	{ .name	= "ab8500_ldo_amamic2", .driver_data = (void *) AB8500_LDO_ANAMIC2, },
+	{ .name	= "ab8500_ldo_dmic",    .driver_data = (void *) AB8500_LDO_DMIC, },
+	{ .name	= "ab8500_ldo_ana",     .driver_data = (void *) AB8500_LDO_ANA, },
 };
 
 static __devinit int
-- 
1.7.9.5
