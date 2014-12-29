From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 29 Dec 2014 10:43:22 +0900
Subject: [PATCH 5/5] ARM: shmobile: Enable DA9063 watchdog in multiplatform
 defconfig
In-Reply-To: <cover.1419808942.git.horms+renesas@verge.net.au>
References: <cover.1419808942.git.horms+renesas@verge.net.au>
Message-ID: <db54d850b686c2ca81c10dd3582e98ee089a0e3a.1419808942.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

This allows to restart koelsch on watchdog timeout or manual system
restart request.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/configs/shmobile_defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/configs/shmobile_defconfig b/arch/arm/configs/shmobile_defconfig
index a9a1b0af..99e1226 100644
--- a/arch/arm/configs/shmobile_defconfig
+++ b/arch/arm/configs/shmobile_defconfig
@@ -108,6 +108,9 @@ CONFIG_GPIO_RCAR=y
 CONFIG_THERMAL=y
 CONFIG_CPU_THERMAL=y
 CONFIG_RCAR_THERMAL=y
+CONFIG_WATCHDOG=y
+CONFIG_DA9063_WATCHDOG=y
+CONFIG_MFD_DA9063=y
 CONFIG_REGULATOR=y
 CONFIG_REGULATOR_DA9210=y
 CONFIG_REGULATOR_GPIO=y
-- 
2.1.3
