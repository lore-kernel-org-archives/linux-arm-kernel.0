From: vilhelm.gray@gmail.com (William Breathitt Gray)
Date: Sun, 15 Jul 2018 16:46:14 -0400
Subject: [PATCH v8 06/11] counter: 104-quad-8: Documentation: Add Generic
 Counter sysfs documentation
In-Reply-To: <cover.1531685024.git.vilhelm.gray@gmail.com>
References: <cover.1531685024.git.vilhelm.gray@gmail.com>
Message-ID: <0fe263bc6bb36208eaa2fbcd83fa04fd22fb597e.1531685025.git.vilhelm.gray@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds standard documentation for the Generic Counter interface
userspace sysfs attributes of the 104-QUAD-8 driver.

Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
 .../ABI/testing/sysfs-bus-counter-104-quad-8  | 36 +++++++++++++++++++
 MAINTAINERS                                   |  1 +
 2 files changed, 37 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-counter-104-quad-8

diff --git a/Documentation/ABI/testing/sysfs-bus-counter-104-quad-8 b/Documentation/ABI/testing/sysfs-bus-counter-104-quad-8
new file mode 100644
index 000000000000..2d9fa57af101
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-bus-counter-104-quad-8
@@ -0,0 +1,36 @@
+What:		/sys/bus/counter/devices/counterX/signalY/index_polarity
+KernelVersion:	4.19
+Contact:	linux-iio at vger.kernel.org
+Description:
+		Active level of index input Signal Y; irrelevant in
+		non-synchronous load mode.
+
+What:		/sys/bus/counter/devices/counterX/signalY/index_polarity_available
+What:		/sys/bus/counter/devices/counterX/signalY/synchronous_mode_available
+KernelVersion:	4.19
+Contact:	linux-iio at vger.kernel.org
+Description:
+		Discrete set of available values for the respective Signal Y
+		configuration are listed in this file.
+
+What:		/sys/bus/counter/devices/counterX/signalY/synchronous_mode
+KernelVersion:	4.19
+Contact:	linux-iio at vger.kernel.org
+Description:
+		Configure the counter associated with Signal Y for
+		non-synchronous or synchronous load mode. Synchronous load mode
+		cannot be selected in non-quadrature (Pulse-Direction) clock
+		mode.
+
+		non-synchronous:
+			A logic low level is the active level at this index
+			input. The index function (as enabled via preset_enable)
+			is performed directly on the active level of the index
+			input.
+
+		synchronous:
+			Intended for interfacing with encoder Index output in
+			quadrature clock mode. The active level is configured
+			via index_polarity. The index function (as enabled via
+			preset_enable) is performed synchronously with the
+			quadrature clock on the active level of the index input.
diff --git a/MAINTAINERS b/MAINTAINERS
index f41c45246e2b..865c47a3feae 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -270,6 +270,7 @@ ACCES 104-QUAD-8 DRIVER
 M:	William Breathitt Gray <vilhelm.gray@gmail.com>
 L:	linux-iio at vger.kernel.org
 S:	Maintained
+F:	Documentation/ABI/testing/sysfs-bus-counter-104-quad-8
 F:	Documentation/ABI/testing/sysfs-bus-iio-counter-104-quad-8
 F:	drivers/counter/104-quad-8.c
 
-- 
2.18.0
