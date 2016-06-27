From: Yisen.Zhuang@huawei.com (Yisen Zhuang)
Date: Mon, 27 Jun 2016 17:54:10 +0800
Subject: [PATCH net-next 4/9] net: hns: delete redundant parens
In-Reply-To: <1467021255-95900-1-git-send-email-Yisen.Zhuang@huawei.com>
References: <1467021255-95900-1-git-send-email-Yisen.Zhuang@huawei.com>
Message-ID: <1467021255-95900-5-git-send-email-Yisen.Zhuang@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Daode Huang <huangdaode@hisilicon.com>

According to the previous review comments from Andy, this patch
deletes the redundant parens in the patch.

Signed-off-by: Daode Huang <huangdaode@hisilicon.com>
---
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_main.c b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_main.c
index b9d01ea..e36ee22 100644
--- a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_main.c
+++ b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_main.c
@@ -2565,7 +2565,7 @@ static char *hns_dsaf_get_node_stats_strings(char *data, int node,
 	buff += ETH_GSTRING_LEN;
 	snprintf(buff, ETH_GSTRING_LEN, "innod%d_stp_drop_pkts", node);
 	buff += ETH_GSTRING_LEN;
-	if ((node < DSAF_SERVICE_NW_NUM) && (!is_ver1)) {
+	if (node < DSAF_SERVICE_NW_NUM && !is_ver1) {
 		for (i = 0; i < DSAF_PRIO_NR; i++) {
 			snprintf(buff, ETH_GSTRING_LEN,
 				 "inod%d_pfc_prio%d_pkts", node, i);
@@ -2604,7 +2604,7 @@ static u64 *hns_dsaf_get_node_stats(struct dsaf_device *ddev, u64 *data,
 	p[10] = hw_stats->local_addr_false;
 	p[11] = hw_stats->vlan_drop;
 	p[12] = hw_stats->stp_drop;
-	if ((node_num < DSAF_SERVICE_NW_NUM) && (!is_ver1)) {
+	if (node_num < DSAF_SERVICE_NW_NUM && !is_ver1) {
 		for (i = 0; i < DSAF_PRIO_NR; i++) {
 			p[13 + i] = hw_stats->rx_pfc[i];
 			p[13 + i + DSAF_PRIO_NR] = hw_stats->tx_pfc[i];
-- 
1.9.1
