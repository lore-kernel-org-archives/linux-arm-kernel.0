From: arvind.yadav.cs@gmail.com (Arvind Yadav)
Date: Tue, 13 Jun 2017 10:22:32 +0530
Subject: [PATCH] reset: zx2967: constify zx2967_reset_ops.
Message-ID: <c082e132c282634a7185ea99c50c8d671965534a.1497329415.git.arvind.yadav.cs@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

File size before:
   text	   data	    bss	    dec	    hex	filename
    794	    232	      0	   1026	    402	drivers/reset/reset-zx2967.o

File size After adding 'const':
   text	   data	    bss	    dec	    hex	filename
    842	    184	      0	   1026	    402	drivers/reset/reset-zx2967.o

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/reset/reset-zx2967.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/reset/reset-zx2967.c b/drivers/reset/reset-zx2967.c
index 4dabb9e..4f319f7 100644
--- a/drivers/reset/reset-zx2967.c
+++ b/drivers/reset/reset-zx2967.c
@@ -55,7 +55,7 @@ static int zx2967_reset_deassert(struct reset_controller_dev *rcdev,
 	return zx2967_reset_act(rcdev, id, false);
 }
 
-static struct reset_control_ops zx2967_reset_ops = {
+static const struct reset_control_ops zx2967_reset_ops = {
 	.assert		= zx2967_reset_assert,
 	.deassert	= zx2967_reset_deassert,
 };
-- 
1.9.1
