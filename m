From: rmk@arm.linux.org.uk (Russell King)
Date: Mon, 06 Jun 2016 17:58:57 +0100
Subject: [PATCH kexec-tools v2 03/32] kdump: actually write out the memory
In-Reply-To: <20160606164129.GM1041@n2100.armlinux.org.uk>
References: <20160606164129.GM1041@n2100.armlinux.org.uk>
Message-ID: <E1b9xrd-0003rh-Ti@e0050434b2927.dyn.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Actually write out the memory rather than writing the notes a second
time.

Reviewed-by: Pratyush Anand <panand@redhat.com>
Signed-off-by: Russell King <rmk@arm.linux.org.uk>
---
 kdump/kdump.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kdump/kdump.c b/kdump/kdump.c
index 99a1789..1f5b984 100644
--- a/kdump/kdump.c
+++ b/kdump/kdump.c
@@ -300,7 +300,7 @@ int main(int argc, char **argv)
 	for(i = 0; i < ehdr->e_phnum; i++) {
 		unsigned long long offset, size;
 		size_t wsize;
-		if (phdr[i].p_type != PT_NOTE) {
+		if (phdr[i].p_type == PT_NOTE) {
 			continue;
 		}
 		offset = phdr[i].p_offset;
-- 
1.9.1
