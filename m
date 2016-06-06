From: rmk@arm.linux.org.uk (Russell King)
Date: Mon, 06 Jun 2016 17:59:13 +0100
Subject: [PATCH kexec-tools v2 06/32] kdump: print mmap() offset in hex
In-Reply-To: <20160606164129.GM1041@n2100.armlinux.org.uk>
References: <20160606164129.GM1041@n2100.armlinux.org.uk>
Message-ID: <E1b9xrt-0003rz-JE@e0050434b2927.dyn.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When mmap() fails, printing a large decimal number is mostly
meaningless - it's not obvious what it means.  Printing a hex number
is more obvious, because we can see whether it's over 32-bit, or not
page aligned.

Reviewed-by: Pratyush Anand <panand@redhat.com>
Signed-off-by: Russell King <rmk@arm.linux.org.uk>
---
 kdump/kdump.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kdump/kdump.c b/kdump/kdump.c
index 34d2149..f34727f 100644
--- a/kdump/kdump.c
+++ b/kdump/kdump.c
@@ -37,7 +37,7 @@ static void *map_addr(int fd, unsigned long size, off_t offset)
 
 	result = mmap(0, len, PROT_READ, MAP_SHARED, fd, offset - map_offset);
 	if (result == MAP_FAILED) {
-		fprintf(stderr, "Cannot mmap " DEV_MEM " offset: %llu size: %lu: %s\n",
+		fprintf(stderr, "Cannot mmap " DEV_MEM " offset: %#llx size: %lu: %s\n",
 			(unsigned long long)offset, size, strerror(errno));
 		exit(5);
 	}
-- 
1.9.1
