From: dedekind1@gmail.com (Artem Bityutskiy)
Date: Thu, 14 Mar 2013 13:27:41 +0200
Subject: [PATCH 2/4] Documentation: mtd: amend the sysfs docs after mtdchar
 merge
In-Reply-To: <1363260463-10609-1-git-send-email-dedekind1@gmail.com>
References: <1363260463-10609-1-git-send-email-dedekind1@gmail.com>
Message-ID: <1363260463-10609-2-git-send-email-dedekind1@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>

The mtdchar module was merged with the mtdcore module, which means that the
MTD_CHAR Kconfig symbol does not exist any more.

Signed-off-by: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
---
 Documentation/ABI/testing/sysfs-class-mtd |    6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-class-mtd b/Documentation/ABI/testing/sysfs-class-mtd
index 938ef71..3105644 100644
--- a/Documentation/ABI/testing/sysfs-class-mtd
+++ b/Documentation/ABI/testing/sysfs-class-mtd
@@ -14,8 +14,7 @@ Description:
 		The /sys/class/mtd/mtd{0,1,2,3,...} directories correspond
 		to each /dev/mtdX character device.  These may represent
 		physical/simulated flash devices, partitions on a flash
-		device, or concatenated flash devices.  They exist regardless
-		of whether CONFIG_MTD_CHAR is actually enabled.
+		device, or concatenated flash devices.
 
 What:		/sys/class/mtd/mtdXro/
 Date:		April 2009
@@ -23,8 +22,7 @@ KernelVersion:	2.6.29
 Contact:	linux-mtd at lists.infradead.org
 Description:
 		These directories provide the corresponding read-only device
-		nodes for /sys/class/mtd/mtdX/ .  They are only created
-		(for the benefit of udev) if CONFIG_MTD_CHAR is enabled.
+		nodes for /sys/class/mtd/mtdX/ .
 
 What:		/sys/class/mtd/mtdX/dev
 Date:		April 2009
-- 
1.7.10.4
