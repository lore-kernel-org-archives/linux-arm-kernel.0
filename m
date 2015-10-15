From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 15 Oct 2015 15:46:50 +0200
Subject: [PATCH 10/13] soc: versatile: add support for the PB11MPCore
In-Reply-To: <1444916813-31024-1-git-send-email-linus.walleij@linaro.org>
References: <1444916813-31024-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <1444916813-31024-11-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The SoC driver needs a minor update to display the correct
sysfs information for the PB11MPCore.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
I wonder if I should Cc: arm at kernel.org on patches like this.
They seem to be the default drivers/soc maintainers.
---
 drivers/soc/versatile/soc-realview.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/soc/versatile/soc-realview.c b/drivers/soc/versatile/soc-realview.c
index e642c4540dda..c337764de867 100644
--- a/drivers/soc/versatile/soc-realview.c
+++ b/drivers/soc/versatile/soc-realview.c
@@ -36,6 +36,8 @@ static const char *realview_board_str(u32 id)
 	switch ((id >> 16) & 0xfff) {
 	case 0x0147:
 		return "HBI-0147";
+	case 0x0159:
+		return "HBI-0159";
 	default:
 		return "Unknown";
 	}
@@ -44,6 +46,8 @@ static const char *realview_board_str(u32 id)
 static const char *realview_arch_str(u32 id)
 {
 	switch ((id >> 8) & 0xf) {
+	case 0x04:
+		return "AHB";
 	case 0x05:
 		return "Multi-layer AXI";
 	default:
-- 
2.4.3
