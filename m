From: mathieu.poirier@linaro.org (mathieu.poirier at linaro.org)
Date: Fri, 25 Mar 2011 09:28:56 -0600
Subject: [PATCH 3/8] ux500: setting proper uart for snowball
In-Reply-To: <1301066941-15877-1-git-send-email-mathieu.poirier@linaro.org>
References: <1301066941-15877-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <1301066941-15877-4-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Mathieu J. Poirier <mathieu.poirier@linaro.org>

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 arch/arm/mach-ux500/include/mach/uncompress.h |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-ux500/include/mach/uncompress.h b/arch/arm/mach-ux500/include/mach/uncompress.h
index ab0fe14..3b4f6b7 100644
--- a/arch/arm/mach-ux500/include/mach/uncompress.h
+++ b/arch/arm/mach-ux500/include/mach/uncompress.h
@@ -54,7 +54,8 @@ static inline void arch_decomp_setup(void)
 	if (machine_is_u8500() ||
 	    machine_is_svp8500v1() ||
 	    machine_is_svp8500v2() ||
-	    machine_is_hrefv60())
+	    machine_is_hrefv60()   ||
+	    machine_is_snowball())
 		ux500_uart_base = U8500_UART2_BASE;
 	else if (machine_is_u5500())
 		ux500_uart_base = U5500_UART0_BASE;
-- 
1.7.1
