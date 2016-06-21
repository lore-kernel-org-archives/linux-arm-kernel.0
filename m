From: Yisen.Zhuang@huawei.com (Yisen Zhuang)
Date: Tue, 21 Jun 2016 11:56:38 +0800
Subject: [PATCH net-next 18/19] net: hns: change the default coalesce usecs
In-Reply-To: <1466481399-70080-1-git-send-email-Yisen.Zhuang@huawei.com>
References: <1466481399-70080-1-git-send-email-Yisen.Zhuang@huawei.com>
Message-ID: <1466481399-70080-19-git-send-email-Yisen.Zhuang@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Daode Huang <huangdaode@hisilicon.com>

The default coalesce timeout is 3us, which is will cause CPU
usage is too high. This patch change it to 50us in order to reduce
CPU usage and the value makes sure network latency also meets requirement.

Signed-off-by: Daode Huang <huangdaode@hisilicon.com>
Signed-off-by: Yisen Zhuang <Yisen.Zhuang@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_rcb.c | 2 +-
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_rcb.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_rcb.c b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_rcb.c
index 3ce2409..ef11077 100644
--- a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_rcb.c
+++ b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_rcb.c
@@ -540,7 +540,7 @@ int hns_rcb_set_coalesce_usecs(
 	}
 	if (timeout > HNS_RCB_MAX_COALESCED_USECS) {
 		dev_err(rcb_common->dsaf_dev->dev,
-			"error: not support coalesce %dus!\n", timeout);
+			"error: coalesce_usecs setting supports 0~1023us\n");
 		return -EINVAL;
 	}
 	hns_rcb_set_port_timeout(rcb_common, port_idx, timeout);
diff --git a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_rcb.h b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_rcb.h
index bd54dac..99b4e1b 100644
--- a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_rcb.h
+++ b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_rcb.h
@@ -40,7 +40,7 @@ struct rcb_common_cb;
 #define HNS_RCB_DEF_COALESCED_FRAMES		50
 #define HNS_RCB_CLK_FREQ_MHZ			350
 #define HNS_RCB_MAX_COALESCED_USECS		0x3ff
-#define HNS_RCB_DEF_COALESCED_USECS		3
+#define HNS_RCB_DEF_COALESCED_USECS		50
 
 #define HNS_RCB_COMMON_ENDIAN			1
 
-- 
1.9.1
