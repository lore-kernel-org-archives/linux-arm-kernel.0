From: digetx@gmail.com (Dmitry Osipenko)
Date: Fri, 20 Mar 2015 18:36:44 +0300
Subject: [PATCH] ARM: trusted_foundations: Maintain CPU endianness
Message-ID: <1426865807-22981-1-git-send-email-digetx@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Convert CPU reset vector address to LE to support big-endian kernel.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 arch/arm/firmware/trusted_foundations.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/firmware/trusted_foundations.c b/arch/arm/firmware/trusted_foundations.c
index 3fb1b5a..865103a 100644
--- a/arch/arm/firmware/trusted_foundations.c
+++ b/arch/arm/firmware/trusted_foundations.c
@@ -50,7 +50,7 @@ static void __naked tf_generic_smc(u32 type, u32 arg1, u32 arg2)
 
 static int tf_set_cpu_boot_addr(int cpu, unsigned long boot_addr)
 {
-	cpu_boot_addr = boot_addr;
+	cpu_boot_addr = cpu_to_le32(boot_addr);
 	tf_generic_smc(TF_SET_CPU_BOOT_ADDR_SMC, cpu_boot_addr, 0);
 
 	return 0;
-- 
2.3.3
