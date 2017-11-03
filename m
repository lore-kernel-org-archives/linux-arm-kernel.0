From: samitolvanen@google.com (Sami Tolvanen)
Date: Fri,  3 Nov 2017 10:11:49 -0700
Subject: [PATCH 05/15] scripts/mod: disable LTO for empty.c
In-Reply-To: <20171103171203.107569-1-samitolvanen@google.com>
References: <20171103171203.107569-1-samitolvanen@google.com>
Message-ID: <20171103171203.107569-6-samitolvanen@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With CONFIG_CLANG_LTO, clang generates LLVM IR instead of ELF object
files. As empty.o is used for probing target properties, disable LTO
for it to produce an object file instead.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 scripts/mod/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/scripts/mod/Makefile b/scripts/mod/Makefile
index 42c5d50f2bcc..e014b2fdd069 100644
--- a/scripts/mod/Makefile
+++ b/scripts/mod/Makefile
@@ -1,5 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 OBJECT_FILES_NON_STANDARD := y
+CFLAGS_empty.o += $(DISABLE_LTO)
 
 hostprogs-y	:= modpost mk_elfconfig
 always		:= $(hostprogs-y) empty.o
-- 
2.15.0.403.gc27cc4dac6-goog
