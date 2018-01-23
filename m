From: luisbg@kernel.org (Luis de Bethencourt)
Date: Tue, 23 Jan 2018 15:06:06 +0000
Subject: [PATCH] arm64: ptrace: Fix trailing semicolon
Message-ID: <20180123150606.15601-1-luisbg@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The trailing semicolon is an empty statement that does no operation.
Removing it since it doesn't do anything.

Signed-off-by: Luis de Bethencourt <luisbg@kernel.org>
---

Hi,

After fixing the same thing in drivers/staging/rtl8723bs/, Joe Perches
suggested I fix it treewide [0].

Best regards 
Luis


[0] http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/2018-January/115410.html
[1] http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/2018-January/115390.html

 arch/arm64/kernel/ptrace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
index 7c44658b316d..609f93557180 100644
--- a/arch/arm64/kernel/ptrace.c
+++ b/arch/arm64/kernel/ptrace.c
@@ -1419,7 +1419,7 @@ static int compat_ptrace_hbp_get(unsigned int note_type,
 	u64 addr = 0;
 	u32 ctrl = 0;
 
-	int err, idx = compat_ptrace_hbp_num_to_idx(num);;
+	int err, idx = compat_ptrace_hbp_num_to_idx(num);
 
 	if (num & 1) {
 		err = ptrace_hbp_get_addr(note_type, tsk, idx, &addr);
-- 
2.15.1
