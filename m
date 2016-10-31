From: isubramanian@apm.com (Iyappan Subramanian)
Date: Mon, 31 Oct 2016 16:00:25 -0700
Subject: [PATCH net-next 0/2] drivers: net: xgene: Fix coalescing bugs
Message-ID: <1477954827-9951-1-git-send-email-isubramanian@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch set fixes the following,

     1. Since ethernet v1 hardware has a bug related to coalescing,
	disabling this feature
     2. Fixing ethernet v2 hardware, interrupt trigger region
	id to 2, to kickoff coalescing

Signed-off-by: Iyappan Subramanian <isubramanian@apm.com>

---

Iyappan Subramanian (2):
  drivers: net: xgene: fix: Disable coalescing on v1 hardware
  drivers: net: xgene: fix: Coalescing values for v2 hardware

 drivers/net/ethernet/apm/xgene/xgene_enet_hw.c    | 12 ------------
 drivers/net/ethernet/apm/xgene/xgene_enet_hw.h    |  2 ++
 drivers/net/ethernet/apm/xgene/xgene_enet_main.c  |  3 ++-
 drivers/net/ethernet/apm/xgene/xgene_enet_ring2.c | 12 +++++++-----
 4 files changed, 11 insertions(+), 18 deletions(-)

-- 
1.9.1
