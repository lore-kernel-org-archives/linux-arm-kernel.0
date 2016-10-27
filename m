From: labbott@redhat.com (Laura Abbott)
Date: Thu, 27 Oct 2016 09:27:33 -0700
Subject: [PATCHv4 3/4] arm64: dump: Remove max_addr
In-Reply-To: <1477585654-8908-1-git-send-email-labbott@redhat.com>
References: <1477585654-8908-1-git-send-email-labbott@redhat.com>
Message-ID: <1477585654-8908-4-git-send-email-labbott@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


max_addr was added as part of struct ptdump_info but has never actually
been used. Remove it.

Reviewed-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Mark Rutland <mark.rutland@arm.com>
Tested-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Laura Abbott <labbott@redhat.com>
---
v4: No changes
---
 arch/arm64/include/asm/ptdump.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/include/asm/ptdump.h b/arch/arm64/include/asm/ptdump.h
index 16335da..f72ee69 100644
--- a/arch/arm64/include/asm/ptdump.h
+++ b/arch/arm64/include/asm/ptdump.h
@@ -30,7 +30,6 @@ struct ptdump_info {
 	struct mm_struct		*mm;
 	const struct addr_marker	*markers;
 	unsigned long			base_addr;
-	unsigned long			max_addr;
 };
 
 void ptdump_walk_pgd(struct seq_file *s, struct ptdump_info *info);
-- 
2.7.4
