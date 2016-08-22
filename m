From: weiyj.lk@gmail.com (Wei Yongjun)
Date: Mon, 22 Aug 2016 16:08:21 +0000
Subject: [PATCH -next] clk: meson: Fix invalid use of sizeof in
 gxbb_aoclkc_probe()
Message-ID: <1471882101-22347-1-git-send-email-weiyj.lk@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wei Yongjun <weiyongjun1@huawei.com>

sizeof() when applied to a pointer typed expression gives the
size of the pointer, not that of the pointed data.

Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/clk/meson/gxbb-aoclk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/meson/gxbb-aoclk.c b/drivers/clk/meson/gxbb-aoclk.c
index 61ef28a..b45c5fb 100644
--- a/drivers/clk/meson/gxbb-aoclk.c
+++ b/drivers/clk/meson/gxbb-aoclk.c
@@ -142,7 +142,7 @@ static int gxbb_aoclkc_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct gxbb_aoclk_reset_controller *rstc;
 
-	rstc = devm_kzalloc(dev, sizeof(rstc), GFP_KERNEL);
+	rstc = devm_kzalloc(dev, sizeof(*rstc), GFP_KERNEL);
 	if (!rstc)
 		return -ENOMEM;
 
