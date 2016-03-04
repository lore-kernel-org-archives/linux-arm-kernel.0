From: lisheng011@huawei.com (Lisheng)
Date: Fri, 4 Mar 2016 12:38:13 +0800
Subject: [PATCH net 0/3] net: hns: fixed the setting overtime bug
Message-ID: <1457066296-66202-1-git-send-email-lisheng011@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In V2 chip,we can set overtime reg is for each port,
that is differents from for all port in V1.
This patch will modify some functions: set/get the reg.

Lisheng (3):
  net: hns: fixed the setting overtime bug
  net: hns: modified dump overtime regs
  net: hns: fixed set-coalesce-usecs return void bug

 drivers/net/ethernet/hisilicon/hns/hnae.h         |   2 +-
 drivers/net/ethernet/hisilicon/hns/hns_ae_adapt.c |  64 +++----
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_rcb.c | 196 ++++++++++------------
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_rcb.h |  23 +--
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_reg.h |   1 +
 drivers/net/ethernet/hisilicon/hns/hns_ethtool.c  |   6 +-
 6 files changed, 133 insertions(+), 159 deletions(-)

-- 
1.9.1
