From: victor.kamensky@linaro.org (Victor Kamensky)
Date: Sat, 13 Sep 2014 12:39:21 -0700
Subject: [PATCH] arm: add missing exports for asm functions required by
 get_user macro
In-Reply-To: <1410637161-4865-1-git-send-email-victor.kamensky@linaro.org>
References: <1410637161-4865-1-git-send-email-victor.kamensky@linaro.org>
Message-ID: <1410637161-4865-2-git-send-email-victor.kamensky@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Previous commits that dealt with get_user for 64bit type missed to
export proper functions, so if get_user macro with particular target/value
types are used by kernel module modpost would produce 'undefined!' error.
Solution is to export all required functions.

Signed-off-by: Victor Kamensky <victor.kamensky@linaro.org>
---
 arch/arm/kernel/armksyms.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/kernel/armksyms.c b/arch/arm/kernel/armksyms.c
index f7b450f..a88671c 100644
--- a/arch/arm/kernel/armksyms.c
+++ b/arch/arm/kernel/armksyms.c
@@ -98,6 +98,14 @@ EXPORT_SYMBOL(__clear_user);
 EXPORT_SYMBOL(__get_user_1);
 EXPORT_SYMBOL(__get_user_2);
 EXPORT_SYMBOL(__get_user_4);
+EXPORT_SYMBOL(__get_user_8);
+
+#ifdef __ARMEB__
+EXPORT_SYMBOL(__get_user_64t_1);
+EXPORT_SYMBOL(__get_user_64t_2);
+EXPORT_SYMBOL(__get_user_64t_4);
+EXPORT_SYMBOL(__get_user_32t_8);
+#endif
 
 EXPORT_SYMBOL(__put_user_1);
 EXPORT_SYMBOL(__put_user_2);
-- 
1.8.1.4
