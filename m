From: Frank.Li@freescale.com (Frank.Li at freescale.com)
Date: Tue, 21 Apr 2015 22:53:24 +0800
Subject: [PATCH v5 08/11] ARM: imx: add gpt system timer support for imx7d
In-Reply-To: <1429628007-8892-1-git-send-email-Frank.Li@freescale.com>
References: <1429628007-8892-1-git-send-email-Frank.Li@freescale.com>
Message-ID: <1429628007-8892-9-git-send-email-Frank.Li@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Frank Li <Frank.Li@freescale.com>

Add GPT system timer support for i.MX7D, it has same hardware
as i.MX6DL.

Signed-off-by: Frank Li <Frank.Li@freescale.com>
Signed-off-by: Anson Huang <b20788@freescale.com>
---
 arch/arm/mach-imx/time.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-imx/time.c b/arch/arm/mach-imx/time.c
index 15d18e1..7c1d8a3 100644
--- a/arch/arm/mach-imx/time.c
+++ b/arch/arm/mach-imx/time.c
@@ -321,7 +321,7 @@ static void __init _mxc_timer_init(int irq,
 		tctl_val = V2_TCTL_FRR | V2_TCTL_WAITEN | MXC_TCTL_TEN;
 		if (clk_get_rate(clk_per) == V2_TIMER_RATE_OSC_DIV8) {
 			tctl_val |= V2_TCTL_CLK_OSC_DIV8;
-			if (cpu_is_imx6dl() || cpu_is_imx6sx()) {
+			if (cpu_is_imx6dl() || cpu_is_imx6sx() || cpu_is_imx7d()) {
 				/* 24 / 8 = 3 MHz */
 				__raw_writel(7 << V2_TPRER_PRE24M,
 					timer_base + MXC_TPRER);
@@ -383,3 +383,4 @@ CLOCKSOURCE_OF_DECLARE(mx53_timer, "fsl,imx53-gpt", mxc_timer_init_dt);
 CLOCKSOURCE_OF_DECLARE(mx6q_timer, "fsl,imx6q-gpt", mxc_timer_init_dt);
 CLOCKSOURCE_OF_DECLARE(mx6sl_timer, "fsl,imx6sl-gpt", mxc_timer_init_dt);
 CLOCKSOURCE_OF_DECLARE(mx6sx_timer, "fsl,imx6sx-gpt", mxc_timer_init_dt);
+CLOCKSOURCE_OF_DECLARE(mx7d_timer, "fsl,imx7d-gpt", mxc_timer_init_dt);
-- 
1.9.1
