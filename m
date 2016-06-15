From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 15 Jun 2016 17:45:53 +0200
Subject: [PATCH v2 11/11] [EXPERIMENTAL] Kbuild: enable -Wmissing-include-dirs
 by default
In-Reply-To: <20160615154553.3177021-1-arnd@arndb.de>
References: <20160615154553.3177021-1-arnd@arndb.de>
Message-ID: <20160615154553.3177021-12-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I have fixed up all -Wmissing-include-dirs on ARM randconfig builds,
so we could make this the default, but I have not tested this at all
on other architectures.

This enables it anyway, just to see what other warnings we get
when the build bot analyses the branch.

Don't apply (yet).

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 Makefile | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Makefile b/Makefile
index 969924783543..2305cbd61e60 100644
--- a/Makefile
+++ b/Makefile
@@ -781,6 +781,9 @@ endif
 NOSTDINC_FLAGS += -nostdinc -isystem $(shell $(CC) -print-file-name=include)
 CHECKFLAGS     += $(NOSTDINC_FLAGS)
 
+# warn about incorrect -I include paths
+KBUILD_CFLAGS += -Wmissing-include-dirs
+
 # warn about C99 declaration after statement
 KBUILD_CFLAGS += $(call cc-option,-Wdeclaration-after-statement,)
 
-- 
2.9.0
