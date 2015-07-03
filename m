From: jszhang@marvell.com (Jisheng Zhang)
Date: Fri, 3 Jul 2015 22:32:22 +0800
Subject: [PATCH 0/2] irqchip: dw-apb-ictl: add irq_set_affinity support
Message-ID: <1435933944-2131-1-git-send-email-jszhang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Marvell Berlin SoCs, the cpu's local timer is shutdown when the cpu
goes to a deep idle state, then the timer framework will be notified to
use a broadcast timer instead. The broadcast timer uses dw-apb-ictl as
interrupt chip, these patches try to add irq_set_affinity support so
that the going to deep idle state cpu can set the interrupt affinity of the
broadcast interrupt to avoid unnecessary wakeups and IPIs.


Jisheng Zhang (2):
  irqchip: dw-apb-ictl: add private data structure
  irqchip: dw-apb-ictl: add irq_set_affinity support

 drivers/irqchip/irq-dw-apb-ictl.c | 47 ++++++++++++++++++++++++++++++++++-----
 1 file changed, 42 insertions(+), 5 deletions(-)

-- 
2.1.4
