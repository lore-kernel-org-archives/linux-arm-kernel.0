From: iamjoonsoo.kim@lge.com (Joonsoo Kim)
Date: Wed,  6 Feb 2013 18:13:28 +0900
Subject: [PATCH v6 1/3] ARM: vmregion: remove vmregion code entirely
In-Reply-To: <1360142010-10598-1-git-send-email-iamjoonsoo.kim@lge.com>
References: <1360142010-10598-1-git-send-email-iamjoonsoo.kim@lge.com>
Message-ID: <1360142010-10598-2-git-send-email-iamjoonsoo.kim@lge.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now, there is no user for vmregion.
So remove it.

Acked-by: Nicolas Pitre <nico@linaro.org>
Tested-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Signed-off-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>

diff --git a/arch/arm/mm/Makefile b/arch/arm/mm/Makefile
index 8a9c4cb..4e333fa 100644
--- a/arch/arm/mm/Makefile
+++ b/arch/arm/mm/Makefile
@@ -6,7 +6,7 @@ obj-y				:= dma-mapping.o extable.o fault.o init.o \
 				   iomap.o
 
 obj-$(CONFIG_MMU)		+= fault-armv.o flush.o idmap.o ioremap.o \
-				   mmap.o pgd.o mmu.o vmregion.o
+				   mmap.o pgd.o mmu.o
 
 ifneq ($(CONFIG_MMU),y)
 obj-y				+= nommu.o
diff --git a/arch/arm/mm/vmregion.c b/arch/arm/mm/vmregion.c
deleted file mode 100644
index a631016..0000000
diff --git a/arch/arm/mm/vmregion.h b/arch/arm/mm/vmregion.h
deleted file mode 100644
index 0f5a5f2..0000000
-- 
1.7.9.5
