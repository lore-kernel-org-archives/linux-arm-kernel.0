From: lee.jones@linaro.org (Lee Jones)
Date: Thu,  1 Sep 2011 13:27:20 +0100
Subject: [PATCH 2/5] Add documentation for new sysfs devices/soc functionality
In-Reply-To: <1314880043-22517-1-git-send-email-lee.jones@linaro.org>
References: <1314880043-22517-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1314880043-22517-2-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 Documentation/ABI/testing/sysfs-devices-soc |   20 ++++++++++++++++++++
 1 files changed, 20 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-devices-soc

diff --git a/Documentation/ABI/testing/sysfs-devices-soc b/Documentation/ABI/testing/sysfs-devices-soc
new file mode 100644
index 0000000..943a20f
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-devices-soc
@@ -0,0 +1,20 @@
+What:		/sys/devices/soc
+Date:		September 2011
+contact:	Lee Jones <lee.jones@linaro.org>
+Description:
+		The /sys/devices/soc directory contains a sub-directory for each
+		System-on-Chip (SoC) device on a running platform. Information
+		regarding each SoC can be obtained by reading sysfs files. This
+		functionality is only available if implemented by the platform.
+		This directory contains two kinds of attributes:
+			- Common attributes:
+				* machine: SoC machine name (e.g. Ux500).
+				* family: SoC family name (e.g. DB8500).
+			- SoC-specific attributes:
+				* SoC vendor declared
+                                * ST-Ericsson delcare the following
+                                  * soc_id: SoC serial number
+                                  * revision: SoC revision number
+				   * process: the way in which the chip was manufactured
+Users:
+		Any platform dependent user-space applications or profiling tools.
-- 
1.7.4.1
