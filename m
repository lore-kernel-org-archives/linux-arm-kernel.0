From: geliangtang@gmail.com (Geliang Tang)
Date: Fri, 18 Nov 2016 22:12:30 +0800
Subject: [PATCH] pinctrl: stm32: use builtin_platform_driver
In-Reply-To: <7746cfe83ca3e96ccdf503669db3ace0e3081b7f.1479455552.git.geliangtang@gmail.com>
References: <7746cfe83ca3e96ccdf503669db3ace0e3081b7f.1479455552.git.geliangtang@gmail.com>
Message-ID: <910c70b66426b79a3c045d17c9fea8dbf80b6ceb.1479457288.git.geliangtang@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use builtin_platform_driver() helper to simplify the code.

Signed-off-by: Geliang Tang <geliangtang@gmail.com>
---
 drivers/pinctrl/stm32/pinctrl-stm32f429.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/pinctrl/stm32/pinctrl-stm32f429.c b/drivers/pinctrl/stm32/pinctrl-stm32f429.c
index e9b15dc..990b867 100644
--- a/drivers/pinctrl/stm32/pinctrl-stm32f429.c
+++ b/drivers/pinctrl/stm32/pinctrl-stm32f429.c
@@ -1584,8 +1584,4 @@ static struct platform_driver stm32f429_pinctrl_driver = {
 	},
 };
 
-static int __init stm32f429_pinctrl_init(void)
-{
-	return platform_driver_register(&stm32f429_pinctrl_driver);
-}
-device_initcall(stm32f429_pinctrl_init);
+builtin_platform_driver(stm32f429_pinctrl_driver);
-- 
2.9.3
