From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue, 30 Jul 2013 18:00:51 +0900
Subject: [PATCH 3/5] ARM: shmobile: select the fixed regulator driver on BockW
In-Reply-To: <cover.1375174556.git.horms+renesas@verge.net.au>
References: <cover.1375174556.git.horms+renesas@verge.net.au>
Message-ID: <c9996e51e45df0630cf5493fa0359a257a191eee.1375174556.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

34767f8dccc326026f97cd63f759dd36bd83502d
(ARM: mach-shmobile: select the fixed regulator driver on several boards)
decided to select fixed regulator driver on Kconfig.
BockW follows same style.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
[horms+renesas at verge.net.au: Change mach-shmobile to shmobile in changelog]
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-shmobile/Kconfig b/arch/arm/mach-shmobile/Kconfig
index dd80f21..f76fca6 100644
--- a/arch/arm/mach-shmobile/Kconfig
+++ b/arch/arm/mach-shmobile/Kconfig
@@ -124,6 +124,7 @@ config MACH_BOCKW
 	depends on ARCH_R8A7778
 	select ARCH_REQUIRE_GPIOLIB
 	select RENESAS_INTC_IRQPIN
+	select REGULATOR_FIXED_VOLTAGE if REGULATOR
 	select USE_OF
 
 config MACH_MARZEN
-- 
1.8.3.2
