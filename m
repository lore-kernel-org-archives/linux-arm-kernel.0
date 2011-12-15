From: linus.walleij@stericsson.com (Linus Walleij)
Date: Thu, 15 Dec 2011 13:50:08 +0100
Subject: [PATCH 1/5] ux500: support DB8520
Message-ID: <1323953408-27013-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rabin Vincent <rabin.vincent@stericsson.com>

Extend the ux500 ID table to cover the DB8520 variant.

Signed-off-by: Rabin Vincent <rabin.vincent@stericsson.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-ux500/id.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-ux500/id.c b/arch/arm/mach-ux500/id.c
index d35122e..15a0f63 100644
--- a/arch/arm/mach-ux500/id.c
+++ b/arch/arm/mach-ux500/id.c
@@ -65,6 +65,7 @@ static unsigned int partnumber(unsigned int asicid)
  * DB8500v1	0x411fc091	0x9001FFF4		0x008500A0
  * DB8500v1.1	0x411fc091	0x9001FFF4		0x008500A1
  * DB8500v2	0x412fc091	0x9001DBF4		0x008500B0
+ * DB8520v2.2	0x412fc091	0x9001DBF4		0x008500B2
  * DB5500v1	0x412fc091	0x9001FFF4		0x005500A0
  */
 
@@ -80,9 +81,10 @@ void __init ux500_map_io(void)
 		addr = 0x9001FFF4;
 		break;
 
-	case 0x412fc091: /* DB8500v2 / DB5500v1 */
+	case 0x412fc091: /* DB8520 / DB8500v2 / DB5500v1 */
 		asicid = ux500_read_asicid(0x9001DBF4);
-		if (partnumber(asicid) == 0x8500)
+		if (partnumber(asicid) == 0x8500 ||
+		    partnumber(asicid) == 0x8520)
 			/* DB8500v2 */
 			break;
 
-- 
1.7.3.2
