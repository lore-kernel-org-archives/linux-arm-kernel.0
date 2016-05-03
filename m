From: rmk@arm.linux.org.uk (Russell King)
Date: Tue, 03 May 2016 11:21:18 +0100
Subject: [PATCH kexec-tools 03/32] kdump: actually write out the memory
In-Reply-To: <CAHB_GurHc1aVfzJATpNW5yf5s5KkF=t5s09FbWq3+9+ZX39KUg@mail.gmail.com>
References: <CAHB_GurHc1aVfzJATpNW5yf5s5KkF=t5s09FbWq3+9+ZX39KUg@mail.gmail.com>
Message-ID: <E1axXSA-0004hB-Ix@e0050434b2927.dyn.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Actually write out the memory rather than writing the notes a second
time.

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
