From: nikolas@gnu.org (Nik Nyby)
Date: Mon,  6 Jul 2015 09:29:10 -0400
Subject: [PATCH] ARM: OMAP: Fix typo in function signature
Message-ID: <1436189350-24338-1-git-send-email-nikolas@gnu.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This fixes a typo where 'flag' is spelled 'falg'.

Signed-off-by: Nik Nyby <nikolas@gnu.org>
---
 arch/arm/mach-omap2/omap-secure.h | 2 +-
 arch/arm/mach-omap2/omap-smc.S    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/omap-secure.h b/arch/arm/mach-omap2/omap-secure.h
index af2851f..1dcb310 100644
--- a/arch/arm/mach-omap2/omap-secure.h
+++ b/arch/arm/mach-omap2/omap-secure.h
@@ -60,7 +60,7 @@
 
 extern u32 omap_secure_dispatcher(u32 idx, u32 flag, u32 nargs,
 				u32 arg1, u32 arg2, u32 arg3, u32 arg4);
-extern u32 omap_smc2(u32 id, u32 falg, u32 pargs);
+extern u32 omap_smc2(u32 id, u32 flag, u32 pargs);
 extern u32 omap_smc3(u32 id, u32 process, u32 flag, u32 pargs);
 extern phys_addr_t omap_secure_ram_mempool_base(void);
 extern int omap_secure_ram_reserve_memblock(void);
diff --git a/arch/arm/mach-omap2/omap-smc.S b/arch/arm/mach-omap2/omap-smc.S
index fd90125..5d2f7e3 100644
--- a/arch/arm/mach-omap2/omap-smc.S
+++ b/arch/arm/mach-omap2/omap-smc.S
@@ -34,7 +34,7 @@ ENTRY(omap_smc1)
 ENDPROC(omap_smc1)
 
 /**
- * u32 omap_smc2(u32 id, u32 falg, u32 pargs)
+ * u32 omap_smc2(u32 id, u32 flag, u32 pargs)
  * Low level common routine for secure HAL and PPA APIs.
  * @id: Application ID of HAL APIs
  * @flag: Flag to indicate the criticality of operation
-- 
2.1.4
