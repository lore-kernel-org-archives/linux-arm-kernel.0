From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 18 May 2018 13:16:32 +0200
Subject: [PATCH 6/6] ARM: multi_v7_defconfig: Enable RENESAS_WDT
In-Reply-To: <cover.1526548577.git.horms+renesas@verge.net.au>
References: <cover.1526548577.git.horms+renesas@verge.net.au>
Message-ID: <eedd7902366b17f95f4fe687c54dcfa186a53158.1526548577.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

R-Car Gen2 and RZ/G1 platforms come with a watchdog IP, therefore enable
its driver by default. It is enabled as a module to avoid increasing
the kernel image size.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/configs/multi_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index c6042475bece..374a40945b0f 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -498,6 +498,7 @@ CONFIG_TEGRA_WATCHDOG=m
 CONFIG_MESON_WATCHDOG=y
 CONFIG_DW_WATCHDOG=y
 CONFIG_DIGICOLOR_WATCHDOG=y
+CONFIG_RENESAS_WDT=m
 CONFIG_BCM2835_WDT=y
 CONFIG_BCM47XX_WDT=y
 CONFIG_BCM7038_WDT=m
-- 
2.11.0
