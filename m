From: robh@kernel.org (Rob Herring)
Date: Mon,  1 Oct 2018 16:43:49 -0500
Subject: [PATCH] input: xilinx_ps2: Convert to using %pOFn instead of
 device_node.name
In-Reply-To: <20181001214351.13230-1-robh@kernel.org>
References: <20181001214351.13230-1-robh@kernel.org>
Message-ID: <20181001214351.13230-2-robh@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In preparation to remove the node name pointer from struct device_node,
convert printf users to use the %pOFn format specifier.

Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Michal Simek <michal.simek@xilinx.com>
Cc: linux-input at vger.kernel.org
Cc: linux-arm-kernel at lists.infradead.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/input/serio/xilinx_ps2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/serio/xilinx_ps2.c b/drivers/input/serio/xilinx_ps2.c
index 07de1b49293c..6615c02a08fd 100644
--- a/drivers/input/serio/xilinx_ps2.c
+++ b/drivers/input/serio/xilinx_ps2.c
@@ -245,7 +245,7 @@ static int xps2_of_probe(struct platform_device *ofdev)
 	unsigned int irq;
 	int error;
 
-	dev_info(dev, "Device Tree Probing \'%s\'\n", dev->of_node->name);
+	dev_info(dev, "Device Tree Probing \'%pOFn\'\n", dev->of_node);
 
 	/* Get iospace for the device */
 	error = of_address_to_resource(dev->of_node, 0, &r_mem);
-- 
2.17.1
