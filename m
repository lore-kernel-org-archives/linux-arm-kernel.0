From: isubramanian@apm.com (Iyappan Subramanian)
Date: Tue,  2 Feb 2016 23:55:12 -0800
Subject: [PATCH net-next 0/4] Add support for Classifier and RSS
Message-ID: <1454486116-23783-1-git-send-email-isubramanian@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series enables 

(i) Classifier engine that is used for parsing
through the packet and extracting a search string that is then used
to search a database to find associative data.

(ii) Receive Side Scaling (RSS) that does dynamic load
balancing of the CPUs by controlling the number of messages enqueued
per CPU though the help of Toeplitz Hash function of 4-tuple of
source TCP/UDP port, destination TCP/UDP port, source IPV4 address and
destination IPV4 address.

(iii) Multi queue, to make advantage of RSS

---
Iyappan Subramanian (4):
  drivers: net: xgene: Add support for Classifier engine
  drivers: net: xgene: Add support for RSS
  drivers: net: xgene: Add support for multiple queues
  dtb: xgene: Add irqs to support multi queue

 arch/arm64/boot/dts/apm/apm-shadowcat.dtsi       |   8 +-
 arch/arm64/boot/dts/apm/apm-storm.dtsi           |   8 +-
 drivers/net/ethernet/apm/xgene/Makefile          |   3 +-
 drivers/net/ethernet/apm/xgene/xgene_enet_cle.c  | 734 +++++++++++++++++++++++
 drivers/net/ethernet/apm/xgene/xgene_enet_cle.h  | 316 ++++++++++
 drivers/net/ethernet/apm/xgene/xgene_enet_hw.h   |   1 +
 drivers/net/ethernet/apm/xgene/xgene_enet_main.c | 481 +++++++++------
 drivers/net/ethernet/apm/xgene/xgene_enet_main.h |  34 +-
 8 files changed, 1385 insertions(+), 200 deletions(-)
 create mode 100644 drivers/net/ethernet/apm/xgene/xgene_enet_cle.c
 create mode 100644 drivers/net/ethernet/apm/xgene/xgene_enet_cle.h

-- 
1.9.1
