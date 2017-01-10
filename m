From: labbott@redhat.com (Laura Abbott)
Date: Tue, 10 Jan 2017 13:35:43 -0800
Subject: [PATCHv7 04/11] kexec: Switch to __pa_symbol
In-Reply-To: <1484084150-1523-1-git-send-email-labbott@redhat.com>
References: <1484084150-1523-1-git-send-email-labbott@redhat.com>
Message-ID: <1484084150-1523-5-git-send-email-labbott@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

__pa_symbol is the correct api to get the physical address of kernel
symbols. Switch to it to allow for better debug checking.

Reviewed-by: Mark Rutland <mark.rutland@arm.com>
Tested-by: Mark Rutland <mark.rutland@arm.com>
Acked-by: "Eric W. Biederman" <ebiederm@xmission.com>
Signed-off-by: Laura Abbott <labbott@redhat.com>
---
 kernel/kexec_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index 5617cc4..a01974e 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -1399,7 +1399,7 @@ void __weak arch_crash_save_vmcoreinfo(void)
 
 phys_addr_t __weak paddr_vmcoreinfo_note(void)
 {
-	return __pa((unsigned long)(char *)&vmcoreinfo_note);
+	return __pa_symbol((unsigned long)(char *)&vmcoreinfo_note);
 }
 
 static int __init crash_save_vmcoreinfo_init(void)
-- 
2.7.4
