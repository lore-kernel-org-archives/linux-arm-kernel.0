From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri,  9 Oct 2015 15:46:18 +0200
Subject: [PATCH] soc/rockchip: Restrict to ARCH_ROCKCHIP
Message-ID: <1444398378-24974-1-git-send-email-thierry.reding@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thierry Reding <treding@nvidia.com>

By definition this directory contains drivers that are specific to the
Rockchip architecture. All Kconfig options should therefore depend on
ARCH_ROCKCHIP to avoid exposing these symbols on other architectures.
For example, this options currently shows up as new when doing an
incremental build on PowerPC.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/soc/rockchip/Kconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/soc/rockchip/Kconfig b/drivers/soc/rockchip/Kconfig
index 6ee03994801c..d09b5ede7deb 100644
--- a/drivers/soc/rockchip/Kconfig
+++ b/drivers/soc/rockchip/Kconfig
@@ -1,3 +1,5 @@
+if ARCH_ROCKCHIP
+
 #
 # Rockchip Soc drivers
 #
@@ -12,3 +14,5 @@ config ROCKCHIP_PM_DOMAINS
           mode. The RK3288 PMU is dedicated for managing the power of the whole chip.
 
           If unsure, say N.
+
+endif
-- 
2.5.0
