From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri,  5 Nov 2010 10:46:11 +0100
Subject: [PATCH 7/7] ARM i.MX27 pm: return gracefully on different socs
In-Reply-To: <1288950371-1552-1-git-send-email-s.hauer@pengutronix.de>
References: <1288950371-1552-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1288950371-1552-8-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Code called from an initcall can be maybe called for
machines it's not intended for. So check for valid
machines and return gracefully if an incompatible machine
is found.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm/mach-imx/pm-imx27.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-imx/pm-imx27.c b/arch/arm/mach-imx/pm-imx27.c
index afc17ce..6bf81ce 100644
--- a/arch/arm/mach-imx/pm-imx27.c
+++ b/arch/arm/mach-imx/pm-imx27.c
@@ -39,6 +39,9 @@ static struct platform_suspend_ops mx27_suspend_ops = {
 
 static int __init mx27_pm_init(void)
 {
+	if (!cpu_is_mx27())
+		return 0;
+
 	suspend_set_ops(&mx27_suspend_ops);
 	return 0;
 }
-- 
1.7.2.3
