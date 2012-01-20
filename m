From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 20 Jan 2012 09:28:09 +0000
Subject: [PATCH 17/31] ARM: amba: make use of -1 IRQs warn
In-Reply-To: <20120120092207.GD1068@n2100.arm.linux.org.uk>
References: <20120120092207.GD1068@n2100.arm.linux.org.uk>
Message-ID: <E1RoAlV-0005FP-Tr@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Make the core warn about the use of -1 (NO_IRQ)

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/amba/bus.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/drivers/amba/bus.c b/drivers/amba/bus.c
index d15acbb..01c2cf4 100644
--- a/drivers/amba/bus.c
+++ b/drivers/amba/bus.c
@@ -511,6 +511,9 @@ int amba_device_add(struct amba_device *dev, struct resource *parent)
 	void __iomem *tmp;
 	int i, ret;
 
+	WARN_ON(dev->irq[0] == (unsigned int)-1);
+	WARN_ON(dev->irq[1] == (unsigned int)-1);
+
 	ret = request_resource(parent, &dev->res);
 	if (ret)
 		goto err_out;
-- 
1.7.4.4
