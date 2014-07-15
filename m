From: ijc@hellion.org.uk (Ian Campbell)
Date: Tue, 15 Jul 2014 08:38:08 +0100
Subject: [PATCH] arm64: Align the kbuild output for VDSOL and VDSOA
Message-ID: <1405409888-791-1-git-send-email-ijc@hellion.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Ian Campbell <ijc@hellion.org.uk>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Michal Marek <mmarek@suse.cz>
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-kbuild at vger.kernel.org
---
 arch/arm64/kernel/vdso/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/vdso/Makefile b/arch/arm64/kernel/vdso/Makefile
index 6d20b7d..84b9426 100644
--- a/arch/arm64/kernel/vdso/Makefile
+++ b/arch/arm64/kernel/vdso/Makefile
@@ -47,9 +47,9 @@ $(obj-vdso): %.o: %.S
 	$(call if_changed_dep,vdsoas)
 
 # Actual build commands
-quiet_cmd_vdsold = VDSOL $@
+quiet_cmd_vdsold = VDSOL   $@
       cmd_vdsold = $(CC) $(c_flags) -Wl,-n -Wl,-T $^ -o $@
-quiet_cmd_vdsoas = VDSOA $@
+quiet_cmd_vdsoas = VDSOA   $@
       cmd_vdsoas = $(CC) $(a_flags) -c -o $@ $<
 
 # Install commands for the unstripped file
-- 
2.0.1
