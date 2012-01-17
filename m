From: will.deacon@arm.com (Will Deacon)
Date: Tue, 17 Jan 2012 16:47:55 +0000
Subject: [PATCH v3 2/3] ARM: vmlinux.lds.S: align the exception fixup table to
 a 4-byte boundary
In-Reply-To: <1326818876-4818-1-git-send-email-will.deacon@arm.com>
References: <1326818876-4818-1-git-send-email-will.deacon@arm.com>
Message-ID: <1326818876-4818-2-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The exception fixup table is currently aligned to a 32-byte boundary.
Whilst this won't cause any problems, the exception_table_entry
structures contain only a pair of unsigned longs, so 4-byte alignment
is all that is required.

Cc: Nicolas Pitre <nico@fluxnic.net>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/kernel/vmlinux.lds.S |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/kernel/vmlinux.lds.S b/arch/arm/kernel/vmlinux.lds.S
index 1077e4f..1e19691 100644
--- a/arch/arm/kernel/vmlinux.lds.S
+++ b/arch/arm/kernel/vmlinux.lds.S
@@ -219,7 +219,7 @@ SECTIONS
 		/*
 		 * The exception fixup table (might need resorting at runtime)
 		 */
-		. = ALIGN(32);
+		. = ALIGN(4);
 		__start___ex_table = .;
 #ifdef CONFIG_MMU
 		*(__ex_table)
-- 
1.7.4.1
