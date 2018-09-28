From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 28 Sep 2018 12:21:18 +0200
Subject: [PATCH 2/4] arm64: enable CMT/TMU support for Renesas SoC
In-Reply-To: <cover.1538127537.git.horms+renesas@verge.net.au>
References: <cover.1538127537.git.horms+renesas@verge.net.au>
Message-ID: <c1801ad028456267dde2111e470ac43f7882debf.1538127537.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Renesas R-Car gen3 SoCs have both CMT and TMU timers, so we have to enable
building them in Kconfig.platforms (as they don't normally have the prompts
in Kconfig).

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/Kconfig.platforms | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index b3c4c66f8519..8d149e12c82d 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -159,6 +159,8 @@ config ARCH_RENESAS
 	select PM_GENERIC_DOMAINS
 	select RENESAS_IRQC
 	select SOC_BUS
+	select SYS_SUPPORTS_SH_CMT
+	select SYS_SUPPORTS_SH_TMU
 	help
 	  This enables support for the ARMv8 based Renesas SoCs.
 
-- 
2.11.0
