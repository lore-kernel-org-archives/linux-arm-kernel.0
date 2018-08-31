From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Fri, 31 Aug 2018 22:54:42 +0300
Subject: [PATCH] arm64: enable CMT/TMU support for Renesas SoC
Message-ID: <ebd7d1f7-d99b-f0a1-f05e-d822254b2e86@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Renesas R-Car gen3 SoCs have both CMT and TMU timers, so we have to enable
building them in Kconfig.platforms (as they don't normally have the prompts
in Kconfig).

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
The patch is against the ARM64 repo's 'for-next/core' branch.

 arch/arm64/Kconfig.platforms |    2 ++
 1 file changed, 2 insertions(+)

Index: linux/arch/arm64/Kconfig.platforms
===================================================================
--- linux.orig/arch/arm64/Kconfig.platforms
+++ linux/arch/arm64/Kconfig.platforms
@@ -175,6 +175,8 @@ config ARCH_RENESAS
 	select PM_GENERIC_DOMAINS
 	select RENESAS_IRQC
 	select SOC_BUS
+	select SYS_SUPPORTS_SH_CMT
+	select SYS_SUPPORTS_SH_TMU
 	help
 	  This enables support for the ARMv8 based Renesas SoCs.
 
