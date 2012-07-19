From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 19 Jul 2012 16:41:10 +0800
Subject: [PATCH] pinctrl: mxs: register driver at postcore_initcall time
Message-ID: <1342687270-32600-1-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It's not so usual, but there are still some cases which require pinctrl
driver function at arch_initcall time.  So register imx23 and imx28
pinctrl driver at postcore_initcall time.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
Hi Linus,

Not sure if it's late for 3.6.  But if possible, please help send it
for 3.6.  I need this patch to remove mxs board files after v3.6-rc1
comes out.

Regards,
Shawn

 drivers/pinctrl/pinctrl-imx23.c |    2 +-
 drivers/pinctrl/pinctrl-imx28.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-imx23.c b/drivers/pinctrl/pinctrl-imx23.c
index 75d3eff..3674d87 100644
--- a/drivers/pinctrl/pinctrl-imx23.c
+++ b/drivers/pinctrl/pinctrl-imx23.c
@@ -292,7 +292,7 @@ static int __init imx23_pinctrl_init(void)
 {
 	return platform_driver_register(&imx23_pinctrl_driver);
 }
-arch_initcall(imx23_pinctrl_init);
+postcore_initcall(imx23_pinctrl_init);
 
 static void __exit imx23_pinctrl_exit(void)
 {
diff --git a/drivers/pinctrl/pinctrl-imx28.c b/drivers/pinctrl/pinctrl-imx28.c
index b973026..0f5b212 100644
--- a/drivers/pinctrl/pinctrl-imx28.c
+++ b/drivers/pinctrl/pinctrl-imx28.c
@@ -408,7 +408,7 @@ static int __init imx28_pinctrl_init(void)
 {
 	return platform_driver_register(&imx28_pinctrl_driver);
 }
-arch_initcall(imx28_pinctrl_init);
+postcore_initcall(imx28_pinctrl_init);
 
 static void __exit imx28_pinctrl_exit(void)
 {
-- 
1.7.5.4
