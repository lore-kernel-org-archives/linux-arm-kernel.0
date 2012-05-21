From: rob.lee@linaro.org (Robert Lee)
Date: Mon, 21 May 2012 17:50:25 -0500
Subject: [PATCH v5 2/7] ARM: imx: Add comments to tzic_enable_waker()
In-Reply-To: <1337640630-29176-1-git-send-email-rob.lee@linaro.org>
References: <1337640630-29176-1-git-send-email-rob.lee@linaro.org>
Message-ID: <1337640630-29176-3-git-send-email-rob.lee@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add additional comments to the tzic_enable_wake() funciton to
clarify its intended usage.

Signed-off-by: Robert Lee <rob.lee@linaro.org>
---
 arch/arm/plat-mxc/tzic.c |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/plat-mxc/tzic.c b/arch/arm/plat-mxc/tzic.c
index 98308ec..a45dbea 100644
--- a/arch/arm/plat-mxc/tzic.c
+++ b/arch/arm/plat-mxc/tzic.c
@@ -190,6 +190,10 @@ void __init tzic_init_irq(void __iomem *irqbase)
  * tzic_enable_wake() - enable wakeup interrupt
  *
  * @return			0 if successful; non-zero otherwise
+ *
+ * This function provides an interrupt synchronization point that is required
+ * by tzic enabled platforms before entering imx specific low power modes (ie,
+ * those low power modes beyond the WAIT_CLOCKED basic ARM WFI only mode).
  */
 int tzic_enable_wake(void)
 {
-- 
1.7.10
