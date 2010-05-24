From: Hiroshi.DOYU@nokia.com (Hiroshi DOYU)
Date: Mon, 24 May 2010 09:35:11 +0300
Subject: [PATCH 1/1] omap iommu: Make omap-iommu.o built-in
Message-ID: <mailman.469.1274683016.2170.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is a platform device registration.

Signed-off-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
---
 arch/arm/mach-omap2/Makefile |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index 7d2cf0f..4d754f6 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -89,7 +89,10 @@ obj-$(CONFIG_OMAP3_EMU)			+= emu.o
 obj-$(CONFIG_OMAP_MBOX_FWK)		+= mailbox_mach.o
 mailbox_mach-objs			:= mailbox.o
 
-obj-$(CONFIG_OMAP_IOMMU)		:= iommu2.o omap-iommu.o
+obj-$(CONFIG_OMAP_IOMMU)		:= iommu2.o
+
+iommu-$(CONFIG_OMAP_IOMMU)		:= omap-iommu.o
+obj-y					+= $(iommu-m) $(iommu-y)
 
 i2c-omap-$(CONFIG_I2C_OMAP)		:= i2c.o
 obj-y					+= $(i2c-omap-m) $(i2c-omap-y)
-- 
1.7.1.rc1
