From: akinobu.mita@gmail.com (Akinobu Mita)
Date: Wed, 11 Apr 2012 20:36:53 +0900
Subject: [PATCH v2] arm: davinci: use for_each_set_bit_from
Message-ID: <1334144213-25870-1-git-send-email-akinobu.mita@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use for_each_set_bit_from to iterate over all the set bit in a memory
region.

Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
Acked-by: Sekhar Nori <nsekhar@ti.com>
Cc: Sekhar Nori <nsekhar@ti.com>
Cc: Christian Riesch <christian.riesch@omicron.at>
Cc: Kevin Hilman <khilman@ti.com>
Cc: davinci-linux-open-source at linux.davincidsp.com
Cc: Russell King <linux@arm.linux.org.uk>
Cc: linux-arm-kernel at lists.infradead.org
---
v2: remove uncorrect semicolon at the end of the line found by Christian Riesch

 arch/arm/mach-davinci/dma.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-davinci/dma.c b/arch/arm/mach-davinci/dma.c
index fd33919..95ce019 100644
--- a/arch/arm/mach-davinci/dma.c
+++ b/arch/arm/mach-davinci/dma.c
@@ -557,9 +557,9 @@ static int reserve_contiguous_slots(int ctlr, unsigned int id,
 	if (i == edma_cc[ctlr]->num_slots)
 		stop_slot = i;
 
-	for (j = start_slot; j < stop_slot; j++)
-		if (test_bit(j, tmp_inuse))
-			clear_bit(j, edma_cc[ctlr]->edma_inuse);
+	j = start_slot;
+	for_each_set_bit_from(j, tmp_inuse, stop_slot)
+		clear_bit(j, edma_cc[ctlr]->edma_inuse);
 
 	if (count)
 		return -EBUSY;
-- 
1.7.4.4
