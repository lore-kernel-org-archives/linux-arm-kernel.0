From: agross@codeaurora.org (Andy Gross)
Date: Mon, 21 Apr 2014 00:30:41 -0500
Subject: [PATCH 1/4] soc: Placeholder files for drivers/soc
In-Reply-To: <1398058244-14099-1-git-send-email-agross@codeaurora.org>
References: <1398058244-14099-1-git-send-email-agross@codeaurora.org>
Message-ID: <1398058244-14099-2-git-send-email-agross@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add placeholder Kconfig and linkage for driver/soc.

The first patch set that implemented this was authored by Santosh Shilimkar:
https://lkml.org/lkml/2014/2/28/567

Signed-off-by: Andy Gross <agross@codeaurora.org>
---
 drivers/Kconfig     |    2 ++
 drivers/Makefile    |    4 ++++
 drivers/soc/Kconfig |    4 ++++
 3 files changed, 10 insertions(+)
 create mode 100644 drivers/soc/Kconfig

diff --git a/drivers/Kconfig b/drivers/Kconfig
index b3138fb..37f955f 100644
--- a/drivers/Kconfig
+++ b/drivers/Kconfig
@@ -130,6 +130,8 @@ source "drivers/staging/Kconfig"
 
 source "drivers/platform/Kconfig"
 
+source "drivers/soc/Kconfig"
+
 source "drivers/clk/Kconfig"
 
 source "drivers/hwspinlock/Kconfig"
diff --git a/drivers/Makefile b/drivers/Makefile
index 8e3b8b0..ba77e7b 100644
--- a/drivers/Makefile
+++ b/drivers/Makefile
@@ -132,6 +132,10 @@ obj-$(CONFIG_VHOST_RING)	+= vhost/
 obj-$(CONFIG_VLYNQ)		+= vlynq/
 obj-$(CONFIG_STAGING)		+= staging/
 obj-y				+= platform/
+
+# soc specific drivers
+obj-y				+= soc/
+
 #common clk code
 obj-y				+= clk/
 
diff --git a/drivers/soc/Kconfig b/drivers/soc/Kconfig
new file mode 100644
index 0000000..58bd962
--- /dev/null
+++ b/drivers/soc/Kconfig
@@ -0,0 +1,4 @@
+menu "SOC specific Drivers"
+
+endmenu
+`
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
