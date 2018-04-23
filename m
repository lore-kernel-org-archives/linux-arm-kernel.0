From: jbrunet@baylibre.com (Jerome Brunet)
Date: Mon, 23 Apr 2018 14:41:48 +0200
Subject: [PATCH v2 2/3] nvmem: meson-efuse: simplify read callback
In-Reply-To: <20180423124149.3077-1-jbrunet@baylibre.com>
References: <20180423124149.3077-1-jbrunet@baylibre.com>
Message-ID: <20180423124149.3077-3-jbrunet@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Most of the code and variables in the read callback is not necessary.
Keep only what is required.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/nvmem/meson-efuse.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/nvmem/meson-efuse.c b/drivers/nvmem/meson-efuse.c
index 2df9b0094f45..4623249dfd87 100644
--- a/drivers/nvmem/meson-efuse.c
+++ b/drivers/nvmem/meson-efuse.c
@@ -24,15 +24,8 @@
 static int meson_efuse_read(void *context, unsigned int offset,
 			    void *val, size_t bytes)
 {
-	u8 *buf = val;
-	int ret;
-
-	ret = meson_sm_call_read(buf, bytes, SM_EFUSE_READ, offset,
-				 bytes, 0, 0, 0);
-	if (ret < 0)
-		return ret;
-
-	return 0;
+	return meson_sm_call_read((u8 *)val, bytes, SM_EFUSE_READ, offset,
+				  bytes, 0, 0, 0);
 }
 
 static const struct of_device_id meson_efuse_match[] = {
-- 
2.14.3
