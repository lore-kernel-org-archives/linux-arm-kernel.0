From: paul@pwsan.com (Paul Walmsley)
Date: Fri, 02 Jul 2010 09:29:51 -0600
Subject: [PATCH 18/20] OMAP2+: hwmod/device: update documentation and copyright
In-Reply-To: <20100702152703.6221.33529.stgit@localhost.localdomain>
References: <20100702152703.6221.33529.stgit@localhost.localdomain>
Message-ID: <20100702152948.6221.19663.stgit@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Update some minor documentation issues and update copyright for
omap_device/omap_hwmod code.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Beno?t Cousson <b-cousson@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod.c |   17 ++++++++++++++++-
 arch/arm/plat-omap/omap_device.c |    9 ++++++---
 2 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index b012057..4002774 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -422,7 +422,7 @@ static int _init_main_clk(struct omap_hwmod *oh)
 }
 
 /**
- * _init_interface_clk - get a struct clk * for the the hwmod's interface clks
+ * _init_interface_clks - get a struct clk * for the the hwmod's interface clks
  * @oh: struct omap_hwmod *
  *
  * Called from _init_clocks().  Populates the @oh OCP slave interface
@@ -1074,6 +1074,21 @@ void omap_hwmod_writel(u32 v, struct omap_hwmod *oh, u16 reg_offs)
 	__raw_writel(v, oh->_mpu_rt_va + reg_offs);
 }
 
+/**
+ * omap_hwmod_set_slave_idlemode - set the hwmod's OCP slave idlemode
+ * @oh: struct omap_hwmod *
+ * @idlemode: SIDLEMODE field bits (shifted to bit 0)
+ *
+ * Sets the IP block's OCP slave idlemode in hardware, and updates our
+ * local copy.  Intended to be used by drivers that have some erratum
+ * that requires direct manipulation of the SIDLEMODE bits.  Returns
+ * -EINVAL if @oh is null, or passes along the return value from
+ * _set_slave_idlemode().
+ *
+ * XXX Does this function have any current users?  If not, we should
+ * remove it; it is better to let the rest of the hwmod code handle this.
+ * Any users of this function should be scrutinized carefully.
+ */
 int omap_hwmod_set_slave_idlemode(struct omap_hwmod *oh, u8 idlemode)
 {
 	u32 v;
diff --git a/arch/arm/plat-omap/omap_device.c b/arch/arm/plat-omap/omap_device.c
index dee4629..ea0d659 100644
--- a/arch/arm/plat-omap/omap_device.c
+++ b/arch/arm/plat-omap/omap_device.c
@@ -1,7 +1,7 @@
 /*
  * omap_device implementation
  *
- * Copyright (C) 2009 Nokia Corporation
+ * Copyright (C) 2009-2010 Nokia Corporation
  * Paul Walmsley, Kevin Hilman
  *
  * Developed in collaboration with (alphabetical order): Benoit
@@ -90,8 +90,11 @@
 #define USE_WAKEUP_LAT			0
 #define IGNORE_WAKEUP_LAT		1
 
-
-#define OMAP_DEVICE_MAGIC 0xf00dcafe
+/*
+ * OMAP_DEVICE_MAGIC: used to determine whether a struct omap_device
+ * obtained via container_of() is in fact a struct omap_device
+ */
+#define OMAP_DEVICE_MAGIC		 0xf00dcafe
 
 /* Private functions */
 
