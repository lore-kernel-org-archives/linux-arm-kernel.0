From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon,  2 Dec 2013 11:19:05 +0900
Subject: [PATCH 03/28] ARM: shmobile: Select IRQC in case of the r8a7791 SoC
In-Reply-To: <cover.1385950394.git.horms+renesas@verge.net.au>
References: <cover.1385950394.git.horms+renesas@verge.net.au>
Message-ID: <af36e59512affacf837a98718fdb02f6dcbea2f6.1385950394.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

The r8a7791 contains IRQC hardware so make sure
the driver gets built by selecting RENESAS_IRQC.

Signed-off-by: Magnus Damm <damm@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-shmobile/Kconfig b/arch/arm/mach-shmobile/Kconfig
index a4a4b75..ff7c4ce 100644
--- a/arch/arm/mach-shmobile/Kconfig
+++ b/arch/arm/mach-shmobile/Kconfig
@@ -100,6 +100,7 @@ config ARCH_R8A7791
 	select ARM_GIC
 	select CPU_V7
 	select SH_CLK_CPG
+	select RENESAS_IRQC
 
 config ARCH_EMEV2
 	bool "Emma Mobile EV2"
-- 
1.8.4
