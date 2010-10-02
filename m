From: sbkim73@samsung.com (Sangbeom Kim)
Date: Sat,  2 Oct 2010 09:19:57 +0900
Subject: [PATCH] ARM: S5PV210: Fix build error on pm
Message-ID: <1285978797-7964-1-git-send-email-sbkim73@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch fixes build error by S3C2410 PM
Suspend debug option due to undefined address

Signed-off-by: Sangbeom Kim <sbkim73@samsung.com>
---
 arch/arm/mach-s5pv210/include/mach/map.h |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-s5pv210/include/mach/map.h b/arch/arm/mach-s5pv210/include/mach/map.h
index bd9afd5..9722042 100644
--- a/arch/arm/mach-s5pv210/include/mach/map.h
+++ b/arch/arm/mach-s5pv210/include/mach/map.h
@@ -57,6 +57,9 @@
 
 #define S5P_SZ_UART		SZ_256
 
+#define S3C_VA_UARTx(x)		(S3C_VA_UART + (S3C_PA_UART & 0xfffff) \
+				+ ((x) * S3C_UART_OFFSET))
+
 #define S5PV210_PA_SROMC	(0xE8000000)
 
 #define S5PV210_PA_CFCON	(0xE8200000)
-- 
1.6.2.5
