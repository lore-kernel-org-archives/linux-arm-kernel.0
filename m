From: pbrobinson@gmail.com (Peter Robinson)
Date: Sun, 11 Feb 2018 23:15:37 +0000
Subject: [PATCH] crypto: sunxi-ss: Add MODULE_ALIAS to sun4i-ss
Message-ID: <20180211231537.26487-1-pbrobinson@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The MODULE_ALIAS is required to enable the sun4i-ss driver to load
automatically when built at a module. Tested on a Cubietruck.

Fixes: 6298e948215f ("crypto: sunxi-ss - Add Allwinner Security System crypto accelerator")
Cc: <stable@vger.kernel.org>
Signed-off-by: Peter Robinson <pbrobinson@gmail.com>
---
 drivers/crypto/sunxi-ss/sun4i-ss-core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/crypto/sunxi-ss/sun4i-ss-core.c b/drivers/crypto/sunxi-ss/sun4i-ss-core.c
index 1547cbe13dc2..a81d89b3b7d8 100644
--- a/drivers/crypto/sunxi-ss/sun4i-ss-core.c
+++ b/drivers/crypto/sunxi-ss/sun4i-ss-core.c
@@ -451,6 +451,7 @@ static struct platform_driver sun4i_ss_driver = {
 
 module_platform_driver(sun4i_ss_driver);
 
+MODULE_ALIAS("platform:sun4i-ss");
 MODULE_DESCRIPTION("Allwinner Security System cryptographic accelerator");
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Corentin LABBE <clabbe.montjoie@gmail.com>");
-- 
2.14.3
