From: mpa@pengutronix.de (Markus Pargmann)
Date: Mon, 25 Feb 2013 17:30:19 +0100
Subject: [PATCH 4/4] ARM: imx: cpufreq doesn't work as module
In-Reply-To: <1361809819-24383-1-git-send-email-mpa@pengutronix.de>
References: <1361809819-24383-1-git-send-email-mpa@pengutronix.de>
Message-ID: <1361809819-24383-5-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The function get_cpu_op is always set with initialization of the
specific architecture. A module is always loaded after that init code,
so it does not work.

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 arch/arm/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 67874b8..d8ad11d 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -2128,7 +2128,7 @@ if ARCH_HAS_CPUFREQ
 source "drivers/cpufreq/Kconfig"
 
 config CPU_FREQ_IMX
-	tristate "CPUfreq driver for i.MX CPUs"
+	bool "CPUfreq driver for i.MX CPUs"
 	depends on ARCH_MXC && CPU_FREQ
 	select CPU_FREQ_TABLE
 	help
-- 
1.8.1.2
