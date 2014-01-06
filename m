From: michal.simek@xilinx.com (Michal Simek)
Date: Mon,  6 Jan 2014 15:36:41 +0100
Subject: [PATCH 5/7] ARM: zynq: Make zynq_slcr_base static
In-Reply-To: <cover.1389018985.git.michal.simek@xilinx.com>
References: <cover.1389018985.git.michal.simek@xilinx.com>
Message-ID: <a03727927a64135bb9bc61ddfe07b7f7f028de72.1389018985.git.michal.simek@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Steffen Trumtrar <s.trumtrar@pengutronix.de>

The pointer doesn't need to be passed around any more.
Make it static.

Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---
 arch/arm/mach-zynq/common.h | 1 -
 arch/arm/mach-zynq/slcr.c   | 2 +-
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm/mach-zynq/common.h b/arch/arm/mach-zynq/common.h
index 1548b85..b097844 100644
--- a/arch/arm/mach-zynq/common.h
+++ b/arch/arm/mach-zynq/common.h
@@ -34,7 +34,6 @@ extern int zynq_cpun_start(u32 address, int cpu);
 extern struct smp_operations zynq_smp_ops __initdata;
 #endif

-extern void __iomem *zynq_slcr_base;
 extern void __iomem *zynq_scu_base;

 /* Hotplug */
diff --git a/arch/arm/mach-zynq/slcr.c b/arch/arm/mach-zynq/slcr.c
index 2891dcf..a679dff 100644
--- a/arch/arm/mach-zynq/slcr.c
+++ b/arch/arm/mach-zynq/slcr.c
@@ -31,7 +31,7 @@
 #define SLCR_A9_CPU_CLKSTOP		0x10
 #define SLCR_A9_CPU_RST			0x1

-void __iomem *zynq_slcr_base;
+static void __iomem *zynq_slcr_base;
 static struct regmap *zynq_slcr_regmap;

 /**
--
1.8.2.3

-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140106/efdfb039/attachment.sig>
