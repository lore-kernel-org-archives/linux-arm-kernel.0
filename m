From: narmstrong@baylibre.com (Neil Armstrong)
Date: Wed,  9 Mar 2016 11:24:05 +0100
Subject: [PATCH v2 03/18] irqchip: versatile-fpga: add new arm,
 rps-irq compatible
In-Reply-To: <1457519060-6038-1-git-send-email-narmstrong@baylibre.com>
References: <1457005210-18485-1-git-send-email-narmstrong@baylibre.com>
 <1457519060-6038-1-git-send-email-narmstrong@baylibre.com>
Message-ID: <1457519060-6038-4-git-send-email-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Under the OX810SE, this exact same interface is used as "Reference Peripheral
Specification" Interrupt Controller, so add a new compatible string.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/irqchip/irq-versatile-fpga.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/irqchip/irq-versatile-fpga.c b/drivers/irqchip/irq-versatile-fpga.c
index 598ab3f..389b8e2 100644
--- a/drivers/irqchip/irq-versatile-fpga.c
+++ b/drivers/irqchip/irq-versatile-fpga.c
@@ -227,4 +227,5 @@ int __init fpga_irq_of_init(struct device_node *node,
 }
 IRQCHIP_DECLARE(arm_fpga, "arm,versatile-fpga-irq", fpga_irq_of_init);
 IRQCHIP_DECLARE(arm_fpga_sic, "arm,versatile-sic", fpga_irq_of_init);
+IRQCHIP_DECLARE(arm_rps, "arm,rps-irq", fpga_irq_of_init);
 #endif
-- 
1.9.1
