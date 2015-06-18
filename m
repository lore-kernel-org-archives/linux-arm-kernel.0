From: sudipm.mukherjee@gmail.com (Sudip Mukherjee)
Date: Thu, 18 Jun 2015 17:47:52 +0530
Subject: [PATCH v2 6/7] mn10300: kgdb_arch_set_pc
In-Reply-To: <1434629873-11668-1-git-send-email-sudipm.mukherjee@gmail.com>
References: <1434629873-11668-1-git-send-email-sudipm.mukherjee@gmail.com>
Message-ID: <1434629873-11668-7-git-send-email-sudipm.mukherjee@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

While building it failed with:
undefined reference to `kgdb_arch_set_pc'

Signed-off-by: Sudip Mukherjee <sudip@vectorindia.org>
---
 arch/mn10300/kernel/kgdb.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/mn10300/kernel/kgdb.c b/arch/mn10300/kernel/kgdb.c
index 9977082..8a0ae2b 100644
--- a/arch/mn10300/kernel/kgdb.c
+++ b/arch/mn10300/kernel/kgdb.c
@@ -499,3 +499,8 @@ void kgdb_roundup_cpus(unsigned long flags)
 	smp_jump_to_debugger();
 }
 #endif
+
+void kgdb_arch_set_pc(struct pt_regs *regs, unsigned long ip)
+{
+	regs->pc = ip;
+}
-- 
1.8.1.2
