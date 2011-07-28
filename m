From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 28 Jul 2011 14:45:50 +0000
Subject: [PATCH] ARM: zynq: remove incorrectly deleted file
Message-ID: <1311864350-25533-1-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

My previous commit left the file empty and present in the
Makefile, which is a bit dirty and caused problems with
'make distclean', as pointed out by David Howells.
This hopefully cleans it up the right way.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: David Howells <dhowells@redhat.com>
Cc: John Linn <john.linn@xilinx.com>
---
 arch/arm/mach-zynq/Makefile   |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)
 delete mode 100644 arch/arm/mach-zynq/board_dt.c

diff --git a/arch/arm/mach-zynq/Makefile b/arch/arm/mach-zynq/Makefile
index c550c67..397268c 100644
--- a/arch/arm/mach-zynq/Makefile
+++ b/arch/arm/mach-zynq/Makefile
@@ -3,4 +3,4 @@
 #
 
 # Common support
-obj-y 				:= common.o timer.o board_dt.o
+obj-y				:= common.o timer.o
diff --git a/arch/arm/mach-zynq/board_dt.c b/arch/arm/mach-zynq/board_dt.c
deleted file mode 100644
index e69de29..0000000
-- 
1.7.4.1
