From: isubramanian@apm.com (Iyappan Subramanian)
Date: Wed, 26 Aug 2015 11:48:04 -0700
Subject: [PATCH v2 0/2] drivers: net: xgene: Add TSO support
Message-ID: <1440614886-23566-1-git-send-email-isubramanian@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adding TSO support for 10GbE

iperf Tx data rate without TSO: 3.42 Gbps
                      with TSO: 9.41 Gbps

v2: Address review comments from v1
    - skb_linearize() if headers doesn't fit in 3 hardware buffers

v1:
* Initial version

Signed-off-by: Iyappan Subramanian <isubramanian@apm.com>
---

Iyappan Subramanian (2):
  drivers: net: xgene: Preparatory patch for TSO support
  drivers: net: xgene: Adding support for TSO

 drivers/net/ethernet/apm/xgene/xgene_enet_hw.h    |  16 +-
 drivers/net/ethernet/apm/xgene/xgene_enet_main.c  | 274 +++++++++++++++++++---
 drivers/net/ethernet/apm/xgene/xgene_enet_main.h  |  12 +
 drivers/net/ethernet/apm/xgene/xgene_enet_xgmac.c |   8 +-
 drivers/net/ethernet/apm/xgene/xgene_enet_xgmac.h |   2 +
 5 files changed, 283 insertions(+), 29 deletions(-)

-- 
1.9.1
