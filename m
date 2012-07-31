From: xiechao.mail@gmail.com (Chao Xie)
Date: Tue, 31 Jul 2012 14:13:13 +0800
Subject: [PATCH 6/7] arm: mmp&dove: modify tauros2_init call
In-Reply-To: <1343715194-25900-1-git-send-email-xiechao.mail@gmail.com>
References: <1343715194-25900-1-git-send-email-xiechao.mail@gmail.com>
Message-ID: <1343715194-25900-6-git-send-email-xiechao.mail@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Chao Xie <chao.xie@marvell.com>

The tauros2_init has argument, change the calling of tauros2_init
to support argument.

Signed-off-by: Chao Xie <xiechao.mail@gmail.com>
---
 arch/arm/mach-dove/common.c |    2 +-
 arch/arm/mach-mmp/mmp2.c    |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-dove/common.c b/arch/arm/mach-dove/common.c
index 9493076..aeca4e9 100644
--- a/arch/arm/mach-dove/common.c
+++ b/arch/arm/mach-dove/common.c
@@ -288,7 +288,7 @@ void __init dove_init(void)
 	printk(KERN_INFO "TCLK = %dMHz\n", (get_tclk() + 499999) / 1000000);
 
 #ifdef CONFIG_CACHE_TAUROS2
-	tauros2_init();
+	tauros2_init(0);
 #endif
 	dove_setup_cpu_mbus();
 
diff --git a/arch/arm/mach-mmp/mmp2.c b/arch/arm/mach-mmp/mmp2.c
index c709a24..c2bb95c 100644
--- a/arch/arm/mach-mmp/mmp2.c
+++ b/arch/arm/mach-mmp/mmp2.c
@@ -163,7 +163,7 @@ static int __init mmp2_init(void)
 {
 	if (cpu_is_mmp2()) {
 #ifdef CONFIG_CACHE_TAUROS2
-		tauros2_init();
+		tauros2_init(0);
 #endif
 		mfp_init_base(MFPR_VIRT_BASE);
 		mfp_init_addr(mmp2_addr_map);
-- 
1.7.0.4
