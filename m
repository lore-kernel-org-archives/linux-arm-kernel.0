From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Fri, 11 Jul 2014 13:00:39 +0200
Subject: [PATCH v4 4/4] ARM: pxa: Move iotable mapping inside vmalloc region
In-Reply-To: <1405076439-22038-1-git-send-email-laurent.pinchart@ideasonboard.com>
References: <1405076439-22038-1-git-send-email-laurent.pinchart@ideasonboard.com>
Message-ID: <1405076439-22038-5-git-send-email-laurent.pinchart@ideasonboard.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>

In order to remove the following ugly message:

  BUG: mapping for 0x00000000 at 0xff000000 out of vmalloc space

the iotable mappings should be re-located inside the vmalloc
region. Such move was introduced at commit:

commit 0536bdf33faff4d940ac094c77998cfac368cfff
Author: Nicolas Pitre <nicolas.pitre@linaro.org>
Date:   Thu Aug 25 00:35:59 2011 -0400

    ARM: move iotable mappings within the vmalloc region

Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
[laurent.pinchart at ideasonboard.com: Hardcode the virtual address]
Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Acked-by: Nicolas Pitre <nico@linaro.org>
---
 arch/arm/mach-pxa/include/mach/hardware.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-pxa/include/mach/hardware.h b/arch/arm/mach-pxa/include/mach/hardware.h
index efb3965..8d63c21 100644
--- a/arch/arm/mach-pxa/include/mach/hardware.h
+++ b/arch/arm/mach-pxa/include/mach/hardware.h
@@ -19,7 +19,7 @@
  * Workarounds for at least 2 errata so far require this.
  * The mapping is set in mach-pxa/generic.c.
  */
-#define UNCACHED_PHYS_0		0xff000000
+#define UNCACHED_PHYS_0		0xfe000000
 #define UNCACHED_PHYS_0_SIZE	0x00100000
 
 /*
-- 
1.8.5.5
