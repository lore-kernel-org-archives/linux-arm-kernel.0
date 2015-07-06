From: jszhang@marvell.com (Jisheng Zhang)
Date: Mon, 6 Jul 2015 12:15:39 +0800
Subject: [PATCH v3 0/2] irqchip: dw-apb-ictl: add irq_set_affinity support
Message-ID: <1436156141-3674-1-git-send-email-jszhang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Marvell Berlin SoCs, the cpu's local timer is shutdown when the cpu
goes to a deep idle state, then the timer framework will be notified to
use a broadcast timer instead. In our case, the broadcast timer uses
dw-apb-ictl as the interrupt chip. These patches try to add irq_set_affinity
support so that the going to deep idle state cpu can set the interrupt
affinity of the broadcast interrupt to avoid unnecessary wakeups and IPIs.


Changes since v2:
 - Add a DT option to indicate whether we want to set the irq affinity.
Changes since v1:
 - Add a simple test and its result into the second patch's commit msg.

Jisheng Zhang (2):
  irqchip: dw-apb-ictl: add private data structure
  irqchip: dw-apb-ictl: add irq_set_affinity support

 .../interrupt-controller/snps,dw-apb-ictl.txt      |  5 +++
 drivers/irqchip/irq-dw-apb-ictl.c                  | 51 +++++++++++++++++++---
 2 files changed, 51 insertions(+), 5 deletions(-)

-- 
2.1.4
