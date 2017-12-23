From: weiyongjun1@huawei.com (Wei Yongjun)
Date: Sat, 23 Dec 2017 01:57:04 +0000
Subject: [PATCH -next] media: atmel-isc: Make local symbol fmt_configs_list
 static
Message-ID: <1513994224-86350-1-git-send-email-weiyongjun1@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fixes the following sparse warning:

drivers/media/platform/atmel/atmel-isc.c:338:19: warning:
 symbol 'fmt_configs_list' was not declared. Should it be static?

Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/media/platform/atmel/atmel-isc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/atmel/atmel-isc.c b/drivers/media/platform/atmel/atmel-isc.c
index 0c26356..2dd72fc 100644
--- a/drivers/media/platform/atmel/atmel-isc.c
+++ b/drivers/media/platform/atmel/atmel-isc.c
@@ -335,7 +335,7 @@ struct isc_device {
 	},
 };
 
-struct fmt_config fmt_configs_list[] = {
+static struct fmt_config fmt_configs_list[] = {
 	{
 		.fourcc		= V4L2_PIX_FMT_SBGGR8,
 		.pfe_cfg0_bps	= ISC_PFE_CFG0_BPS_EIGHT,
