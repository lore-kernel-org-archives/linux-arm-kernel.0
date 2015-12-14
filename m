From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Mon, 14 Dec 2015 09:43:21 +0000
Subject: [PATCH 3/4] nvmem: sunxi: trivial: fix code style
In-Reply-To: <1450086024-18297-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1450086024-18297-1-git-send-email-srinivas.kandagatla@linaro.org>
Message-ID: <1450086201-18843-1-git-send-email-srinivas.kandagatla@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Caesar Wang <wxt@rock-chips.com>

this pacthset try to fix the code style for sunxi.

Signed-off-by: Caesar Wang <wxt@rock-chips.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/sunxi_sid.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/nvmem/sunxi_sid.c b/drivers/nvmem/sunxi_sid.c
index cfa3b85..bc88b40 100644
--- a/drivers/nvmem/sunxi_sid.c
+++ b/drivers/nvmem/sunxi_sid.c
@@ -13,10 +13,8 @@
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  * GNU General Public License for more details.
- *
  */
 
-
 #include <linux/device.h>
 #include <linux/io.h>
 #include <linux/module.h>
@@ -27,7 +25,6 @@
 #include <linux/slab.h>
 #include <linux/random.h>
 
-
 static struct nvmem_config econfig = {
 	.name = "sunxi-sid",
 	.read_only = true,
@@ -55,8 +52,8 @@ static u8 sunxi_sid_read_byte(const struct sunxi_sid *sid,
 }
 
 static int sunxi_sid_read(void *context,
-			    const void *reg, size_t reg_size,
-			    void *val, size_t val_size)
+			  const void *reg, size_t reg_size,
+			  void *val, size_t val_size)
 {
 	struct sunxi_sid *sid = context;
 	unsigned int offset = *(u32 *)reg;
@@ -130,7 +127,7 @@ static int sunxi_sid_probe(struct platform_device *pdev)
 	if (IS_ERR(nvmem))
 		return PTR_ERR(nvmem);
 
-	randomness = kzalloc(sizeof(u8) * size, GFP_KERNEL);
+	randomness = kzalloc(sizeof(u8) * (size), GFP_KERNEL);
 	if (!randomness) {
 		ret = -EINVAL;
 		goto err_unreg_nvmem;
-- 
1.9.1
