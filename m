From: alex.bennee@linaro.org (=?UTF-8?q?Alex=20Benn=C3=A9e?=)
Date: Thu,  6 Apr 2017 20:07:21 +0100
Subject: [RFC kvm-unit-tests PATCH 2/8] Makefile: ensure build-head works
 out-of-src-tree
In-Reply-To: <20170406190727.5624-1-alex.bennee@linaro.org>
References: <20170406190727.5624-1-alex.bennee@linaro.org>
Message-ID: <20170406190727.5624-3-alex.bennee@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Pass -C $(SRCDIR) to the git command that generates the build-head
stamp.

Signed-off-by: Alex Benn?e <alex.bennee@linaro.org>
---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 16ce297..eba7b28 100644
--- a/Makefile
+++ b/Makefile
@@ -80,7 +80,7 @@ $(LIBFDT_archive): $(addprefix $(LIBFDT_objdir)/,$(LIBFDT_OBJS))
 
 -include */.*.d */*/.*.d
 
-all: $(shell git rev-parse --verify --short=8 HEAD >build-head 2>/dev/null)
+all: $(shell git -C $(SRCDIR) rev-parse --verify --short=8 HEAD >build-head 2>/dev/null)
 
 standalone: all
 	@scripts/mkstandalone.sh
-- 
2.11.0
