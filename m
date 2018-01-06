From: f.fainelli@gmail.com (Florian Fainelli)
Date: Sat,  6 Jan 2018 10:49:17 -0800
Subject: [PATCH 2/2] ARM: Invalidate BTB on fatal signal for Brahma-B15
In-Reply-To: <20180106120907.26701-3-marc.zyngier@arm.com>
References: <20180106120907.26701-3-marc.zyngier@arm.com>
Message-ID: <20180106184917.12007-1-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/arm/mm/fault.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mm/fault.c b/arch/arm/mm/fault.c
index 1a1c2638f528..fd840a7483aa 100644
--- a/arch/arm/mm/fault.c
+++ b/arch/arm/mm/fault.c
@@ -188,6 +188,7 @@ __do_user_fault(struct task_struct *tsk, unsigned long addr,
 	case ARM_CPU_PART_CORTEX_A12:
 	case ARM_CPU_PART_CORTEX_A15:
 	case ARM_CPU_PART_CORTEX_A17:
+	case ARM_CPU_PART_BRAHMA_B15:
 		write_sysreg(0, BPIALL);
 		break;
 	}
-- 
2.14.1
