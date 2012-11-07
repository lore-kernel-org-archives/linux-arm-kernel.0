From: a.kesavan@samsung.com (Abhilash Kesavan)
Date: Wed, 07 Nov 2012 16:37:39 +0530
Subject: [PATCH] dt: Document: Add optional dw_mmc pm bindings
Message-ID: <1352286460-13925-1-git-send-email-a.kesavan@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add documentation for pm capabilties such as MMC_PM_KEEP_POWER
and MMC_PM_WAKE_SDIO_IRQ.

Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>
---
 .../devicetree/bindings/mmc/synposis-dw-mshc.txt   |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/Documentation/devicetree/bindings/mmc/synposis-dw-mshc.txt b/Documentation/devicetree/bindings/mmc/synposis-dw-mshc.txt
index 06cd32d..fa6806d 100644
--- a/Documentation/devicetree/bindings/mmc/synposis-dw-mshc.txt
+++ b/Documentation/devicetree/bindings/mmc/synposis-dw-mshc.txt
@@ -47,6 +47,11 @@ Optional properties:
 
 * broken-cd: as documented in mmc core bindings.
 
+* keep-power-in-suspend: Preserves card power during a suspend/resume cycle.
+
+* enable-sdio-wakeup: Enables wake up of host system on SDIO IRQ assertion.
+
+ Samsung Exynos5250 specific properties:
 Aliases:
 
 - All the MSHC controller nodes should be represented in the aliases node using
@@ -69,6 +74,8 @@ board specific portions as listed below.
 		num-slots = <1>;
 		supports-highspeed;
 		broken-cd;
+		keep-power-in-suspend;
+		enable-sdio-wakeup;
 		fifo-depth = <0x80>;
 		card-detect-delay = <200>;
 
-- 
1.6.6.1
