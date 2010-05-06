From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Thu,  6 May 2010 16:24:23 -0700
Subject: [PATCH 32/34] Davinci: serial - conditional reset via pwremu
In-Reply-To: <1273188265-12782-1-git-send-email-khilman@deeprootsystems.com>
References: <1273188265-12782-1-git-send-email-khilman@deeprootsystems.com>
Message-ID: <1273188265-12782-33-git-send-email-khilman@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Cyril Chemparathy <cyril@ti.com>

With this patch, AR7 type uart ports are not reset via pwremu registers.  This
allows davinci_serial_init() reuse on tnetv107x soc.

Signed-off-by: Cyril Chemparathy <cyril@ti.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-davinci/serial.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-davinci/serial.c b/arch/arm/mach-davinci/serial.c
index 81af42c..1875740 100644
--- a/arch/arm/mach-davinci/serial.c
+++ b/arch/arm/mach-davinci/serial.c
@@ -107,7 +107,7 @@ int __init davinci_serial_init(struct davinci_uart_config *info)
 				pr_err("uart regs ioremap failed\n");
 		}
 
-		if (p->membase)
+		if (p->membase && p->type != PORT_AR7)
 			davinci_serial_reset(p);
 	}
 
-- 
1.7.0.2
