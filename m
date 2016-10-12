From: labbott@redhat.com (Laura Abbott)
Date: Wed, 12 Oct 2016 15:32:01 -0700
Subject: [PATCHv2 3/4] arm64: dump: Remove max_addr
In-Reply-To: <1476311522-15381-1-git-send-email-labbott@redhat.com>
References: <1476311522-15381-1-git-send-email-labbott@redhat.com>
Message-ID: <1476311522-15381-4-git-send-email-labbott@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


max_addr was added as part of struct ptdump_info but has never actually
been used. Remove it.

Signed-off-by: Laura Abbott <labbott@redhat.com>
---
New for v2 of the series
---
 arch/arm64/include/asm/ptdump.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/include/asm/ptdump.h b/arch/arm64/include/asm/ptdump.h
index 7c35689..8fc0957 100644
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
