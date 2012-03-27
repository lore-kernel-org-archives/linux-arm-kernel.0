From: khilman@ti.com (Kevin Hilman)
Date: Mon, 26 Mar 2012 17:19:28 -0700
Subject: [PATCH] cpufreq: OMAP: fix build errors: depends on ARCH_OMAP2PLUS
Message-ID: <1332807568-638-1-git-send-email-khilman@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The OMAP driver needs a 'depends on ARCH_OMAP2PLUS' since it only
builds for OMAP2+ platforms.

This 'depends on' was in the original patch from Russell King, but was
erroneously removed by me when making this option user-selectable in
commit b09db45c (cpufreq: OMAP driver depends CPUfreq tables.)  This
patch remedies that.

Apologies to Russell King for breaking his originally working patch.

Also, thanks to Grazvydas Ignotas for reporting the same problem.

Cc: Russell King <rmk+kernel@arm.linux.org.uk>
Cc: Grazvydas Ignotas <notasas@gmail.com>
Signed-off-by: Kevin Hilman <khilman@ti.com>
---
Dave, this applies on top of your current fixes branch, and fixes a 
problem introduced there by me.  Please merge for v3.4-rc.  Thanks.

 drivers/cpufreq/Kconfig.arm |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
index 82f1aa9..555a57b 100644
--- a/drivers/cpufreq/Kconfig.arm
+++ b/drivers/cpufreq/Kconfig.arm
@@ -4,6 +4,7 @@
 
 config ARM_OMAP2PLUS_CPUFREQ
 	bool "TI OMAP2+"
+	depends on ARCH_OMAP2PLUS
 	default ARCH_OMAP2PLUS
 	select CPU_FREQ_TABLE
 
-- 
1.7.9.2
