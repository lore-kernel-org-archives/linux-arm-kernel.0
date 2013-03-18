From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 18 Mar 2013 20:53:17 +0900
Subject: [PATCH 5/9] ARM: shmobile: armadillo800eva: enable branch prediction
 on defconfig
In-Reply-To: <1363607601-20366-1-git-send-email-horms+renesas@verge.net.au>
References: <1363607601-20366-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1363607601-20366-6-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Because defconfig disabled ARM branch prediction
by CONFIG_CPU_BPREDICT_DISABLE,
Armadillo800eva's Bogomips and Loop were not good performance.
This patch enabled Arm branch prediction.
Special thanks to Ishiyama-san

Reported-by: Kiyoshi Ishiyama <kiyoshi.ishiyama.wg@renesas.com>
Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Acked-by: Kiyoshi Ishiyama <kiyoshi.ishiyama.wg@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/configs/armadillo800eva_defconfig |    1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/configs/armadillo800eva_defconfig b/arch/arm/configs/armadillo800eva_defconfig
index 0cc8014..c402294 100644
--- a/arch/arm/configs/armadillo800eva_defconfig
+++ b/arch/arm/configs/armadillo800eva_defconfig
@@ -20,7 +20,6 @@ CONFIG_ARCH_R8A7740=y
 CONFIG_MACH_ARMADILLO800EVA=y
 # CONFIG_SH_TIMER_TMU is not set
 CONFIG_ARM_THUMB=y
-CONFIG_CPU_BPREDICT_DISABLE=y
 CONFIG_CACHE_L2X0=y
 CONFIG_ARM_ERRATA_430973=y
 CONFIG_ARM_ERRATA_458693=y
-- 
1.7.10.4
