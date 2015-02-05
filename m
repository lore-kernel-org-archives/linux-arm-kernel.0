From: ddutile@redhat.com (Donald Dutile)
Date: Thu,  5 Feb 2015 12:30:27 -0500
Subject: [PATCH] arm64: Change 'Call trace' to 'Call Trace' for tool scanners
Message-ID: <1423157427-41997-1-git-send-email-ddutile@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Receiving reports from service folks that arm64 uses
'Call trace' when dumping stack, instead of the more familiar
'Call Trace'; the former is not being seen by tools that
scan for the latter text.  Checking various arches,
it appears the mainstream server arches (ia64, mips, ppc,
s390, sparc, x86) use 'Call Trace'.
This kernel tools script scans for the latter text string as well
  tools/testing/selftests/rcutorture/bin/parse-console.sh
so it doesn't appear to be arch or vendor specific.

Expecting there aren't a significant number of arm64 dump
scanners matching on 'Call trace' so recommend making this change
now to minimize changes to dump scanning tools for arm64 servers.

Signed-off-by: Donald Dutile <ddutile@redhat.com>
---
 arch/arm64/kernel/traps.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
index 0a801e3..832e721 100644
--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -155,7 +155,7 @@ static void dump_backtrace(struct pt_regs *regs, struct task_struct *tsk)
 		frame.pc = thread_saved_pc(tsk);
 	}
 
-	pr_emerg("Call trace:\n");
+	pr_emerg("Call Trace:\n");
 	while (1) {
 		unsigned long where = frame.pc;
 		int ret;
-- 
1.7.10.2.552.gaa3bb87
