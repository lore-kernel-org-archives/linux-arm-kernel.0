From: joelf@ti.com (Joel Fernandes)
Date: Mon, 5 Aug 2013 11:14:51 -0500
Subject: [PATCH v3 06/12] ARM: edma: Add pr_debug in edma_link
In-Reply-To: <1375719297-12871-1-git-send-email-joelf@ti.com>
References: <1375719297-12871-1-git-send-email-joelf@ti.com>
Message-ID: <1375719297-12871-7-git-send-email-joelf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Useful for visualizing linking of PaRAM slots

Signed-off-by: Joel Fernandes <joelf@ti.com>
---
 arch/arm/common/edma.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/common/edma.c b/arch/arm/common/edma.c
index aa43c49..34d3fc9 100644
--- a/arch/arm/common/edma.c
+++ b/arch/arm/common/edma.c
@@ -1125,6 +1125,8 @@ void edma_link(unsigned from, unsigned to)
 	ctlr_to = EDMA_CTLR(to);
 	to = EDMA_CHAN_SLOT(to);
 
+	pr_debug("Setting up link %d -> %d\n", from, to);
+
 	if (from >= edma_cc[ctlr_from]->num_slots)
 		return;
 	if (to >= edma_cc[ctlr_to]->num_slots)
-- 
1.7.9.5
