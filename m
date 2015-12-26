From: eric@anholt.net (Eric Anholt)
Date: Sat, 26 Dec 2015 13:47:20 -0800
Subject: [PATCH 0/4] bcm2836 (Raspberry Pi 2) interrupt controller updates for
 4.5
Message-ID: <1451166444-11044-1-git-send-email-eric@anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

While the 2836 interrupt controller technically works, it would be
nice to merge these improvements to it, adding SMP booting, fixing the
timers, and fixing an apparently-spurious error message.

Patches 1, 2 were seen before in the full Pi 2 series I sent recently,
now with their summary prefixes fixed and a minor style cleanup to #2.
Patches 3, 4 are new, but trivial.

Andrea Merello (3):
  irqchip: bcm2836: Add SMP support for the 2836
  irqchip: bcm2836: tolerate IRQs while no flag is set in ISR
  irqchip: bcm2836: make code more readable

Eric Anholt (1):
  irqchip: bcm2836: Fix initialization of the LOCAL_IRQ_CNT*IRQ timers

 drivers/irqchip/irq-bcm2836.c | 55 +++++++++++++++++++++++++++++++++++++++----
 1 file changed, 51 insertions(+), 4 deletions(-)

-- 
2.6.2
