From: scott.shu@mediatek.com (Scott Shu)
Date: Fri, 10 Jul 2015 14:04:07 +0800
Subject: [PATCH v2 4/6] ARM: Mediatek: enable GPT6 on boot up to make arch
 timer working for MT6580
In-Reply-To: <1436508249-49338-1-git-send-email-scott.shu@mediatek.com>
References: <Scott Shu <scott.shu@gmail.com>
 <1436508249-49338-1-git-send-email-scott.shu@mediatek.com>
Message-ID: <1436508249-49338-5-git-send-email-scott.shu@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We enable GTP6 which ungates the arch timer clock.

Signed-off-by: Scott Shu <scott.shu@mediatek.com>
---
 arch/arm/mach-mediatek/mediatek.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-mediatek/mediatek.c b/arch/arm/mach-mediatek/mediatek.c
index 6b38d67..469d332 100644
--- a/arch/arm/mach-mediatek/mediatek.c
+++ b/arch/arm/mach-mediatek/mediatek.c
@@ -28,7 +28,8 @@ static void __init mediatek_timer_init(void)
 {
 	void __iomem *gpt_base = 0;
 
-	if (of_machine_is_compatible("mediatek,mt6589") ||
+	if (of_machine_is_compatible("mediatek,mt6580") ||
+	    of_machine_is_compatible("mediatek,mt6589") ||
 	    of_machine_is_compatible("mediatek,mt8135") ||
 	    of_machine_is_compatible("mediatek,mt8127")) {
 		/* turn on GPT6 which ungates arch timer clocks */
@@ -46,6 +47,7 @@ static void __init mediatek_timer_init(void)
 };
 
 static const char * const mediatek_board_dt_compat[] = {
+	"mediatek,mt6580",
 	"mediatek,mt6589",
 	"mediatek,mt6592",
 	"mediatek,mt8127",
-- 
1.8.1.1.dirty
