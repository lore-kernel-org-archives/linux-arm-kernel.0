From: pali.rohar@gmail.com (=?UTF-8?q?Pali=20Roh=C3=A1r?=)
Date: Mon,  6 Jul 2015 22:26:11 +0200
Subject: [PATCH 3/5] arm: atags: Fix declaration of function save_atags
In-Reply-To: <1436214373-12969-1-git-send-email-pali.rohar@gmail.com>
References: <1436214373-12969-1-git-send-email-pali.rohar@gmail.com>
Message-ID: <1436214373-12969-4-git-send-email-pali.rohar@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In file atags_proc.c function save_atags() expect const argument, but in
atags.h file is declarated as non const. Fix declaration in atags.h file to
match what is expected.

Signed-off-by: Pali Roh?r <pali.rohar@gmail.com>
---
 arch/arm/kernel/atags.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/kernel/atags.h b/arch/arm/kernel/atags.h
index ec4164d..2dfc30f 100644
--- a/arch/arm/kernel/atags.h
+++ b/arch/arm/kernel/atags.h
@@ -1,7 +1,7 @@
 #ifdef CONFIG_ATAGS_PROC
-extern void save_atags(struct tag *tags);
+extern void save_atags(const struct tag *tags);
 #else
-static inline void save_atags(struct tag *tags) { }
+static inline void save_atags(const struct tag *tags) { }
 #endif
 
 void convert_to_tag_list(struct tag *tags);
-- 
1.7.9.5
