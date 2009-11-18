From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Wed, 18 Nov 2009 14:33:00 +0100
Subject: [PATCH 05/19] ARM: S5PC1XX: move common s5pc1xx mach/* includes to
	plat-s5pc1xx/include/mach
In-Reply-To: <1258551194-16018-1-git-send-email-m.szyprowski@samsung.com>
References: <1258551194-16018-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <1258551194-16018-6-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kyungmin Park <kyungmin.park@samsung.com>

All includes that are common for S5PC100 and S5PC110 are moved to
plat-s5pc1xx/include/mach, so they can be used by both sub-platforms.

Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>

---
 .../include/mach/gpio-core.h                       |    2 +-
 .../include/mach/hardware.h                        |    2 +-
 .../include/mach/irqs.h                            |    2 +-
 .../include/mach/memory.h                          |    2 +-
 .../include/mach/pwm-clock.h                       |    2 +-
 .../include/mach/tick.h                            |    2 +-
 .../include/mach/uncompress.h                      |    2 +-
 7 files changed, 7 insertions(+), 7 deletions(-)
 rename arch/arm/{mach-s5pc100 => plat-s5pc1xx}/include/mach/gpio-core.h (91%)
 rename arch/arm/{mach-s5pc100 => plat-s5pc1xx}/include/mach/hardware.h (83%)
 rename arch/arm/{mach-s5pc100 => plat-s5pc1xx}/include/mach/irqs.h (87%)
 rename arch/arm/{mach-s5pc100 => plat-s5pc1xx}/include/mach/memory.h (89%)
 rename arch/arm/{mach-s5pc100 => plat-s5pc1xx}/include/mach/pwm-clock.h (96%)
 rename arch/arm/{mach-s5pc100 => plat-s5pc1xx}/include/mach/tick.h (93%)
 rename arch/arm/{mach-s5pc100 => plat-s5pc1xx}/include/mach/uncompress.h (92%)

diff --git a/arch/arm/mach-s5pc100/include/mach/gpio-core.h b/arch/arm/plat-s5pc1xx/include/mach/gpio-core.h
similarity index 91%
rename from arch/arm/mach-s5pc100/include/mach/gpio-core.h
rename to arch/arm/plat-s5pc1xx/include/mach/gpio-core.h
index ad28d8e..6364800 100644
--- a/arch/arm/mach-s5pc100/include/mach/gpio-core.h
+++ b/arch/arm/plat-s5pc1xx/include/mach/gpio-core.h
@@ -1,4 +1,4 @@
-/* arch/arm/mach-s5pc100/include/mach/gpio-core.h
+/* arch/arm/plat-s5pc1xx/include/mach/gpio-core.h
  *
  * Copyright 2009 Samsung Electronics Co.
  *      Byungho Min <bhmin@samsung.com>
diff --git a/arch/arm/mach-s5pc100/include/mach/hardware.h b/arch/arm/plat-s5pc1xx/include/mach/hardware.h
similarity index 83%
rename from arch/arm/mach-s5pc100/include/mach/hardware.h
rename to arch/arm/plat-s5pc1xx/include/mach/hardware.h
index 6b38618..c47affb 100644
--- a/arch/arm/mach-s5pc100/include/mach/hardware.h
+++ b/arch/arm/plat-s5pc1xx/include/mach/hardware.h
@@ -1,4 +1,4 @@
-/* linux/arch/arm/mach-s5pc100/include/mach/hardware.h
+/* linux/arch/arm/plat-s5pc1xx/include/mach/hardware.h
  *
  * Copyright 2009 Samsung Electronics Co.
  *      Byungho Min <bhmin@samsung.com>
diff --git a/arch/arm/mach-s5pc100/include/mach/irqs.h b/arch/arm/plat-s5pc1xx/include/mach/irqs.h
similarity index 87%
rename from arch/arm/mach-s5pc100/include/mach/irqs.h
rename to arch/arm/plat-s5pc1xx/include/mach/irqs.h
index b53fa48..198cff8 100644
--- a/arch/arm/mach-s5pc100/include/mach/irqs.h
+++ b/arch/arm/plat-s5pc1xx/include/mach/irqs.h
@@ -1,4 +1,4 @@
-/* linux/arch/arm/mach-s5pc100/include/mach/irqs.h
+/* linux/arch/arm/plat-s5pc1xx/include/mach/irqs.h
  *
  * Copyright 2009 Samsung Electronics Co.
  *      Byungho Min <bhmin@samsung.com>
diff --git a/arch/arm/mach-s5pc100/include/mach/memory.h b/arch/arm/plat-s5pc1xx/include/mach/memory.h
similarity index 89%
rename from arch/arm/mach-s5pc100/include/mach/memory.h
rename to arch/arm/plat-s5pc1xx/include/mach/memory.h
index 21cc182..d378f45 100644
--- a/arch/arm/mach-s5pc100/include/mach/memory.h
+++ b/arch/arm/plat-s5pc1xx/include/mach/memory.h
@@ -1,4 +1,4 @@
-/* arch/arm/mach-s5pc100/include/mach/memory.h
+/* linux/arch/arm/plat-s5pc1xx/include/mach/memory.h
  *
  * Copyright 2008 Samsung Electronics Co.
  *      Byungho Min <bhmin@samsung.com>
diff --git a/arch/arm/mach-s5pc100/include/mach/pwm-clock.h b/arch/arm/plat-s5pc1xx/include/mach/pwm-clock.h
similarity index 96%
rename from arch/arm/mach-s5pc100/include/mach/pwm-clock.h
rename to arch/arm/plat-s5pc1xx/include/mach/pwm-clock.h
index b34d2f7..09a2834 100644
--- a/arch/arm/mach-s5pc100/include/mach/pwm-clock.h
+++ b/arch/arm/plat-s5pc1xx/include/mach/pwm-clock.h
@@ -1,4 +1,4 @@
-/* linux/arch/arm/mach-s5pc100/include/mach/pwm-clock.h
+/* linux/arch/arm/plat-s5pc1xx/include/mach/pwm-clock.h
  *
  * Copyright 2009 Samsung Electronics Co.
  *      Byungho Min <bhmin@samsung.com>
diff --git a/arch/arm/mach-s5pc100/include/mach/tick.h b/arch/arm/plat-s5pc1xx/include/mach/tick.h
similarity index 93%
rename from arch/arm/mach-s5pc100/include/mach/tick.h
rename to arch/arm/plat-s5pc1xx/include/mach/tick.h
index d3de0f3..e43d1fd 100644
--- a/arch/arm/mach-s5pc100/include/mach/tick.h
+++ b/arch/arm/plat-s5pc1xx/include/mach/tick.h
@@ -1,4 +1,4 @@
-/* linux/arch/arm/mach-s5pc100/include/mach/tick.h
+/* linux/arch/arm/plat-s5pc1xx/include/mach/tick.h
  *
  * Copyright 2009 Samsung Electronics Co.
  *	Byungho Min <bhmin@samsung.com>
diff --git a/arch/arm/mach-s5pc100/include/mach/uncompress.h b/arch/arm/plat-s5pc1xx/include/mach/uncompress.h
similarity index 92%
rename from arch/arm/mach-s5pc100/include/mach/uncompress.h
rename to arch/arm/plat-s5pc1xx/include/mach/uncompress.h
index 01ccf53..e9ee0be 100644
--- a/arch/arm/mach-s5pc100/include/mach/uncompress.h
+++ b/arch/arm/plat-s5pc1xx/include/mach/uncompress.h
@@ -1,4 +1,4 @@
-/* arch/arm/mach-s5pc100/include/mach/uncompress.h
+/* linux/arch/arm/plat-s5pc1xx/include/mach/uncompress.h
  *
  * Copyright 2009 Samsung Electronics Co.
  *	Byungho Min <bhmin@samsung.com>
-- 
1.6.4
