From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Wed, 17 Jun 2015 11:31:31 +0200
Subject: [PATCH 15/15] pinctrl: sh-pfc: Remove obsolete r8a7740
 platform_device_id entry
In-Reply-To: <1434533491-21979-1-git-send-email-geert+renesas@glider.be>
References: <1434533491-21979-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1434533491-21979-16-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since the removal of the r8a7740 legacy board code, r8a7740 is only
supported in generic DT-only ARM multi-platform builds.  The driver
doesn't need to match platform devices by name anymore, hence remove the
corresponding platform_device_id entry.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Linus Walleij <linus.walleij@linaro.org>
---
Please do not apply until the legacy r8a7740 SoC code has been removed.
Or just provide an ack, so Simon can apply it when appropriate.
---
 drivers/pinctrl/sh-pfc/core.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/pinctrl/sh-pfc/core.c b/drivers/pinctrl/sh-pfc/core.c
index 3ff523e58c38d123..aeeeb76327c0684e 100644
--- a/drivers/pinctrl/sh-pfc/core.c
+++ b/drivers/pinctrl/sh-pfc/core.c
@@ -585,9 +585,6 @@ static int sh_pfc_remove(struct platform_device *pdev)
 }
 
 static const struct platform_device_id sh_pfc_id_table[] = {
-#ifdef CONFIG_PINCTRL_PFC_R8A7740
-	{ "pfc-r8a7740", (kernel_ulong_t)&r8a7740_pinmux_info },
-#endif
 #ifdef CONFIG_PINCTRL_PFC_R8A7778
 	{ "pfc-r8a7778", (kernel_ulong_t)&r8a7778_pinmux_info },
 #endif
-- 
1.9.1
