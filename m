From: shijie.huang@arm.com (Huang Shijie)
Date: Thu, 12 May 2016 17:03:57 +0800
Subject: [PATCH] deb-pkg: add the shared header file for arm64
Message-ID: <1463043837-4348-1-git-send-email-shijie.huang@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The arch/arm/include/asm/opcodes.h is also used by the arm64.
This patch copies it to the arm64 deb package.

Signed-off-by: Huang Shijie <shijie.huang@arm.com>
---
 scripts/package/builddeb | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/scripts/package/builddeb b/scripts/package/builddeb
index 6c3b038..f4de0d7 100755
--- a/scripts/package/builddeb
+++ b/scripts/package/builddeb
@@ -323,6 +323,12 @@ fi
 # Build kernel header package
 (cd $srctree; find . -name Makefile\* -o -name Kconfig\* -o -name \*.pl) > "$objtree/debian/hdrsrcfiles"
 (cd $srctree; find arch/$SRCARCH/include include scripts -type f) >> "$objtree/debian/hdrsrcfiles"
+
+if [ "$ARCH" = "arm64" ]; then
+	# The arm64 shares the same header file with the arm
+	(cd $srctree; echo arch/arm/include/asm/opcodes.h) >> "$objtree/debian/hdrsrcfiles"
+fi
+
 (cd $srctree; find arch/$SRCARCH -name module.lds -o -name Kbuild.platforms -o -name Platform) >> "$objtree/debian/hdrsrcfiles"
 (cd $srctree; find $(find arch/$SRCARCH -name include -o -name scripts -type d) -type f) >> "$objtree/debian/hdrsrcfiles"
 (cd $objtree; find arch/$SRCARCH/include Module.symvers include scripts -type f) >> "$objtree/debian/hdrobjfiles"
-- 
2.1.4
