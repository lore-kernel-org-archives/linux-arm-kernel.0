From: gerg@uclinux.org (Greg Ungerer)
Date: Mon, 26 Sep 2016 10:52:29 +1000
Subject: [PATCH 3/4] arm/versatile: empty Makefile.boot needed for no-MMU
 compile
In-Reply-To: <1474851150-12532-1-git-send-email-gerg@uclinux.org>
References: <1474851150-12532-1-git-send-email-gerg@uclinux.org>
Message-ID: <1474851150-12532-4-git-send-email-gerg@uclinux.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To compile the arm versatile board with the MMU disabled (!CONFIG_MMU)
a Makefile.boot is required. Without it you get:

  SYSMAP  System.map
arch/arm/boot/Makefile:15: arch/arm/mach-versatile//Makefile.boot: No such file or directory
make[2]: *** No rule to make target `arch/arm/mach-versatile//Makefile.boot'.  Stop.

Create an empty Makefile.boot for the versatile machine. This is a
copy of the other empty machine Makefile.boot files. (A few have this
same commented empty file: stm32, ep93xx, lpc18xx, efm32 and vexpress).

Signed-off-by: Greg Ungerer <gerg@uclinux.org>
---
 arch/arm/mach-versatile/Makefile.boot | 3 +++
 1 file changed, 3 insertions(+)
 create mode 100644 arch/arm/mach-versatile/Makefile.boot

diff --git a/arch/arm/mach-versatile/Makefile.boot b/arch/arm/mach-versatile/Makefile.boot
new file mode 100644
index 0000000..eacfc3f
--- /dev/null
+++ b/arch/arm/mach-versatile/Makefile.boot
@@ -0,0 +1,3 @@
+# Empty file waiting for deletion once Makefile.boot isn't needed any more.
+# Patch waits for application at
+# http://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=7889/1 .
-- 
1.9.1
