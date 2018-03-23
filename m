From: mchehab@s-opensource.com (Mauro Carvalho Chehab)
Date: Fri, 23 Mar 2018 07:56:51 -0400
Subject: [PATCH 05/30] media: rca: declare formats var as static
In-Reply-To: <39adb4e739050dcdb74c3465d261de8de5f224b7.1521806166.git.mchehab@s-opensource.com>
References: <39adb4e739050dcdb74c3465d261de8de5f224b7.1521806166.git.mchehab@s-opensource.com>
Message-ID: <43d1ed0811bb2780c49fa17e90a29b27078244a7.1521806166.git.mchehab@s-opensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As warned:
	drivers/media/platform/rockchip/rga/rga.c:210:16: warning: symbol 'formats' was not declared. Should it be static?

Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
---
 drivers/media/platform/rockchip/rga/rga.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/rockchip/rga/rga.c b/drivers/media/platform/rockchip/rga/rga.c
index 89296de9cf4a..d508a8ba6f89 100644
--- a/drivers/media/platform/rockchip/rga/rga.c
+++ b/drivers/media/platform/rockchip/rga/rga.c
@@ -207,7 +207,7 @@ static int rga_setup_ctrls(struct rga_ctx *ctx)
 	return 0;
 }
 
-struct rga_fmt formats[] = {
+static struct rga_fmt formats[] = {
 	{
 		.fourcc = V4L2_PIX_FMT_ARGB32,
 		.color_swap = RGA_COLOR_RB_SWAP,
-- 
2.14.3
