From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 20 Nov 2012 23:01:05 +0100
Subject: [PATCH 14/16] arm: vic: don't expose vic_of_init() anymore
In-Reply-To: <1353448867-15008-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1353448867-15008-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1353448867-15008-15-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

All users of vic_of_init() have been converted to the irqchip
infrastructure, and all future users should go through this new
infrastructure. Therefore, we no longer expose the vic_of_init()
function through the vic.h header.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/include/asm/hardware/vic.h |    1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/include/asm/hardware/vic.h b/arch/arm/include/asm/hardware/vic.h
index e14af1a..3b2e881 100644
--- a/arch/arm/include/asm/hardware/vic.h
+++ b/arch/arm/include/asm/hardware/vic.h
@@ -50,7 +50,6 @@ struct pt_regs;
 void __vic_init(void __iomem *base, unsigned int irq_start, u32 vic_sources,
 		u32 resume_sources, struct device_node *node);
 void vic_init(void __iomem *base, unsigned int irq_start, u32 vic_sources, u32 resume_sources);
-int vic_of_init(struct device_node *node, struct device_node *parent);
 void vic_handle_irq(struct pt_regs *regs);
 
 #endif /* __ASSEMBLY__ */
-- 
1.7.9.5
