From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Tue,  2 Jul 2013 13:03:43 +0200
Subject: [PATCH v4 7/7] ARM: plat-orion: add reg offset to DT irq driver stub
In-Reply-To: <1372763023-12374-1-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1372763023-12374-1-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <1372763023-12374-8-git-send-email-sebastian.hesselbarth@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With irqchip driver for Orion SoCs, reg layout of orion-intc has changed.
This updates irq driver stub implemented before to the new reg layout by
adding an offset to the base address passed by DT node. As orion5x still
uses this stub, it cannot be removed yet.

Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
--- 
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Gregory CLEMENT <gregory.clement@free-electrons.com>
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-kernel at vger.kernel.org
---
 arch/arm/plat-orion/irq.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-orion/irq.c b/arch/arm/plat-orion/irq.c
index 8db0b98..c492e1b 100644
--- a/arch/arm/plat-orion/irq.c
+++ b/arch/arm/plat-orion/irq.c
@@ -47,7 +47,7 @@ static int __init orion_add_irq_domain(struct device_node *np,
 	do {
 		base = of_iomap(np, i);
 		if (base) {
-			orion_irq_init(i * 32, base);
+			orion_irq_init(i * 32, base + 0x04);
 			i++;
 		}
 	} while (base);
-- 
1.7.2.5
