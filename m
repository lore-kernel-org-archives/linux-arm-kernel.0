From: alexander.stein@systec-electronic.com (Alexander Stein)
Date: Tue, 14 Oct 2014 10:59:29 +0200
Subject: [PATCH 2/2] ARM64: Add printf annotation to early_print
In-Reply-To: <1413277169-6941-1-git-send-email-alexander.stein@systec-electronic.com>
References: <1413277169-6941-1-git-send-email-alexander.stein@systec-electronic.com>
Message-ID: <1413277169-6941-2-git-send-email-alexander.stein@systec-electronic.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds the printf format annotation to early_print to warn users about
incompatible formats and argument.

Signed-off-by: Alexander Stein <alexander.stein@systec-electronic.com>
---
 arch/arm64/kernel/setup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
index edb146d..bbf633b 100644
--- a/arch/arm64/kernel/setup.c
+++ b/arch/arm64/kernel/setup.c
@@ -102,7 +102,7 @@ static struct resource mem_res[] = {
 #define kernel_code mem_res[0]
 #define kernel_data mem_res[1]
 
-void __init early_print(const char *str, ...)
+void __init __printf(1, 2) early_print(const char *str, ...)
 {
 	char buf[256];
 	va_list ap;
-- 
2.0.4
