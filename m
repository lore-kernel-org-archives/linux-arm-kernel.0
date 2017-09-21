From: oleksandrs@mellanox.com (Oleksandr Shamray)
Date: Thu, 21 Sep 2017 12:25:32 +0300
Subject: [patch v9 4/4] Documentation: jtag: Add ABI documentation
In-Reply-To: <1505985932-27568-1-git-send-email-oleksandrs@mellanox.com>
References: <1505985932-27568-1-git-send-email-oleksandrs@mellanox.com>
Message-ID: <1505985932-27568-5-git-send-email-oleksandrs@mellanox.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Added document that describe the ABI for JTAG class drivrer

Signed-off-by: Oleksandr Shamray <oleksandrs@mellanox.com>
---
v8->v9
v7->v8
v6->v7
Comments pointed by Pavel Machek <pavel@ucw.cz>
- Added jtag-cdev documentation to Documentation/ABI/testing folder
---
 Documentation/ABI/testing/jatg-cdev |   27 +++++++++++++++++++++++++++
 MAINTAINERS                         |    1 +
 2 files changed, 28 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/ABI/testing/jatg-cdev

diff --git a/Documentation/ABI/testing/jatg-cdev b/Documentation/ABI/testing/jatg-cdev
new file mode 100644
index 0000000..14a3610
--- /dev/null
+++ b/Documentation/ABI/testing/jatg-cdev
@@ -0,0 +1,27 @@
+What:		/dev/jtag[0-9]+
+Date:		September 2017
+KernelVersion:	4.14
+Contact:	oleksandrs at mellanox.com
+Description:
+		The character device files /dev/jtag* are the interface
+		between JTAG master interfase and userspace.
+
+		The ioctl(2)-based ABI is defined and documented in
+		[include/uapi]<linux/jtag.h>.
+
+		The following file operations are supported:
+
+		open(2)
+		The argument flag currently support only one access
+		mode O_RDWR.
+
+		ioctl(2)
+		Initiate various actions.
+		See the inline documentation in [include/uapi]<linux/jtag.h>
+		for descriptions of all ioctls.
+
+		close(2)
+		Stops and free up the I/O contexts that was associated
+		with the file descriptor.
+
+Users:		TBD
\ No newline at end of file
diff --git a/MAINTAINERS b/MAINTAINERS
index bfdfa94..dfcf49c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7300,6 +7300,7 @@ F:	include/linux/jtag.h
 F:	include/uapi/linux/jtag.h
 F:	drivers/jtag/
 F:	Documentation/devicetree/bindings/jtag/
+F:	Documentation/ABI/testing/jtag-cdev
 
 K10TEMP HARDWARE MONITORING DRIVER
 M:	Clemens Ladisch <clemens@ladisch.de>
-- 
1.7.1
