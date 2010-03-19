From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri, 19 Mar 2010 11:28:41 +0100
Subject: [PATCH 1/5] i.MX51 Babbage: Add uncompress output
In-Reply-To: <1268994525-32495-1-git-send-email-s.hauer@pengutronix.de>
References: <1268994525-32495-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1268994525-32495-2-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm/plat-mxc/include/mach/uncompress.h |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-mxc/include/mach/uncompress.h b/arch/arm/plat-mxc/include/mach/uncompress.h
index 52e476a..b6d3d0f 100644
--- a/arch/arm/plat-mxc/include/mach/uncompress.h
+++ b/arch/arm/plat-mxc/include/mach/uncompress.h
@@ -66,6 +66,7 @@ static inline void flush(void)
 #define MX2X_UART1_BASE_ADDR	0x1000a000
 #define MX3X_UART1_BASE_ADDR	0x43F90000
 #define MX3X_UART2_BASE_ADDR	0x43F94000
+#define MX51_UART1_BASE_ADDR	0x73fbc000
 
 static __inline__ void __arch_decomp_setup(unsigned long arch_id)
 {
@@ -101,6 +102,9 @@ static __inline__ void __arch_decomp_setup(unsigned long arch_id)
 	case MACH_TYPE_MAGX_ZN5:
 		uart_base = MX3X_UART2_BASE_ADDR;
 		break;
+	case MACH_TYPE_MX51_BABBAGE:
+		uart_base = MX51_UART1_BASE_ADDR;
+		break;
 	default:
 		break;
 	}
-- 
1.7.0
