From: richard.zhao@linaro.org (Richard Zhao)
Date: Mon, 12 Dec 2011 11:42:28 +0800
Subject: [PATCH 3/7] ARM: imx: fix cpufreq build errors
In-Reply-To: <1323661352-10291-1-git-send-email-richard.zhao@linaro.org>
References: <1323661352-10291-1-git-send-email-richard.zhao@linaro.org>
Message-ID: <1323661352-10291-4-git-send-email-richard.zhao@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Richard Zhao <richard.zhao@freescale.com>

  CC      arch/arm/plat-mxc/cpufreq.o
arch/arm/plat-mxc/cpufreq.c:203: error: expected declaration specifiers or '...' before string constant
arch/arm/plat-mxc/cpufreq.c:203: warning: data definition has no type or storage class
arch/arm/plat-mxc/cpufreq.c:203: warning: type defaults to 'int' in declaration of 'MODULE_AUTHOR'
arch/arm/plat-mxc/cpufreq.c:203: warning: function declaration isn't a prototype
arch/arm/plat-mxc/cpufreq.c:204: error: expected declaration specifiers or '...' before string constant
arch/arm/plat-mxc/cpufreq.c:204: warning: data definition has no type or storage class
arch/arm/plat-mxc/cpufreq.c:204: warning: type defaults to 'int' in declaration of 'MODULE_DESCRIPTION'
arch/arm/plat-mxc/cpufreq.c:204: warning: function declaration isn't a prototype
arch/arm/plat-mxc/cpufreq.c:205: error: expected declaration specifiers or '...' before string constant
arch/arm/plat-mxc/cpufreq.c:205: warning: data definition has no type or storage class
arch/arm/plat-mxc/cpufreq.c:205: warning: type defaults to 'int' in declaration of 'MODULE_LICENSE'
arch/arm/plat-mxc/cpufreq.c:205: warning: function declaration isn't a prototype
make[1]: *** [arch/arm/plat-mxc/cpufreq.o] Error 1
make: *** [arch/arm/plat-mxc] Error 2

Signed-off-by: Richard Zhao <richard.zhao@freescale.com>
Signed-off-by: Richard Zhao <richard.zhao@linaro.org>
---
 arch/arm/plat-mxc/cpufreq.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-mxc/cpufreq.c b/arch/arm/plat-mxc/cpufreq.c
index 122b21a..85d037f 100644
--- a/arch/arm/plat-mxc/cpufreq.c
+++ b/arch/arm/plat-mxc/cpufreq.c
@@ -17,6 +17,7 @@
  * the CPU clock speed on the fly.
  */
 
+#include <linux/module.h>
 #include <linux/cpufreq.h>
 #include <linux/clk.h>
 #include <linux/err.h>
-- 
1.7.5.4
