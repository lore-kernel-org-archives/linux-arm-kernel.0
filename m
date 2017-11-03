From: oleksandrs@mellanox.com (Oleksandr Shamray)
Date: Fri,  3 Nov 2017 17:54:09 +0200
Subject: [patch v11 4/4] Documentation: jtag: Add ABI documentation
In-Reply-To: <1509724449-26221-1-git-send-email-oleksandrs@mellanox.com>
References: <1509724449-26221-1-git-send-email-oleksandrs@mellanox.com>
Message-ID: <1509724449-26221-5-git-send-email-oleksandrs@mellanox.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Added document that describe the ABI for JTAG class drivrer

Signed-off-by: Oleksandr Shamray <oleksandrs@mellanox.com>
Acked-by: Arnd Bergmann <arnd@arndb.de>
---
v10->v11
v9->v10
Fixes added by Oleksandr:
- change jtag-cdev to jtag-dev in documentation
- update Kernel Version and Date in jtag-dev documentation;
v8->v9
v7->v8
v6->v7
Comments pointed by Pavel Machek <pavel@ucw.cz>
- Added jtag-cdev documentation to Documentation/ABI/testing folder
---
 Documentation/ABI/testing/jatg-dev |   27 +++++++++++++++++++++++++++
 1 files changed, 27 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/ABI/testing/jatg-dev

diff --git a/Documentation/ABI/testing/jatg-dev b/Documentation/ABI/testing/jatg-dev
new file mode 100644
index 0000000..803dbab
--- /dev/null
+++ b/Documentation/ABI/testing/jatg-dev
@@ -0,0 +1,27 @@
+What:		/dev/jtag[0-9]+
+Date:		October 2017
+KernelVersion:	4.15
+Contact:	oleksandrs at mellanox.com
+Description:
+		The misc device files /dev/jtag* are the interface
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
-- 
1.7.1
