From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Tue, 05 Jul 2011 22:47:34 -0400
Subject: [PATCH 49/52] ARM: vexpress: convert boot_params to atag_offset
In-Reply-To: <1309920457-21913-1-git-send-email-nicolas.pitre@linaro.org>
References: <1309920457-21913-1-git-send-email-nicolas.pitre@linaro.org>
Message-ID: <1309920457-21913-49-git-send-email-nicolas.pitre@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>
---
 arch/arm/mach-vexpress/v2m.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-vexpress/v2m.c b/arch/arm/mach-vexpress/v2m.c
index 9e6b93b..de72058 100644
--- a/arch/arm/mach-vexpress/v2m.c
+++ b/arch/arm/mach-vexpress/v2m.c
@@ -436,7 +436,7 @@ static void __init v2m_init(void)
 }
 
 MACHINE_START(VEXPRESS, "ARM-Versatile Express")
-	.boot_params	= PLAT_PHYS_OFFSET + 0x00000100,
+	.atag_offset	= 0x100,
 	.map_io		= v2m_map_io,
 	.init_early	= v2m_init_early,
 	.init_irq	= v2m_init_irq,
-- 
1.7.4
