From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Tue, 05 Jul 2011 22:47:29 -0400
Subject: [PATCH 44/52] ARM: mach-tcc8k: convert boot_params to atag_offset
In-Reply-To: <1309920457-21913-1-git-send-email-nicolas.pitre@linaro.org>
References: <1309920457-21913-1-git-send-email-nicolas.pitre@linaro.org>
Message-ID: <1309920457-21913-44-git-send-email-nicolas.pitre@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>
---
 arch/arm/mach-tcc8k/board-tcc8000-sdk.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-tcc8k/board-tcc8000-sdk.c b/arch/arm/mach-tcc8k/board-tcc8000-sdk.c
index 4cb3c2d..777a5bb 100644
--- a/arch/arm/mach-tcc8k/board-tcc8000-sdk.c
+++ b/arch/arm/mach-tcc8k/board-tcc8000-sdk.c
@@ -73,7 +73,7 @@ static void __init tcc8k_map_io(void)
 }
 
 MACHINE_START(TCC8000_SDK, "Telechips TCC8000-SDK Demo Board")
-	.boot_params	= PLAT_PHYS_OFFSET + 0x00000100,
+	.atag_offset	= 0x100,
 	.map_io		= tcc8k_map_io,
 	.init_irq	= tcc8k_init_irq,
 	.init_machine	= tcc8k_init,
-- 
1.7.4
