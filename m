From: fabioestevam@yahoo.com (Fabio Estevam)
Date: Fri, 22 Oct 2010 04:13:04 -0700 (PDT)
Subject: [PATCH] mx3: Enable PWM clock on mx31 and mx35
Message-ID: <396642.10697.qm@web51007.mail.re2.yahoo.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

mx3: Enable PWM clock on mx31 and mx35.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
Tested-by: Radoslav Kolev <radoslav.kolev@rnd.bg>

---
 arch/arm/mach-mx3/clock-imx31.c |    1 +
 arch/arm/mach-mx3/clock-imx35.c |    2 ++
 2 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mx3/clock-imx31.c b/arch/arm/mach-mx3/clock-imx31.c
index 109e98f..3926915 100644
--- a/arch/arm/mach-mx3/clock-imx31.c
+++ b/arch/arm/mach-mx3/clock-imx31.c
@@ -612,6 +612,7 @@ int __init mx31_clocks_init(unsigned long fref)
 	clk_enable(&iim_clk);
 
 	clk_enable(&serial_pll_clk);
+	clk_enable(&pwm_clk);
 
 	mx31_read_cpu_rev();
 
diff --git a/arch/arm/mach-mx3/clock-imx35.c b/arch/arm/mach-mx3/clock-imx35.c
index 61e4a31..9796440 100644
--- a/arch/arm/mach-mx3/clock-imx35.c
+++ b/arch/arm/mach-mx3/clock-imx35.c
@@ -536,6 +536,8 @@ int __init mx35_clocks_init()
 	__raw_writel(cgr3, CCM_BASE + CCM_CGR3);
 
 	clk_enable(&iim_clk);
+	clk_enable(&pwm_clk);
+
 	mx35_read_cpu_rev();
 
 #ifdef CONFIG_MXC_USE_EPIT
-- 
1.6.0.4



      
