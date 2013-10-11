From: matthew.leach@arm.com (Matthew Leach)
Date: Fri, 11 Oct 2013 14:52:11 +0100
Subject: [PATCH 05/14] arm64: setup: report ELF_PLATFORM as the machine for
 utsname
In-Reply-To: <1381499540-28794-1-git-send-email-matthew.leach@arm.com>
References: <1381499540-28794-1-git-send-email-matthew.leach@arm.com>
Message-ID: <1381499540-28794-6-git-send-email-matthew.leach@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Will Deacon <will.deacon@arm.com>

uname -m reports the machine field from the current utsname, which should
reflect the endianness of the system.

This patch reports ELF_PLATFORM for the field, so that everything appears
consistent from userspace.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/kernel/setup.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
index 055cfb8..df9ccb3 100644
--- a/arch/arm64/kernel/setup.c
+++ b/arch/arm64/kernel/setup.c
@@ -118,7 +118,7 @@ static void __init setup_processor(void)
 	printk("CPU: %s [%08x] revision %d\n",
 	       cpu_name, read_cpuid_id(), read_cpuid_id() & 15);
 
-	sprintf(init_utsname()->machine, "aarch64");
+	sprintf(init_utsname()->machine, ELF_PLATFORM);
 	elf_hwcap = 0;
 }
 
-- 
1.7.9.5
