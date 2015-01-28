From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 28 Jan 2015 16:19:31 +0100
Subject: [PATCH] mtd: export new mtd_mmap_capabilities
Message-ID: <1900951.4yX9yJNQM5@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The recently added mtd_mmap_capabilities can be used from loadable
modules, in particular romfs, but is not exported, so we get

ERROR: "mtd_mmap_capabilities" [fs/romfs/romfs.ko] undefined!

This adds the missing export.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: b4caecd48005f ("fs: introduce f_op->mmap_capabilities for nommu mmap support")

diff --git a/drivers/mtd/mtdcore.c b/drivers/mtd/mtdcore.c
index 1eef3b032f08..de7957681680 100644
--- a/drivers/mtd/mtdcore.c
+++ b/drivers/mtd/mtdcore.c
@@ -365,6 +365,7 @@ unsigned mtd_mmap_capabilities(struct mtd_info *mtd)
 		return NOMMU_MAP_COPY;
 	}
 }
+EXPORT_SYMBOL_GPL(mtd_mmap_capabilities);
 #endif
 
 /**
