From: f.fainelli@gmail.com (Florian Fainelli)
Date: Sun, 31 Jan 2016 16:32:48 -0800
Subject: [PATCH] ARM: BCM63xx: Remove unused pmb_dn variable
Message-ID: <1454286768-20736-1-git-send-email-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Introduced in commit 3f2a43c98d72b ("ARM: BCM63xx: Add secondary CPU PMB
initialization sequence"), but not used by the code.

Reported-by: David Binderman <dcb314@hotmail.com>
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/arm/mach-bcm/bcm63xx_pmb.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/mach-bcm/bcm63xx_pmb.c b/arch/arm/mach-bcm/bcm63xx_pmb.c
index de061ec5a479..41dcf5d65630 100644
--- a/arch/arm/mach-bcm/bcm63xx_pmb.c
+++ b/arch/arm/mach-bcm/bcm63xx_pmb.c
@@ -92,7 +92,6 @@ static int bcm63xx_pmb_get_resources(struct device_node *dn,
 				     unsigned int *cpu,
 				     unsigned int *addr)
 {
-	struct device_node *pmb_dn;
 	struct of_phandle_args args;
 	int ret;
 
@@ -109,7 +108,6 @@ static int bcm63xx_pmb_get_resources(struct device_node *dn,
 		return ret;
 	}
 
-	pmb_dn = args.np;
 	if (args.args_count != 2) {
 		pr_err("reset-controller does not conform to reset-cells\n");
 		return -EINVAL;
-- 
2.5.0
