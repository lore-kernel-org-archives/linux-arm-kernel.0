From: djkurtz@chromium.org (Daniel Kurtz)
Date: Fri, 18 Dec 2015 12:21:11 +0800
Subject: [PATCH] pinctrl: mediatek: convert to arch_initcall
Message-ID: <1450412497-25872-1-git-send-email-djkurtz@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move pinctrl initialization earlier in boot so that real devices can find
their pctldev without probe deferring.

Signed-off-by: Daniel Kurtz <djkurtz@chromium.org>
---
 drivers/pinctrl/mediatek/pinctrl-mt6397.c | 2 +-
 drivers/pinctrl/mediatek/pinctrl-mt8127.c | 2 +-
 drivers/pinctrl/mediatek/pinctrl-mt8135.c | 2 +-
 drivers/pinctrl/mediatek/pinctrl-mt8173.c | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/pinctrl/mediatek/pinctrl-mt6397.c b/drivers/pinctrl/mediatek/pinctrl-mt6397.c
index f9751ae..a3780d4 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mt6397.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mt6397.c
@@ -70,7 +70,7 @@ static int __init mtk_pinctrl_init(void)
 	return platform_driver_register(&mtk_pinctrl_driver);
 }
 
-module_init(mtk_pinctrl_init);
+arch_initcall(mtk_pinctrl_init);
 
 MODULE_LICENSE("GPL v2");
 MODULE_DESCRIPTION("MediaTek MT6397 Pinctrl Driver");
diff --git a/drivers/pinctrl/mediatek/pinctrl-mt8127.c b/drivers/pinctrl/mediatek/pinctrl-mt8127.c
index b317b0b..98e0beb 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mt8127.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mt8127.c
@@ -351,7 +351,7 @@ static int __init mtk_pinctrl_init(void)
 	return platform_driver_register(&mtk_pinctrl_driver);
 }
 
-module_init(mtk_pinctrl_init);
+arch_initcall(mtk_pinctrl_init);
 
 MODULE_LICENSE("GPL v2");
 MODULE_DESCRIPTION("MediaTek MT8127 Pinctrl Driver");
diff --git a/drivers/pinctrl/mediatek/pinctrl-mt8135.c b/drivers/pinctrl/mediatek/pinctrl-mt8135.c
index 404f117..1c153b8 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mt8135.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mt8135.c
@@ -366,7 +366,7 @@ static int __init mtk_pinctrl_init(void)
 	return platform_driver_register(&mtk_pinctrl_driver);
 }
 
-module_init(mtk_pinctrl_init);
+arch_initcall(mtk_pinctrl_init);
 
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("MediaTek Pinctrl Driver");
diff --git a/drivers/pinctrl/mediatek/pinctrl-mt8173.c b/drivers/pinctrl/mediatek/pinctrl-mt8173.c
index ad27184..a62514e 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mt8173.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mt8173.c
@@ -394,7 +394,7 @@ static int __init mtk_pinctrl_init(void)
 	return platform_driver_register(&mtk_pinctrl_driver);
 }
 
-module_init(mtk_pinctrl_init);
+arch_initcall(mtk_pinctrl_init);
 
 MODULE_LICENSE("GPL v2");
 MODULE_DESCRIPTION("MediaTek Pinctrl Driver");
-- 
2.6.0.rc2.230.g3dd15c0
