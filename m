From: xiechao.mail@gmail.com (Chao Xie)
Date: Mon, 27 Aug 2012 10:53:59 +0800
Subject: [PATCH 1/5] arm: mmp: make private clock definition exclude from
 common clock
Message-ID: <1346036043-20115-1-git-send-email-xiechao.mail@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Chao Xie <chao.xie@marvell.com>

the clock.c is mmp private implementation, make it excluded
from common clock framework

Signed-off-by: Chao Xie <xiechao.mail@gmail.com>
---
 arch/arm/mach-mmp/Makefile |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-mmp/Makefile b/arch/arm/mach-mmp/Makefile
index b786f7e..815c3e7 100644
--- a/arch/arm/mach-mmp/Makefile
+++ b/arch/arm/mach-mmp/Makefile
@@ -2,13 +2,16 @@
 # Makefile for Marvell's PXA168 processors line
 #
 
-obj-y				+= common.o clock.o devices.o time.o irq.o
+obj-y				+= common.o devices.o time.o irq.o
 
 # SoC support
 obj-$(CONFIG_CPU_PXA168)	+= pxa168.o
 obj-$(CONFIG_CPU_PXA910)	+= pxa910.o
 obj-$(CONFIG_CPU_MMP2)		+= mmp2.o sram.o
 
+ifeq ($(CONFIG_COMMON_CLK), )
+obj-y				+= clock.o
+endif
 ifeq ($(CONFIG_PM),y)
 obj-$(CONFIG_CPU_PXA910)	+= pm-pxa910.o
 obj-$(CONFIG_CPU_MMP2)		+= pm-mmp2.o
-- 
1.7.0.4
