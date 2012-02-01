From: lee.jones@linaro.org (Lee Jones)
Date: Wed,  1 Feb 2012 09:23:43 +0000
Subject: [PATCH 3/6] Documentation: add information for new sysfs soc bus
 functionality
In-Reply-To: <1328088226-29594-1-git-send-email-lee.jones@linaro.org>
References: <1328088226-29594-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1328088226-29594-4-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This change applies the required documentation for each new
attribute recenty added by the new System-On-Chip (SoC)
information export bus driver.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 Documentation/ABI/testing/sysfs-devices-soc |   58 +++++++++++++++++++++++++++
 1 files changed, 58 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-devices-soc

diff --git a/Documentation/ABI/testing/sysfs-devices-soc b/Documentation/ABI/testing/sysfs-devices-soc
new file mode 100644
index 0000000..6d9cc25
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-devices-soc
@@ -0,0 +1,58 @@
+What:		/sys/devices/socX
+Date:		January 2012
+contact:	Lee Jones <lee.jones@linaro.org>
+Description:
+		The /sys/devices/ directory contains a sub-directory for each
+		System-on-Chip (SoC) device on a running platform. Information
+		regarding each SoC can be obtained by reading sysfs files. This
+		functionality is only available if implemented by the platform.
+
+		The directory created for each SoC will also house information
+		about devices which are commonly contained in /sys/devices/platform.
+		It has been agreed that if an SoC device exists, its supported
+		devices would be better suited to appear as children of that SoC.
+
+What:		/sys/devices/socX/machine
+Date:		January 2012
+contact:	Lee Jones <lee.jones@linaro.org>
+Description:
+		Read-only attribute common to all SoCs. Contains the SoC machine
+		name (e.g. Ux500).
+
+What:		/sys/devices/socX/family
+Date:		January 2012
+contact:	Lee Jones <lee.jones@linaro.org>
+Description:
+		Read-only attribute common to all SoCs. Contains SoC family name
+		(e.g. DB8500).
+
+What:		/sys/devices/socX/soc_id
+Date:		January 2012
+contact:	Lee Jones <lee.jones@linaro.org>
+Description:
+		Read-only attribute supported by most SoCs. In the case of
+		ST-Ericsson's chips this contains the SoC serial number.
+
+What:		/sys/devices/socX/revision
+Date:		January 2012
+contact:	Lee Jones <lee.jones@linaro.org>
+Description:
+		Read-only attribute supported by most SoCs. Contains the SoC's
+		manufacturing revision number.
+
+What:		/sys/devices/socX/process
+Date:		January 2012
+contact:	Lee Jones <lee.jones@linaro.org>
+Description:
+		Read-only attribute supported ST-Ericsson's silicon. Contains the
+		the process by which the silicon chip was manufactured.
+
+What:		/sys/bus/soc
+Date:		January 2012
+contact:	Lee Jones <lee.jones@linaro.org>
+Description:
+		The /sys/bus/soc/ directory contains the usual sub-folders
+		expected under most buses. /sys/bus/soc/devices is of particular
+		interest, as it contains a symlink for each SoC device found on
+		the system. Each symlink points back into the aforementioned
+		/sys/devices/socX devices.
-- 
1.7.5.4
