From: isubramanian@apm.com (Iyappan Subramanian)
Date: Thu,  6 Oct 2016 14:35:56 -0700
Subject: [PATCH net-next 0/2] drivers: net: xgene: fix: Use GPIO to get link
 status
Message-ID: <1475789758-5196-1-git-send-email-isubramanian@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since the link value reported by the link status register is not
reliable if no SPF module inserted, this patchset fixes the issue by
using GPIO to determine the link status when no module inserted.

Signed-off-by: Iyappan Subramanian <isubramanian@apm.com>
Signed-off-by: Quan Nguyen <qnguyen@apm.com>
---

Iyappan Subramanian (2):
  drivers: net: xgene: fix: Use GPIO to get link status
  arm64: xgene: defconfig: Enable Standby GPIO

 arch/arm64/configs/defconfig                      |  1 +
 drivers/net/ethernet/apm/xgene/xgene_enet_main.c  |  6 +++++-
 drivers/net/ethernet/apm/xgene/xgene_enet_main.h  |  1 +
 drivers/net/ethernet/apm/xgene/xgene_enet_xgmac.c | 19 +++++++++++++++++--
 4 files changed, 24 insertions(+), 3 deletions(-)

-- 
1.9.1
