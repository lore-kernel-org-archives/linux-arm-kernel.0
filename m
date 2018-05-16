From: hch@lst.de (Christoph Hellwig)
Date: Wed, 16 May 2018 07:43:36 +0200
Subject: [PATCH 02/14] fs: make the filemap_page_mkwrite prototype consistent
In-Reply-To: <20180516054348.15950-1-hch@lst.de>
References: <20180516054348.15950-1-hch@lst.de>
Message-ID: <20180516054348.15950-3-hch@lst.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

!CONFIG_MMU version didn't agree with the rest of the kernel..

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 mm/filemap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 52517f28e6f4..cf21ced98eff 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2748,7 +2748,7 @@ int generic_file_readonly_mmap(struct file *file, struct vm_area_struct *vma)
 	return generic_file_mmap(file, vma);
 }
 #else
-int filemap_page_mkwrite(struct vm_fault *vmf)
+vm_fault_t filemap_page_mkwrite(struct vm_fault *vmf)
 {
 	return -ENOSYS;
 }
-- 
2.17.0
