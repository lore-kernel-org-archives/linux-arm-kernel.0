From: jonathan.austin@arm.com (Jonathan Austin)
Date: Tue, 14 May 2013 12:27:25 +0100
Subject: [PATCH v2 3/3] ARM: vexpress-nommu: add a Makefile.boot to restore
 single-platform build
In-Reply-To: <1368530845-7415-1-git-send-email-jonathan.austin@arm.com>
References: <1368530845-7415-1-git-send-email-jonathan.austin@arm.com>
Message-ID: <1368530845-7415-4-git-send-email-jonathan.austin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When a single-platform kernel is built, a machine-specific Makefile.boot is
expected. In the move to a multiplatform kernels this was removed for
vexpress. Assuming AUTO_ZRELADDR is selected and a DT is used, the values
recorded in it are no-longer required. However, the missing file breaks building
of a single platform kernel for vexpress, such as when using vexpress and a
platform without an MMU.

This patch re-instates Makefile.boot for vexpress in single platform
configuration, fixing single-platform build. This change does not affect the
multi-platform kernel.

Signed-off-by: Jonathan Austin <jonathan.austin@arm.com>
CC: Pawel Moll <pawel.moll@arm.com>
---
 arch/arm/mach-vexpress/Makefile.boot |    4 ++++
 1 file changed, 4 insertions(+)
 create mode 100644 arch/arm/mach-vexpress/Makefile.boot

diff --git a/arch/arm/mach-vexpress/Makefile.boot b/arch/arm/mach-vexpress/Makefile.boot
new file mode 100644
index 0000000..8caa868
--- /dev/null
+++ b/arch/arm/mach-vexpress/Makefile.boot
@@ -0,0 +1,4 @@
+# This is a dummy Makefile.boot for building ARCH_VEXPRESS as a standalone
+# platform as opposed with ARCH_MULTIPLATFORM. It is preferable to use
+# CONFIG_AUTO_ZRELADDR=y and DT but uncomment the line below if you need it.
+#   zreladdr-y	+= 0x00008000
-- 
1.7.9.5
