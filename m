From: richard.zhao@freescale.com (Richard Zhao)
Date: Thu, 9 Dec 2010 22:08:34 +0800
Subject: [PATCH 4/6] arm: mx5: always use __mxc_cpu_type to check cpu type
In-Reply-To: <1291903716-31388-1-git-send-email-richard.zhao@freescale.com>
References: <1291903716-31388-1-git-send-email-richard.zhao@freescale.com>
Message-ID: <1291903716-31388-4-git-send-email-richard.zhao@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Every SoC in mach-mx5 calls mxc_set_cpu_type to set cpu type.

Signed-off-by: Richard Zhao <richard.zhao@freescale.com>
---
 arch/arm/plat-mxc/include/mach/mxc.h |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/arch/arm/plat-mxc/include/mach/mxc.h b/arch/arm/plat-mxc/include/mach/mxc.h
index 4abbdd1..04afa33 100644
--- a/arch/arm/plat-mxc/include/mach/mxc.h
+++ b/arch/arm/plat-mxc/include/mach/mxc.h
@@ -129,10 +129,8 @@ extern unsigned int __mxc_cpu_type;
 #ifdef CONFIG_ARCH_MX5
 # ifdef mxc_cpu_type
 #  undef mxc_cpu_type
-#  define mxc_cpu_type __mxc_cpu_type
-# else
-#  define mxc_cpu_type MXC_CPU_MX51
 # endif
+# define mxc_cpu_type __mxc_cpu_type
 # define cpu_is_mx51()		(mxc_cpu_type == MXC_CPU_MX51)
 # define cpu_is_mx53()		(mxc_cpu_type == MXC_CPU_MX53)
 #else
-- 
1.6.3.3
