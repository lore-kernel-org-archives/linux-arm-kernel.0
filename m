From: ynorov@caviumnetworks.com (Yury Norov)
Date: Fri, 8 Jan 2016 02:34:38 +0300
Subject: [PATCH v6 20/21] arm64:ilp32: change COMPAT_ELF_PLATFORM to report a
 a subplatform for ILP32
In-Reply-To: <1452209679-19445-1-git-send-email-ynorov@caviumnetworks.com>
References: <1452209679-19445-1-git-send-email-ynorov@caviumnetworks.com>
Message-ID: <1452209679-19445-21-git-send-email-ynorov@caviumnetworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Philipp Tomsich <philipp.tomsich@theobroma-systems.com>

To make life for tools (such as gdb) easier when dealing with ILP32 processes,
we report a proper subarchitecture for ILP32 in the ELF auxiliary vectors.

Signed-off-by: Andrew Pinski <Andrew.Pinski@caviumnetworks.com>
Signed-off-by: Philipp Tomsich <philipp.tomsich@theobroma-systems.com>
Signed-off-by: Christoph Muellner <christoph.muellner@theobroma-systems.com>
Signed-off-by: Yury Norov <ynorov@caviumnetworks.com>
Reviewed-by: David Daney <ddaney@caviumnetworks.com>
---
 arch/arm64/include/asm/elf.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/elf.h b/arch/arm64/include/asm/elf.h
index a519233..392301b 100644
--- a/arch/arm64/include/asm/elf.h
+++ b/arch/arm64/include/asm/elf.h
@@ -160,9 +160,9 @@ extern int arch_setup_additional_pages(struct linux_binprm *bprm,
 #ifdef CONFIG_COMPAT
 
 #ifdef __AARCH64EB__
-#define COMPAT_ELF_PLATFORM		("v8b")
+#define COMPAT_ELF_PLATFORM		(is_ilp32_compat_task() ? "aarch64_be:ilp32" : "v8b")
 #else
-#define COMPAT_ELF_PLATFORM		("v8l")
+#define COMPAT_ELF_PLATFORM		(is_ilp32_compat_task() ? "aarch64:ilp32" : "v8l")
 #endif
 
 #define COMPAT_ELF_ET_DYN_BASE		(2 * TASK_SIZE_32 / 3)
-- 
2.5.0
