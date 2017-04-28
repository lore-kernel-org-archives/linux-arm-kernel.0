From: jon.mason@broadcom.com (Jon Mason)
Date: Fri, 28 Apr 2017 16:11:30 -0400
Subject: [PATCH v3 2/3] thermal: broadcom: ns-thermal: default on iProc SoCs
In-Reply-To: <1493410291-16679-1-git-send-email-jon.mason@broadcom.com>
References: <1493410291-16679-1-git-send-email-jon.mason@broadcom.com>
Message-ID: <1493410291-16679-3-git-send-email-jon.mason@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tweak the Kconfig description to mention support for NSP and make the
default on for iProc based platforms.

Signed-off-by: Jon Mason <jon.mason@broadcom.com>
---
 drivers/thermal/broadcom/Kconfig | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/thermal/broadcom/Kconfig b/drivers/thermal/broadcom/Kconfig
index f0dea8a..b6f4b85 100644
--- a/drivers/thermal/broadcom/Kconfig
+++ b/drivers/thermal/broadcom/Kconfig
@@ -1,8 +1,9 @@
 config BCM_NS_THERMAL
 	tristate "Northstar thermal driver"
 	depends on ARCH_BCM_IPROC || COMPILE_TEST
+	default y if ARCH_BCM_IPROC
 	help
-	  Northstar is a family of SoCs that includes e.g. BCM4708, BCM47081,
-	  BCM4709 and BCM47094. It contains DMU (Device Management Unit) block
-	  with a thermal sensor that allows checking CPU temperature. This
-	  driver provides support for it.
+	  Support for the Northstar and Northstar Plus family of SoCs (e.g.
+	  BCM4708, BCM4709, BCM5301x, BCM95852X, etc). It contains DMU (Device
+	  Management Unit) block with a thermal sensor that allows checking CPU
+	  temperature.
-- 
2.7.4
