From: Hiroshi.DOYU@nokia.com (Hiroshi DOYU)
Date: Tue,  1 Jun 2010 08:30:47 +0300
Subject: [PATCH 8/8] omap iommu: Make omap-iommu.o built-in
In-Reply-To: <20100531.123637.28796762.Hiroshi.DOYU@nokia.com>
References: <20100531.123637.28796762.Hiroshi.DOYU@nokia.com>
Message-ID: <1275370247-15888-8-git-send-email-Hiroshi.DOYU@nokia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is a platform device registration.

Signed-off-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
---
 arch/arm/mach-omap2/Makefile |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index ea52b03..6c6d7c6 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -89,7 +89,10 @@ obj-$(CONFIG_OMAP3_EMU)			+= emu.o
 obj-$(CONFIG_OMAP_MBOX_FWK)		+= mailbox_mach.o
 mailbox_mach-objs			:= mailbox.o
 
-obj-$(CONFIG_OMAP_IOMMU)		:= iommu2.o omap-iommu.o
+obj-$(CONFIG_OMAP_IOMMU)		+= iommu2.o
+
+iommu-$(CONFIG_OMAP_IOMMU)		:= omap-iommu.o
+obj-y					+= $(iommu-m) $(iommu-y)
 
 i2c-omap-$(CONFIG_I2C_OMAP)		:= i2c.o
 obj-y					+= $(i2c-omap-m) $(i2c-omap-y)
-- 
1.7.1.rc1
