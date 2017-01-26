From: andrew.smirnov@gmail.com (Andrey Smirnov)
Date: Thu, 26 Jan 2017 14:05:03 -0800
Subject: [PATCH 3/4] i.MX: GPC: Use IRQCHIP_DECLARE_DRIVER
In-Reply-To: <20170126220504.4796-1-andrew.smirnov@gmail.com>
References: <20170126220504.4796-1-andrew.smirnov@gmail.com>
Message-ID: <20170126220504.4796-3-andrew.smirnov@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use IRQCHIP_DECLARE_DRIVER instead of Use IRQCHIP_DECLARE to allow
'imx_gpc_driver' to be probed in addition to irqchip initialized by
imx_gpc_init().

Cc: yurovsky at gmail.com
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: linux-arm-kernel at lists.infradead.org
Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
---
 arch/arm/mach-imx/gpc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-imx/gpc.c b/arch/arm/mach-imx/gpc.c
index 1dc2a34..8f0d19b 100644
--- a/arch/arm/mach-imx/gpc.c
+++ b/arch/arm/mach-imx/gpc.c
@@ -279,7 +279,7 @@ static int __init imx_gpc_init(struct device_node *node,
 
 	return 0;
 }
-IRQCHIP_DECLARE(imx_gpc, "fsl,imx6q-gpc", imx_gpc_init);
+IRQCHIP_DECLARE_DRIVER(imx_gpc, "fsl,imx6q-gpc", imx_gpc_init);
 
 void __init imx_gpc_check_dt(void)
 {
-- 
2.9.3
