From: r.sricharan@ti.com (Sricharan R)
Date: Mon, 5 May 2014 19:48:42 +0530
Subject: [PATCH 0/5] irqchip/dra7: crossbar bug fixes
Message-ID: <1399299527-10955-1-git-send-email-r.sricharan@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These are fixes for the crossbar to handle two interrupts getting
mapped twice to same crossbar and to skip some interrupts being used
due to hardware bugs.

Nishanth Menon (5):
  irqchip: crossbar: dont use '0' to mark reserved interrupts
  irqchip: crossbar: check for premapped crossbar before allocating
  irqchip: crossbar: Skip some irqs from getting mapped to crossbar
  irqchip: crossbar: Initialise the crossbar with a safe value
  irqchip: crossbar: Change allocation logic by reversing search for
    free irqs

 drivers/irqchip/irq-crossbar.c |   82 ++++++++++++++++++++++++++++++++++++----
 1 file changed, 74 insertions(+), 8 deletions(-)

-- 
1.7.9.5
