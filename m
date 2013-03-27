From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Wed, 27 Mar 2013 18:30:37 +0100
Subject: [PATCH v2 03/11] ARM i.MX6q: export imx6q_revision
In-Reply-To: <1364405445-5271-1-git-send-email-p.zabel@pengutronix.de>
References: <1364405445-5271-1-git-send-email-p.zabel@pengutronix.de>
Message-ID: <1364405445-5271-4-git-send-email-p.zabel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

So it can be used in clk-imx6q.c for revision dependent clock tree setup.

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 arch/arm/mach-imx/common.h     | 1 +
 arch/arm/mach-imx/mach-imx6q.c | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-imx/common.h b/arch/arm/mach-imx/common.h
index 5a800bf..6c909d1 100644
--- a/arch/arm/mach-imx/common.h
+++ b/arch/arm/mach-imx/common.h
@@ -74,6 +74,7 @@ extern void mxc_set_cpu_type(unsigned int type);
 extern void mxc_restart(char, const char *);
 extern void mxc_arch_reset_init(void __iomem *);
 extern int mx53_revision(void);
+extern int imx6q_revision(void);
 extern int mx53_display_revision(void);
 extern void imx_set_aips(void __iomem *);
 extern int mxc_device_init(void);
diff --git a/arch/arm/mach-imx/mach-imx6q.c b/arch/arm/mach-imx/mach-imx6q.c
index 9ffd103..ca10acc 100644
--- a/arch/arm/mach-imx/mach-imx6q.c
+++ b/arch/arm/mach-imx/mach-imx6q.c
@@ -41,7 +41,7 @@
 
 #define IMX6Q_ANALOG_DIGPROG	0x260
 
-static int imx6q_revision(void)
+int imx6q_revision(void)
 {
 	struct device_node *np;
 	void __iomem *base;
-- 
1.8.2.rc2
