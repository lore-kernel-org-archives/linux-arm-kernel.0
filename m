From: festevam@gmail.com (Fabio Estevam)
Date: Fri, 24 May 2013 16:55:42 -0300
Subject: [PATCH 2/2] ARM: imx: clk: No need to initialize phandle struct
In-Reply-To: <1369425342-20153-1-git-send-email-festevam@gmail.com>
References: <1369425342-20153-1-git-send-email-festevam@gmail.com>
Message-ID: <1369425342-20153-2-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@freescale.com>

commit 84344b43c (ARM: i.MX5: Allow DT clock providers) introduce the following
sparse warning:

arch/arm/mach-imx/clk.c:12:43: warning: Using plain integer as NULL pointer

There is no need to initialize phandle, so remove it.

Cc: Martin Fuzzey <mfuzzey@parkeon.com>
Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/mach-imx/clk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-imx/clk.c b/arch/arm/mach-imx/clk.c
index 53e8788..55bc80a 100644
--- a/arch/arm/mach-imx/clk.c
+++ b/arch/arm/mach-imx/clk.c
@@ -9,7 +9,7 @@ DEFINE_SPINLOCK(imx_ccm_lock);
 
 static struct clk * __init imx_obtain_fixed_clock_from_dt(const char *name)
 {
-	struct of_phandle_args phandle = {0};
+	struct of_phandle_args phandle;
 	struct clk *clk = ERR_PTR(-ENODEV);
 	char *path;
 
-- 
1.8.1.2
