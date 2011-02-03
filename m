From: arve@android.com (=?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?=)
Date: Wed,  2 Feb 2011 18:54:20 -0800
Subject: [PATCH 2/5] ARM: etm: Don't limit tracing to only non-secure code.
In-Reply-To: <1296701663-12168-1-git-send-email-arve@android.com>
References: <1296701663-12168-1-git-send-email-arve@android.com>
Message-ID: <1296701663-12168-2-git-send-email-arve@android.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On some systems kernel code is considered secure, and this code
already limits tracing to the kernel text segment which results
in no trace data.

Signed-off-by: Arve Hj?nnev?g <arve@android.com>
---
 arch/arm/kernel/etm.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/kernel/etm.c b/arch/arm/kernel/etm.c
index 308b733..2ea0b7c 100644
--- a/arch/arm/kernel/etm.c
+++ b/arch/arm/kernel/etm.c
@@ -55,7 +55,7 @@ static inline bool trace_isrunning(struct tracectx *t)
 static int etm_setup_address_range(struct tracectx *t, int n,
 		unsigned long start, unsigned long end, int exclude, int data)
 {
-	u32 flags = ETMAAT_ARM | ETMAAT_IGNCONTEXTID | ETMAAT_NSONLY | \
+	u32 flags = ETMAAT_ARM | ETMAAT_IGNCONTEXTID | ETMAAT_IGNSECURITY |
 		    ETMAAT_NOVALCMP;
 
 	if (n < 1 || n > t->ncmppairs)
-- 
1.7.3.1
