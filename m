From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon, 30 Mar 2015 15:20:32 +0200
Subject: [PATCH 2/2] Kbuild: kallsyms: drop special handling of pre-3.0 GCC
 symbols
In-Reply-To: <1427721632-11665-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1427721632-11665-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <1427721632-11665-3-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since we have required at least GCC v3.2 for some time now, we
can drop the special handling of the 'gcc[0-9]_compiled.' label
which is not emitted anymore since GCC v3.0.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 scripts/kallsyms.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/scripts/kallsyms.c b/scripts/kallsyms.c
index f4b016782f0d..8fa81e84e295 100644
--- a/scripts/kallsyms.c
+++ b/scripts/kallsyms.c
@@ -214,7 +214,6 @@ static int symbol_valid(struct sym_entry *s)
 		NULL };
 
 	static char *special_suffixes[] = {
-		"_compiled.",		/* gcc < 3.0: "gcc[0-9]_compiled." */
 		"_veneer",		/* arm */
 		NULL };
 
-- 
1.8.3.2
