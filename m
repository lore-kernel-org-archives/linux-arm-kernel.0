From: michal.simek@xilinx.com (Michal Simek)
Date: Mon,  6 Jan 2014 15:36:37 +0100
Subject: [PATCH 1/7] ARM: zynq: Move clock_init from slcr to common
In-Reply-To: <cover.1389018985.git.michal.simek@xilinx.com>
References: <cover.1389018985.git.michal.simek@xilinx.com>
Message-ID: <3374e74f85daade60ec31b3aa05151bbe39759d0.1389018985.git.michal.simek@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Steffen Trumtrar <s.trumtrar@pengutronix.de>

Preparation step for next changes.

Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---
 arch/arm/mach-zynq/common.c | 2 ++
 arch/arm/mach-zynq/slcr.c   | 2 --
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-zynq/common.c b/arch/arm/mach-zynq/common.c
index 1db2a5ca..bf6717f 100644
--- a/arch/arm/mach-zynq/common.c
+++ b/arch/arm/mach-zynq/common.c
@@ -64,6 +64,8 @@ static void __init zynq_init_machine(void)
 static void __init zynq_timer_init(void)
 {
 	zynq_slcr_init();
+
+	zynq_clock_init(zynq_slcr_base);
 	clocksource_of_init();
 }

diff --git a/arch/arm/mach-zynq/slcr.c b/arch/arm/mach-zynq/slcr.c
index 1836d5a..59ad09f 100644
--- a/arch/arm/mach-zynq/slcr.c
+++ b/arch/arm/mach-zynq/slcr.c
@@ -106,8 +106,6 @@ int __init zynq_slcr_init(void)

 	pr_info("%s mapped to %p\n", np->name, zynq_slcr_base);

-	zynq_clock_init(zynq_slcr_base);
-
 	of_node_put(np);

 	return 0;
--
1.8.2.3

-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140106/8d79f305/attachment.sig>
