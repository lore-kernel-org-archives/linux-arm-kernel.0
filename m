From: xiechao.mail@gmail.com (Chao Xie)
Date: Tue, 31 Jul 2012 14:13:10 +0800
Subject: [PATCH 3/7] arm: cache: fix uninitialized ptr in tauros2_init
In-Reply-To: <1343715194-25900-1-git-send-email-xiechao.mail@gmail.com>
References: <1343715194-25900-1-git-send-email-xiechao.mail@gmail.com>
Message-ID: <1343715194-25900-3-git-send-email-xiechao.mail@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Chao Xie <chao.xie@marvell.com>

init the variable "mode" to NULL to ensure the later NULL checking is
taking effect.

Signed-off-by: Chao Xie <xiechao.mail@gmail.com>
---
 arch/arm/mm/cache-tauros2.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mm/cache-tauros2.c b/arch/arm/mm/cache-tauros2.c
index 23a7643..97e2ac8 100644
--- a/arch/arm/mm/cache-tauros2.c
+++ b/arch/arm/mm/cache-tauros2.c
@@ -192,7 +192,7 @@ static inline void __init write_actlr(u32 actlr)
 void __init tauros2_init(void)
 {
 	extern int processor_id;
-	char *mode;
+	char *mode = NULL;
 
 	disable_l2_prefetch();
 
-- 
1.7.0.4
