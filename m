From: jszhang@marvell.com (Jisheng Zhang)
Date: Sat, 4 Jul 2015 13:19:28 +0800
Subject: [PATCH v2 0/2] irqchip: dw-apb-ictl: add irq_set_affinity support
Message-ID: <1435987170-3962-1-git-send-email-jszhang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Marvell Berlin SoCs, the cpu's local timer is shutdown when the cpu
goes to a deep idle state, then the timer framework will be notified to
use a broadcast timer instead. The broadcast timer uses dw-apb-ictl as
interrupt chip, these patches try to add irq_set_affinity support so
that the going to deep idle state cpu can set the interrupt affinity of the
broadcast interrupt to avoid unnecessary wakeups and IPIs.

Changes since v1:
 - Add a simple test and its result into the second patch's commit msg.

Jisheng Zhang (2):
  irqchip: dw-apb-ictl: add private data structure
  irqchip: dw-apb-ictl: add irq_set_affinity support

 drivers/irqchip/irq-dw-apb-ictl.c | 47 ++++++++++++++++++++++++++++++++++-----
 1 file changed, 42 insertions(+), 5 deletions(-)

-- 
2.1.4
