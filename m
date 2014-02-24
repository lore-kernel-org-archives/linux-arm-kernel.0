From: magnus.damm@gmail.com (Magnus Damm)
Date: Tue, 25 Feb 2014 07:44:46 +0900
Subject: [PATCH v2] ARM: shmobile: Add temporary include workaround
Message-ID: <20140224224446.14786.79602.sendpatchset@w520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Add temporary include path in the mach-shmobile Makefile to
aid coversion from using <mach/something.h> to "something.h"
in the source files.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 Changes since V1:
 - Use += instead of := to avoid breaking MULTIPLATFORM

 arch/arm/mach-shmobile/Makefile |    2 ++
 1 file changed, 2 insertions(+)

--- 0001/arch/arm/mach-shmobile/Makefile
+++ work/arch/arm/mach-shmobile/Makefile	2014-02-25 07:41:56.000000000 +0900
@@ -4,6 +4,8 @@
 
 ccflags-$(CONFIG_ARCH_MULTIPLATFORM) := -I$(srctree)/arch/arm/mach-shmobile/include
 
+ccflags-y += -I$(srctree)/arch/arm/mach-shmobile/include/mach
+
 # Common objects
 obj-y				:= timer.o console.o
 
