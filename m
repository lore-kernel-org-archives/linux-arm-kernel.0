From: balbi@ti.com (Felipe Balbi)
Date: Mon, 10 Oct 2011 15:26:18 +0300
Subject: [RFT/PATCH 6/7] arm: omap: smartreflex: fix IRQ handling bug
In-Reply-To: <1318249579-4089-1-git-send-email-balbi@ti.com>
References: <1318249579-4089-1-git-send-email-balbi@ti.com>
Message-ID: <1318249579-4089-6-git-send-email-balbi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

fix a bug which has been on this driver since
it was added by the original commit 984aa6db
which would never clear IRQSTATUS bits.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 arch/arm/mach-omap2/smartreflex.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/smartreflex.c b/arch/arm/mach-omap2/smartreflex.c
index 6e9eb46..7bdabfa 100644
--- a/arch/arm/mach-omap2/smartreflex.c
+++ b/arch/arm/mach-omap2/smartreflex.c
@@ -154,7 +154,7 @@ static irqreturn_t sr_interrupt(int irq, void *data)
 		break;
 	case SR_TYPE_V2:
 		/* Read the status bits */
-		sr_read_reg(sr_info, IRQSTATUS);
+		status = sr_read_reg(sr_info, IRQSTATUS);
 
 		/* Clear them by writing back */
 		sr_write_reg(sr_info, IRQSTATUS, status);
-- 
1.7.6.396.ge0613
