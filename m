From: dan.carpenter@oracle.com (Dan Carpenter)
Date: Wed, 13 May 2015 14:32:39 +0300
Subject: [patch] ARM: pxa: pxa_cplds: signedness bug in probe
Message-ID: <20150513113239.GA31617@mwanda>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

"base_irq" needs to be signed for the error handling to work.  Also we
can remove the initialization because we re-assign it later.

Fixes: aa8d6b73ea33 ('ARM: pxa: pxa_cplds: add lubbock and mainstone IO')
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/arch/arm/mach-pxa/pxa_cplds_irqs.c b/arch/arm/mach-pxa/pxa_cplds_irqs.c
index f1aeb54..2385052 100644
--- a/arch/arm/mach-pxa/pxa_cplds_irqs.c
+++ b/arch/arm/mach-pxa/pxa_cplds_irqs.c
@@ -107,7 +107,7 @@ static int cplds_probe(struct platform_device *pdev)
 	struct resource *res;
 	struct cplds *fpga;
 	int ret;
-	unsigned int base_irq = 0;
+	int base_irq;
 	unsigned long irqflags = 0;
 
 	fpga = devm_kzalloc(&pdev->dev, sizeof(*fpga), GFP_KERNEL);
