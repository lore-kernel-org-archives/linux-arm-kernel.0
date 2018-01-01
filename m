From: clabbe.montjoie@gmail.com (Corentin Labbe)
Date: Mon,  1 Jan 2018 20:22:08 +0100
Subject: [PATCH] ARM: sunxi_defconfig: Enable SUNXI_CCU
Message-ID: <20180101192208.11738-1-clabbe.montjoie@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

While looking for missing symbol by diffing sunxi_defconfig and my
.config, I just found that no CLK symbol are present in sunxi_defconfig.

This patch add the missing CONFIG_SUNXI_CCU in sunxi_defconfig.
All other symbol will be automatically selected via their default value.

Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
---
 arch/arm/configs/sunxi_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/sunxi_defconfig b/arch/arm/configs/sunxi_defconfig
index 5caaf971fb50..5ed920e75842 100644
--- a/arch/arm/configs/sunxi_defconfig
+++ b/arch/arm/configs/sunxi_defconfig
@@ -16,6 +16,7 @@ CONFIG_CPU_FREQ=y
 CONFIG_CPUFREQ_DT=y
 CONFIG_VFP=y
 CONFIG_NEON=y
+CONFIG_SUNXI_CCU=y
 CONFIG_NET=y
 CONFIG_PACKET=y
 CONFIG_UNIX=y
-- 
2.13.6
