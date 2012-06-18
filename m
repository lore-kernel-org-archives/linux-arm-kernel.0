From: mkl@blackshift.org (Marc Kleine-Budde)
Date: Mon, 18 Jun 2012 02:07:34 +0200
Subject: RFC: [PATCH] ARM: Kirkwood: clk_register_gate_fn: add fn assignment
Message-ID: <1339978054-8464-1-git-send-email-mkl@blackshift.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In commit:
    98d9986 ARM: Kirkwood: Replace clock gating
the kirkwood clock gating has been reworked. A custom variant of
clock gating, that calls a custom function before gating the clock
off, has been introduced. However in clk_register_gate_fn() this
custom function "fn" is never assigned.

This patch adds the missing fn assignment.

Signed-off-by: Marc Kleine-Budde <mkl@blackshift.org>
---
Hi Andrew,

just stumbled over this one. I'm not sure if I missed something in the code
(it's time to go to bed here). Neither the original version or the patch
has been tested on hardware.

regards, Marc

 arch/arm/mach-kirkwood/common.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-kirkwood/common.c b/arch/arm/mach-kirkwood/common.c
index 25fb3fd..855e37b 100644
--- a/arch/arm/mach-kirkwood/common.c
+++ b/arch/arm/mach-kirkwood/common.c
@@ -159,6 +159,7 @@ static struct clk __init *clk_register_gate_fn(struct device *dev,
 	gate_fn->gate.flags = clk_gate_flags;
 	gate_fn->gate.lock = lock;
 	gate_fn->gate.hw.init = &init;
+	gate_fn->fn = fn;
 
 	/* ops is the gate ops, but with our disable function */
 	if (clk_gate_fn_ops.disable != clk_gate_fn_disable) {
-- 
1.7.4.1
