From: weiyongjun1@huawei.com (Wei Yongjun)
Date: Wed, 10 Jan 2018 14:19:48 +0000
Subject: [PATCH -next] meson-gx-socinfo: make local function
 meson_gx_socinfo_init static
Message-ID: <1515593988-78626-1-git-send-email-weiyongjun1@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fixes the following sparse warnings:

drivers/soc/amlogic/meson-gx-socinfo.c:100:12: warning:
 symbol 'meson_gx_socinfo_init' was not declared. Should it be static?

Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/soc/amlogic/meson-gx-socinfo.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/amlogic/meson-gx-socinfo.c b/drivers/soc/amlogic/meson-gx-socinfo.c
index f2d8c3c..ea091f1 100644
--- a/drivers/soc/amlogic/meson-gx-socinfo.c
+++ b/drivers/soc/amlogic/meson-gx-socinfo.c
@@ -97,7 +97,7 @@ static const char *socinfo_to_soc_id(u32 socinfo)
 	return "Unknown";
 }
 
-int __init meson_gx_socinfo_init(void)
+static int __init meson_gx_socinfo_init(void)
 {
 	struct soc_device_attribute *soc_dev_attr;
 	struct soc_device *soc_dev;
