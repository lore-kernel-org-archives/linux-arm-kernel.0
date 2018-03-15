From: david@lechnology.com (David Lechner)
Date: Thu, 15 Mar 2018 13:13:41 -0500
Subject: [PATCH] ARM: davinci: DA8XX: simplify CFGCHIP regmap_config
Message-ID: <1521137621-6491-1-git-send-email-david@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since commit 8253bb3f8255 ("regmap: potentially duplicate the name
string stored in regmap"), the name field of struct regmap_config
is copied in __regmap_init(), so we no longer need to worry about
keeping our own copy of the name.

Just use a string literal in the initialization of da8xx_cfgchip_config
instead of creating a separate variable for the name.

Signed-off-by: David Lechner <david@lechnology.com>
---
 arch/arm/mach-davinci/devices-da8xx.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/arm/mach-davinci/devices-da8xx.c b/arch/arm/mach-davinci/devices-da8xx.c
index 273b6c2..1fd3619 100644
--- a/arch/arm/mach-davinci/devices-da8xx.c
+++ b/arch/arm/mach-davinci/devices-da8xx.c
@@ -1095,11 +1095,8 @@ int __init da850_register_sata(unsigned long refclkpn)
 
 static struct regmap *da8xx_cfgchip;
 
-/* regmap doesn't make a copy of this, so we need to keep the pointer around */
-static const char da8xx_cfgchip_name[] = "cfgchip";
-
 static const struct regmap_config da8xx_cfgchip_config __initconst = {
-	.name		= da8xx_cfgchip_name,
+	.name		= "cfgchip",
 	.reg_bits	= 32,
 	.val_bits	= 32,
 	.reg_stride	= 4,
-- 
2.7.4
