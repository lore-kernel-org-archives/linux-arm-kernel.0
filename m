From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed,  9 Oct 2013 15:49:48 +0900
Subject: [PATCH 07/14] ARM: shmobile: Introduce r8a7791_add_standard_devices()
In-Reply-To: <cover.1381293239.git.horms+renesas@verge.net.au>
References: <cover.1381293239.git.horms+renesas@verge.net.au>
Message-ID: <4275881fcacae2b1662d64e7989959ef3c33cf52.1381293239.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Introduce the function r8a7791_add_standard_devices() that
follows the same style as other mach-shmobile SoC code and
allows C version of board code to add on-chip devices.

Signed-off-by: Magnus Damm <damm@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/include/mach/r8a7791.h | 1 +
 arch/arm/mach-shmobile/setup-r8a7791.c        | 5 +++++
 2 files changed, 6 insertions(+)

diff --git a/arch/arm/mach-shmobile/include/mach/r8a7791.h b/arch/arm/mach-shmobile/include/mach/r8a7791.h
index 2e6d661..2a86a53 100644
--- a/arch/arm/mach-shmobile/include/mach/r8a7791.h
+++ b/arch/arm/mach-shmobile/include/mach/r8a7791.h
@@ -1,6 +1,7 @@
 #ifndef __ASM_R8A7791_H__
 #define __ASM_R8A7791_H__
 
+void r8a7791_add_standard_devices(void);
 void r8a7791_add_dt_devices(void);
 void r8a7791_clock_init(void);
 void r8a7791_init_early(void);
diff --git a/arch/arm/mach-shmobile/setup-r8a7791.c b/arch/arm/mach-shmobile/setup-r8a7791.c
index b56399d..350dfc4 100644
--- a/arch/arm/mach-shmobile/setup-r8a7791.c
+++ b/arch/arm/mach-shmobile/setup-r8a7791.c
@@ -129,6 +129,11 @@ void __init r8a7791_add_dt_devices(void)
 	r8a7791_register_cmt(00);
 }
 
+void __init r8a7791_add_standard_devices(void)
+{
+	r8a7791_add_dt_devices();
+}
+
 void __init r8a7791_init_early(void)
 {
 #ifndef CONFIG_ARM_ARCH_TIMER
-- 
1.8.4
