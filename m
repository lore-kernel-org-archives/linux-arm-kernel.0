From: lee.jones@linaro.org (Lee Jones)
Date: Tue,  4 Jun 2013 16:36:47 +0100
Subject: [PATCH 1/2] ARM: ux500: Silence compiler warnings due to missing
 ux500_read_asicid() __init
Message-ID: <1370360208-6500-1-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

WARNING: vmlinux.o(.text.unlikely+0x1e8): Section mismatch in reference from\
 the function ux500_read_asicid() to the function .init.text:iotable_init()
The function ux500_read_asicid() references
the function __init iotable_init().
This is often because ux500_read_asicid lacks a __init

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/mach-ux500/id.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-ux500/id.c b/arch/arm/mach-ux500/id.c
index 0d33d1a..b16e7c1 100644
--- a/arch/arm/mach-ux500/id.c
+++ b/arch/arm/mach-ux500/id.c
@@ -21,7 +21,7 @@
 
 struct dbx500_asic_id dbx500_id;
 
-static unsigned int ux500_read_asicid(phys_addr_t addr)
+static unsigned int __init ux500_read_asicid(phys_addr_t addr)
 {
 	phys_addr_t base = addr & ~0xfff;
 	struct map_desc desc = {
-- 
1.7.10.4
