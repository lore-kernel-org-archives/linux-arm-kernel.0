From: Hiroshi.DOYU@nokia.com (Hiroshi DOYU)
Date: Thu, 18 Aug 2011 13:13:53 +0300
Subject: [PATCH 1/1] omap: iommu: remove obsolete comments
Message-ID: <mailman.90.1313662778.20020.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove ones referring to non-existing functions.

Signed-off-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
---
 drivers/iommu/omap-iovmm.c |   36 +-----------------------------------
 1 files changed, 1 insertions(+), 35 deletions(-)

diff --git a/drivers/iommu/omap-iovmm.c b/drivers/iommu/omap-iovmm.c
index 81b713a..2db655c 100644
--- a/drivers/iommu/omap-iovmm.c
+++ b/drivers/iommu/omap-iovmm.c
@@ -1,7 +1,7 @@
 /*
  * omap iommu: simple virtual address space management
  *
- * Copyright (C) 2008-2009 Nokia Corporation
+ * Copyright (C) 2008-2009, 2011 Nokia Corporation
  *
  * Written by Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
  *
@@ -25,40 +25,6 @@
 
 #include <plat/iopgtable.h>
 
-/*
- * A device driver needs to create address mappings between:
- *
- * - iommu/device address
- * - physical address
- * - mpu virtual address
- *
- * There are 4 possible patterns for them:
- *
- *    |iova/			  mapping		iommu_		page
- *    | da	pa	va	(d)-(p)-(v)		function	type
- *  ---------------------------------------------------------------------------
- *  1 | c	c	c	 1 - 1 - 1	  _kmap() / _kunmap()	s
- *  2 | c	c,a	c	 1 - 1 - 1	_kmalloc()/ _kfree()	s
- *  3 | c	d	c	 1 - n - 1	  _vmap() / _vunmap()	s
- *  4 | c	d,a	c	 1 - n - 1	_vmalloc()/ _vfree()	n*
- *
- *
- *	'iova':	device iommu virtual address
- *	'da':	alias of 'iova'
- *	'pa':	physical address
- *	'va':	mpu virtual address
- *
- *	'c':	contiguous memory area
- *	'd':	discontiguous memory area
- *	'a':	anonymous memory allocation
- *	'()':	optional feature
- *
- *	'n':	a normal page(4KB) size is used.
- *	's':	multiple iommu superpage(16MB, 1MB, 64KB, 4KB) size is used.
- *
- *	'*':	not yet, but feasible.
- */
-
 static struct kmem_cache *iovm_area_cachep;
 
 /* return total bytes of sg buffers */
-- 
1.7.1
