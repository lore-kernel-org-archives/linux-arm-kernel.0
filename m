From: ben@decadent.org.uk (Ben Hutchings)
Date: Sat, 12 Mar 2011 03:27:22 +0000
Subject: [PATCH] arm: Fix .size directive for xscale_dma_a0_map_area
Message-ID: <1299900442.4146.79.camel@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

gas used to accept (and ignore?) .size directives which referred to
undefined symbols, as this does.  In binutils 2.21 these are treated
as fatal errors.

Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
I missed this one previously because my 5-minute script didn't recognise
the ENDPROC macro as generating a .size directive.

Ben.

 arch/arm/mm/proc-xscale.S |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mm/proc-xscale.S b/arch/arm/mm/proc-xscale.S
index 5a37c5e..ab00b59 100644
--- a/arch/arm/mm/proc-xscale.S
+++ b/arch/arm/mm/proc-xscale.S
@@ -395,7 +395,7 @@ ENTRY(xscale_dma_a0_map_area)
 	teq	r2, #DMA_TO_DEVICE
 	beq	xscale_dma_clean_range
 	b	xscale_dma_flush_range
-ENDPROC(xscsale_dma_a0_map_area)
+ENDPROC(xscale_dma_a0_map_area)
 
 /*
  *	dma_unmap_area(start, size, dir)
-- 
1.7.4.1
