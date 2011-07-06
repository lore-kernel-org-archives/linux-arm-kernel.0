From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Tue, 05 Jul 2011 22:47:35 -0400
Subject: [PATCH 50/52] ARM: mach-vt8500: convert boot_params to atag_offset
In-Reply-To: <1309920457-21913-1-git-send-email-nicolas.pitre@linaro.org>
References: <1309920457-21913-1-git-send-email-nicolas.pitre@linaro.org>
Message-ID: <1309920457-21913-50-git-send-email-nicolas.pitre@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>
---
 arch/arm/mach-vt8500/bv07.c       |    2 +-
 arch/arm/mach-vt8500/wm8505_7in.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-vt8500/bv07.c b/arch/arm/mach-vt8500/bv07.c
index 94a261d..a464c75 100644
--- a/arch/arm/mach-vt8500/bv07.c
+++ b/arch/arm/mach-vt8500/bv07.c
@@ -68,7 +68,7 @@ void __init bv07_init(void)
 }
 
 MACHINE_START(BV07, "Benign BV07 Mini Netbook")
-	.boot_params	= 0x00000100,
+	.atag_offset	= 0x100,
 	.reserve	= vt8500_reserve_mem,
 	.map_io		= vt8500_map_io,
 	.init_irq	= vt8500_init_irq,
diff --git a/arch/arm/mach-vt8500/wm8505_7in.c b/arch/arm/mach-vt8500/wm8505_7in.c
index e73aadb..cf910a9 100644
--- a/arch/arm/mach-vt8500/wm8505_7in.c
+++ b/arch/arm/mach-vt8500/wm8505_7in.c
@@ -68,7 +68,7 @@ void __init wm8505_7in_init(void)
 }
 
 MACHINE_START(WM8505_7IN_NETBOOK, "WM8505 7-inch generic netbook")
-	.boot_params	= 0x00000100,
+	.atag_offset	= 0x100,
 	.reserve	= wm8505_reserve_mem,
 	.map_io		= wm8505_map_io,
 	.init_irq	= wm8505_init_irq,
-- 
1.7.4
