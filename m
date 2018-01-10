From: weiyongjun1@huawei.com (Wei Yongjun)
Date: Wed, 10 Jan 2018 14:19:40 +0000
Subject: [PATCH -next] meson-mx-socinfo: Make local function
 meson_mx_socinfo_init() static
Message-ID: <1515593980-78559-1-git-send-email-weiyongjun1@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fixes the following sparse warnings:

drivers/soc/amlogic/meson-mx-socinfo.c:107:12: warning:
 symbol 'meson_mx_socinfo_init' was not declared. Should it be static?

Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/soc/amlogic/meson-mx-socinfo.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/amlogic/meson-mx-socinfo.c b/drivers/soc/amlogic/meson-mx-socinfo.c
index 7bfff5f..78f0f1a 100644
--- a/drivers/soc/amlogic/meson-mx-socinfo.c
+++ b/drivers/soc/amlogic/meson-mx-socinfo.c
@@ -104,7 +104,7 @@ static const char *meson_mx_socinfo_soc_id(unsigned int major_ver,
 	{ /* sentinel */ }
 };
 
-int __init meson_mx_socinfo_init(void)
+static int __init meson_mx_socinfo_init(void)
 {
 	struct soc_device_attribute *soc_dev_attr;
 	struct soc_device *soc_dev;
