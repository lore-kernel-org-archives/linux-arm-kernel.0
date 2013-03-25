From: fabio.estevam@freescale.com (Fabio Estevam)
Date: Mon, 25 Mar 2013 09:20:44 -0300
Subject: [PATCH 17/17] ARM: mach-imx: mach-imx6q: Fix sparse warnings
In-Reply-To: <1364214044-13950-1-git-send-email-fabio.estevam@freescale.com>
References: <1364214044-13950-1-git-send-email-fabio.estevam@freescale.com>
Message-ID: <1364214044-13950-17-git-send-email-fabio.estevam@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix the following sparse warnings:

arch/arm/mach-imx/mach-imx6q.c:60:6: warning: symbol 'imx6q_restart' was not declared. Should it be static?
arch/arm/mach-imx/mach-imx6q.c:223:24: warning: symbol 'imx6q_cpufreq_pdev' was not declared. Should it be static?

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/mach-imx/mach-imx6q.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-imx/mach-imx6q.c b/arch/arm/mach-imx/mach-imx6q.c
index 4fc4ffd..d49013b 100644
--- a/arch/arm/mach-imx/mach-imx6q.c
+++ b/arch/arm/mach-imx/mach-imx6q.c
@@ -57,7 +57,7 @@ static int imx6q_revision(void)
 	}
 }
 
-void imx6q_restart(char mode, const char *cmd)
+static void imx6q_restart(char mode, const char *cmd)
 {
 	struct device_node *np;
 	void __iomem *wdog_base;
@@ -220,7 +220,7 @@ put_node:
 	of_node_put(np);
 }
 
-struct platform_device imx6q_cpufreq_pdev = {
+static struct platform_device imx6q_cpufreq_pdev = {
 	.name = "imx6q-cpufreq",
 };
 
-- 
1.7.9.5
