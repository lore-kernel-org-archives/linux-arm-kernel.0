From: fabio.estevam@freescale.com (Fabio Estevam)
Date: Fri, 26 Aug 2011 16:22:00 -0300
Subject: [PATCH 5/5] ARM: mx53: Allow suspend/resume on mx53
In-Reply-To: <1314386521-29351-3-git-send-email-fabio.estevam@freescale.com>
References: <1314386521-29351-1-git-send-email-fabio.estevam@freescale.com>
	<1314386521-29351-2-git-send-email-fabio.estevam@freescale.com>
	<1314386521-29351-3-git-send-email-fabio.estevam@freescale.com>
Message-ID: <1314386521-29351-4-git-send-email-fabio.estevam@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
This is still work in progress, as I can still not fully get access to the console
after a suspend/resume cycle on my mx53loco.

Freezing user space processes ... (elapsed 0.01 seconds) done.                  
Freezing remaining freezable tasks ... (elapsed 0.01 seconds) done.             
PM: suspend of devices complete after 0.635 msecs                               
PM: suspend devices took 0.000 seconds 

(Press the button here:)
                                         
PM: late suspend of devices complete after 0.418 msecs

and console does not come back after this message.

 arch/arm/mach-mx5/pm-imx5.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-mx5/pm-imx5.c b/arch/arm/mach-mx5/pm-imx5.c
index e4529af..a9bac88 100644
--- a/arch/arm/mach-mx5/pm-imx5.c
+++ b/arch/arm/mach-mx5/pm-imx5.c
@@ -63,7 +63,7 @@ static int __init mx5_pm_init(void)
 		gpc_dvfs_clk = clk_get(NULL, "gpc_dvfs");
 
 	if (!IS_ERR(gpc_dvfs_clk)) {
-		if (cpu_is_mx51())
+		if (cpu_is_mx51() || cpu_is_mx53())
 			suspend_set_ops(&mx5_suspend_ops);
 	} else
 		return -EPERM;
-- 
1.6.0.4
