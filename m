From: will.deacon@arm.com (Will Deacon)
Date: Mon,  6 Jun 2011 17:55:49 +0100
Subject: [PATCH 05/11] ARM: proc: reorder macro parameters for __v7_proc macro
In-Reply-To: <1307379355-13802-1-git-send-email-will.deacon@arm.com>
References: <1307379355-13802-1-git-send-email-will.deacon@arm.com>
Message-ID: <1307379355-13802-6-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The __v7_proc macro takes paramaters for mmu flags, io flags and hwcaps.

Since hwcaps tend to change more often between cores than the other
parameters, change the ordering so we don't have to provide empty values
for the flag arguments in the common case.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/mm/proc-v7.S |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mm/proc-v7.S b/arch/arm/mm/proc-v7.S
index 7f482c2..b22d98d 100644
--- a/arch/arm/mm/proc-v7.S
+++ b/arch/arm/mm/proc-v7.S
@@ -440,7 +440,7 @@ cpu_elf_name:
 	/*
 	 * Standard v7 proc info content
 	 */
-.macro __v7_proc initfunc, mm_mmuflags = 0, io_mmuflags = 0, hwcaps = 0
+.macro __v7_proc initfunc, hwcaps = 0, mm_mmuflags = 0, io_mmuflags = 0
 	ALT_SMP(.long	PMD_TYPE_SECT | PMD_SECT_AP_WRITE | PMD_SECT_AP_READ | \
 			PMD_FLAGS_SMP | \mm_mmuflags)
 	ALT_UP(.long	PMD_TYPE_SECT | PMD_SECT_AP_WRITE | PMD_SECT_AP_READ | \
-- 
1.7.0.4
