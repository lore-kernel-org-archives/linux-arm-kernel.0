From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 14 Feb 2013 14:49:27 +0100
Subject: [PATCH 11/11] scripts/sortextable: silence script output
In-Reply-To: <1360849767-1463135-1-git-send-email-arnd@arndb.de>
References: <1360849767-1463135-1-git-send-email-arnd@arndb.de>
Message-ID: <1360849767-1463135-12-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The exception table sorter outputs one line every time
it gets called, e.g. 'sort done marker at 66dc00', which
is slightly annoying when doing 'make -s' which is otherwise
completely silent. Since that output is not helpful to
most people building the kernel, turn it off by default.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: David Daney <david.daney@cavium.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
---
 scripts/sortextable.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/sortextable.h b/scripts/sortextable.h
index e4fd45b..f5eb43d 100644
--- a/scripts/sortextable.h
+++ b/scripts/sortextable.h
@@ -182,7 +182,7 @@ do_func(Elf_Ehdr *ehdr, char const *const fname, table_sort_t custom_sort)
 		_r(&sort_needed_sym->st_value) -
 		_r(&sort_needed_sec->sh_addr);
 
-#if 1
+#if 0
 	printf("sort done marker at %lx\n",
 	       (unsigned long)((char *)sort_done_location - (char *)ehdr));
 #endif
-- 
1.8.1.2
