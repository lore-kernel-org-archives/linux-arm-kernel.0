From: ynorov@caviumnetworks.com (Yury Norov)
Date: Tue, 1 Sep 2015 17:41:11 +0300
Subject: [PATCH 1/2] arm64: cpufeature.h: resolve hidden header dependencies
In-Reply-To: <1441118472-3513-1-git-send-email-ynorov@caviumnetworks.com>
References: <1441118472-3513-1-git-send-email-ynorov@caviumnetworks.com>
Message-ID: <1441118472-3513-2-git-send-email-ynorov@caviumnetworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Functions implemented in cpufeature.h depend on some headers, but
cpufeature.h does not include them. This may cause build failure if
cpufeature.h user does not include that headers by itself. (Like it
happens in next patch of this series.)

Signed-off-by: Yury Norov <ynorov@caviumnetworks.com>
---
 arch/arm64/include/asm/cpufeature.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
index c104421..20cdc26 100644
--- a/arch/arm64/include/asm/cpufeature.h
+++ b/arch/arm64/include/asm/cpufeature.h
@@ -30,6 +30,11 @@
 
 #ifndef __ASSEMBLY__
 
+#include <linux/bitmap.h>
+#include <linux/log2.h>
+#include <linux/printk.h>
+#include <linux/types.h>
+
 struct arm64_cpu_capabilities {
 	const char *desc;
 	u16 capability;
-- 
2.1.4
