From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 17 Oct 2011 12:52:55 +0100
Subject: [PATCH 3/6] Documentation: add information for new sysfs soc bus
	functionality
In-Reply-To: <1318852378-14180-1-git-send-email-lee.jones@linaro.org>
References: <1318852378-14180-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1318852378-14180-4-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This change applies the required documentation for each new
attribute recenty added by the new System-On-Chip (SoC)
information export bus driver.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 Documentation/ABI/testing/sysfs-devices-soc |   48 +++++++++++++++++++++++++++
 1 files changed, 48 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-devices-soc

diff --git a/Documentation/ABI/testing/sysfs-devices-soc b/Documentation/ABI/testing/sysfs-devices-soc
new file mode 100644
index 0000000..549cbda
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-devices-soc
@@ -0,0 +1,48 @@
+What:		/sys/devices/socX
+Date:		October 2011
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
+Date:		October 2011
+contact:	Lee Jones <lee.jones@linaro.org>
+Description:
+		Read-only attribute common to all SoCs. Contains the SoC machine
+		name (e.g. Ux500).
+
+What:		/sys/devices/socX/family
+Date:		October 2011
+contact:	Lee Jones <lee.jones@linaro.org>
+Description:
+		Read-only attribute common to all SoCs. Contains SoC family name
+		(e.g. DB8500).
+
+What:		/sys/devices/socX/soc_id
+Date:		October 2011
+contact:	Lee Jones <lee.jones@linaro.org>
+Description:
+		Read-only attribute supported by most SoCs. In the case of
+		ST-Ericsson's chips this contains the SoC serial number.
+
+What:		/sys/devices/socX/revision
+Date:		October 2011
+contact:	Lee Jones <lee.jones@linaro.org>
+Description:
+		Read-only attribute supported by most SoCs. Contains the SoC's
+		manufacturing revision number.
+
+What:		/sys/devices/socX/process
+Date:		October 2011
+contact:	Lee Jones <lee.jones@linaro.org>
+Description:
+		Read-only attribute supported ST-Ericsson's silicon. Contains the
+		the process by which the silicon chip was manufactured.
-- 
1.7.5.4
