From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Sat, 19 Apr 2014 18:32:50 +0200
Subject: [PATCH 2/2] ARM: mvebu: fix the name of the parameter used in
 mvebu_get_soc_id
In-Reply-To: <1397925170-8202-1-git-send-email-gregory.clement@free-electrons.com>
References: <1397925170-8202-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <1397925170-8202-3-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The name of the two parameters of mvebu_get_soc_id were inverted. This
patch fix it in order to have a more readable code.

Reported-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 arch/arm/mach-mvebu/board-v7.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-mvebu/board-v7.c b/arch/arm/mach-mvebu/board-v7.c
index 1b6e26cc7cd1..c9320789f685 100644
--- a/arch/arm/mach-mvebu/board-v7.c
+++ b/arch/arm/mach-mvebu/board-v7.c
@@ -76,7 +76,7 @@ static void __init i2c_quirk(void)
 	 * mechanism. We can exit only if we are sure that we can
 	 * get the SoC revision and it is more recent than A0.
 	 */
-	if (mvebu_get_soc_id(&rev, &dev) == 0 && dev > MV78XX0_A0_REV)
+	if (mvebu_get_soc_id(&dev, &rev) == 0 && rev > MV78XX0_A0_REV)
 		return;
 
 	for_each_compatible_node(np, NULL, "marvell,mv78230-i2c") {
-- 
1.8.1.2
