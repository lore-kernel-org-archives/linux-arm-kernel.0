From: yankejian@huawei.com (Kejian Yan)
Date: Thu, 10 Mar 2016 10:16:27 +0800
Subject: [patch net 0/2] net: hns: get and set RSS indirection table by using
 ethtool
Message-ID: <1457576189-22924-1-git-send-email-yankejian@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When we use ethtool to retrieves or configure the receive flow hash 
indirection table, ethtool needs to call .get_rxnfc to get the ring number
so this patchset implements the .get_rxnfc and fixes the bug that we can
not get the tatal table each time.

Kejian Yan (2):
  net: hns: fix return value of the function about rss
  net: hns: fixes a bug of RSS

 drivers/net/ethernet/hisilicon/hns/hns_ae_adapt.c |  8 ++++---
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_ppe.c |  2 +-
 drivers/net/ethernet/hisilicon/hns/hns_ethtool.c  | 28 +++++++++++++++++++----
 3 files changed, 30 insertions(+), 8 deletions(-)

-- 
1.9.1
