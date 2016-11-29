From: labbott@redhat.com (Laura Abbott)
Date: Tue, 29 Nov 2016 10:55:26 -0800
Subject: [PATCHv4 07/10] kexec: Switch to __pa_symbol
In-Reply-To: <1480445729-27130-1-git-send-email-labbott@redhat.com>
References: <1480445729-27130-1-git-send-email-labbott@redhat.com>
Message-ID: <1480445729-27130-8-git-send-email-labbott@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


__pa_symbol is the correct api to get the physical address of kernel
symbols. Switch to it to allow for better debug checking.

Signed-off-by: Laura Abbott <labbott@redhat.com>
---
Found during review of the kernel. Untested.
---
 kernel/kexec_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index 5616755..e1b625e 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -1397,7 +1397,7 @@ void __weak arch_crash_save_vmcoreinfo(void)
 
 phys_addr_t __weak paddr_vmcoreinfo_note(void)
 {
-	return __pa((unsigned long)(char *)&vmcoreinfo_note);
+	return __pa_symbol((unsigned long)(char *)&vmcoreinfo_note);
 }
 
 static int __init crash_save_vmcoreinfo_init(void)
-- 
2.7.4
