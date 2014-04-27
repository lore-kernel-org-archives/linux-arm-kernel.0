From: shc_work@mail.ru (Alexander Shiyan)
Date: Sun, 27 Apr 2014 20:03:26 +0400
Subject: [PATCH] ARM; i.MX: Fix eMMa PrP resource size
Message-ID: <1398614606-30179-1-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Last address for eMMa PrP is 0x80...0x83, so increase resource size
for eMMa to 256.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 arch/arm/mach-imx/devices/platform-mx2-emma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-imx/devices/platform-mx2-emma.c b/arch/arm/mach-imx/devices/platform-mx2-emma.c
index 11bd01d..0dc0651 100644
--- a/arch/arm/mach-imx/devices/platform-mx2-emma.c
+++ b/arch/arm/mach-imx/devices/platform-mx2-emma.c
@@ -12,7 +12,7 @@
 #define imx_mx2_emmaprp_data_entry_single(soc)				\
 	{								\
 		.iobase = soc ## _EMMAPRP_BASE_ADDR,			\
-		.iosize = SZ_32,					\
+		.iosize = SZ_256,					\
 		.irq = soc ## _INT_EMMAPRP,				\
 	}
 
-- 
1.8.3.2
