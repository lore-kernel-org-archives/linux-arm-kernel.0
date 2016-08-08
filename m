From: weiyj.lk@gmail.com (Wei Yongjun)
Date: Mon,  8 Aug 2016 13:55:20 +0000
Subject: [PATCH -next] clk: gxbb: use builtin_platform_driver to simplify the
 code
Message-ID: <1470664520-9604-1-git-send-email-weiyj.lk@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use the builtin_platform_driver() macro to make the code simpler.

Signed-off-by: Wei Yongjun <weiyj.lk@gmail.com>
---
 drivers/clk/meson/gxbb.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/clk/meson/gxbb.c b/drivers/clk/meson/gxbb.c
index 8e36d22..b736277 100644
--- a/drivers/clk/meson/gxbb.c
+++ b/drivers/clk/meson/gxbb.c
@@ -946,8 +946,4 @@ static struct platform_driver gxbb_driver = {
 	},
 };
 
-static int __init gxbb_clkc_init(void)
-{
-	return platform_driver_register(&gxbb_driver);
-}
-device_initcall(gxbb_clkc_init);
+builtin_platform_driver(gxbb_driver);
