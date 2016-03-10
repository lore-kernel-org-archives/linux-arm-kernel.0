From: yankejian@huawei.com (Kejian Yan)
Date: Thu, 10 Mar 2016 21:21:48 +0800
Subject: [PATCH v2 net-next 0/2] net: hns: get and set RSS indirection table
 by using ethtool
Message-ID: <1457616110-225844-1-git-send-email-yankejian@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When we use ethtool to retrieves or configure the receive flow hash 
indirection table, ethtool needs to call .get_rxnfc to get the ring number
so this patchset implements the .get_rxnfc and fixes the bug that we can
not get the tatal table each time.

---
change log:
PATCH v2:
 - This patch fixes the comments provided by Andy Shevchenko <Andy Shevchenko>

PATCH v1:
 - first submit

Kejian Yan (2):
  net: hns: fix return value of the function about rss
  net: hns: fixes a bug of RSS

 drivers/net/ethernet/hisilicon/hns/hns_ae_adapt.c |  8 ++++---
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_ppe.c |  2 +-
 drivers/net/ethernet/hisilicon/hns/hns_ethtool.c  | 26 +++++++++++++++++------
 3 files changed, 26 insertions(+), 10 deletions(-)

-- 
1.9.1
