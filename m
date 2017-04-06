From: alex.bennee@linaro.org (=?UTF-8?q?Alex=20Benn=C3=A9e?=)
Date: Thu,  6 Apr 2017 20:07:22 +0100
Subject: [RFC kvm-unit-tests PATCH 3/8] Makefile: set VPATH based on SRCDIR
In-Reply-To: <20170406190727.5624-1-alex.bennee@linaro.org>
References: <20170406190727.5624-1-alex.bennee@linaro.org>
Message-ID: <20170406190727.5624-4-alex.bennee@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Setting the VPATH prompts make to search VPATH for source files. There
are still some fix-ups needed for linking and including other Makefile
fragments for each architecture.

Signed-off-by: Alex Benn?e <alex.bennee@linaro.org>
---
 Makefile | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Makefile b/Makefile
index eba7b28..80bc57e 100644
--- a/Makefile
+++ b/Makefile
@@ -7,6 +7,9 @@ endif
 
 include config.mak
 
+# Set search path for all sources
+VPATH=$(SRCDIR)
+
 libdirs-get = $(shell [ -d "lib/$(1)" ] && echo "lib/$(1) lib/$(1)/asm")
 ARCH_LIBDIRS := $(call libdirs-get,$(ARCH)) $(call libdirs-get,$(TEST_DIR))
 
-- 
2.11.0
