From: t.dakhran@gmail.com (Tarek Dakhran)
Date: Sun, 17 May 2015 09:42:03 +0300
Subject: [PATCH v1 1/1] ARM: EXYNOS: fix DEBUG_LL on Cortex-A7.
In-Reply-To: <1431844923-4654-1-git-send-email-t.dakhran@gmail.com>
References: <1431844923-4654-1-git-send-email-t.dakhran@gmail.com>
Message-ID: <1431844923-4654-2-git-send-email-t.dakhran@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Cortex-A7 has EXYNOS5_PA_UART base address for UART.
If system boots from Cortex-A7 CPU addruart loads wrong
address. This patch fixex this.

Signed-off-by: Tarek Dakhran <t.dakhran@gmail.com>
---
 arch/arm/include/debug/exynos.S | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/include/debug/exynos.S b/arch/arm/include/debug/exynos.S
index b17fdb7..a61b3ea 100644
--- a/arch/arm/include/debug/exynos.S
+++ b/arch/arm/include/debug/exynos.S
@@ -24,6 +24,7 @@
 		mrc	p15, 0, \tmp, c0, c0, 0
 		and	\tmp, \tmp, #0xf0
 		teq	\tmp, #0xf0		@@ A15
+		teqne	\tmp, #0x70		@@ A7
 		ldreq	\rp, =EXYNOS5_PA_UART
 		movne	\rp, #EXYNOS4_PA_UART	@@ EXYNOS4
 		ldr	\rv, =S3C_VA_UART
-- 
1.9.1
