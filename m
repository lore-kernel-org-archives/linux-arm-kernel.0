From: hongzhou.yang@mediatek.com (Hongzhou Yang)
Date: Wed, 27 May 2015 02:10:35 -0700
Subject: [PATCH] mfd: mediatek: Add GPIO sub module support into mfd.
Message-ID: <1432717835-16398-1-git-send-email-hongzhou.yang@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Base on Lee Jones' comment, change pinctrl subnode name.

---
Register pinctrl subnode into 6397 mfd cell.

Signed-off-by: Hongzhou Yang <hongzhou.yang@mediatek.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/mfd/mt6397-core.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/mfd/mt6397-core.c b/drivers/mfd/mt6397-core.c
index 09bc780..e50a9bc 100644
--- a/drivers/mfd/mt6397-core.c
+++ b/drivers/mfd/mt6397-core.c
@@ -34,6 +34,9 @@ static const struct mfd_cell mt6397_devs[] = {
 	}, {
 		.name = "mt6397-clk",
 		.of_compatible = "mediatek,mt6397-clk",
+	}, {
+		.name = "mt6397-pinctrl",
+		.of_compatible = "mediatek,mt6397-pinctrl",
 	},
 };
 
-- 
1.7.9.5
