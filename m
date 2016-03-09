From: isubramanian@apm.com (Iyappan Subramanian)
Date: Tue,  8 Mar 2016 21:49:35 -0800
Subject: [PATCH 0/2] drivers: net: xgene: fix irq related issues
Message-ID: <1457502577-2606-1-git-send-email-isubramanian@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch set addresses,

	1. Remove static association of prefetch buffers and derive that from Linux irq
	2. Remove irq sharing

Signed-off-by: Iyappan Subramanian <isubramanian@apm.com>
---

Iyappan Subramanian (2):
  drivers: net: xgene: fix: Derive prefetch number from irq
  drivers: net: xgene: fix: Remove IRQF_SHARED flag

 drivers/net/ethernet/apm/xgene/xgene_enet_hw.c    | 19 +++++++++++++++++++
 drivers/net/ethernet/apm/xgene/xgene_enet_hw.h    |  6 ++++++
 drivers/net/ethernet/apm/xgene/xgene_enet_main.c  | 13 +++++--------
 drivers/net/ethernet/apm/xgene/xgene_enet_main.h  |  7 +------
 drivers/net/ethernet/apm/xgene/xgene_enet_ring2.c | 12 ++++++++++++
 drivers/net/ethernet/apm/xgene/xgene_enet_ring2.h |  4 ++++
 6 files changed, 47 insertions(+), 14 deletions(-)

-- 
1.9.1
