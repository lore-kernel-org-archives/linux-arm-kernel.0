From: ben@decadent.org.uk (Ben Hutchings)
Date: Wed, 09 Mar 2011 00:33:14 +0000
Subject: [PATCH 5/5] arm: Fix .size directives for __arm{7,9}tdmi_proc_info
In-Reply-To: <1299630111.4146.15.camel@localhost>
References: <1299630111.4146.15.camel@localhost>
Message-ID: <1299630794.4146.26.camel@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

gas used to accept (and ignore?) .size directives which referred to
undefined symbols, as these do.  In binutils 2.21 these are treated
as fatal errors.

Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/arm/mm/proc-arm7tdmi.S |    2 +-
 arch/arm/mm/proc-arm9tdmi.S |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mm/proc-arm7tdmi.S b/arch/arm/mm/proc-arm7tdmi.S
index 0c9786d..50f8f7f 100644
--- a/arch/arm/mm/proc-arm7tdmi.S
+++ b/arch/arm/mm/proc-arm7tdmi.S
@@ -143,7 +143,7 @@ __arm7tdmi_proc_info:
 		.long	0
 		.long	0
 		.long	v4_cache_fns
-		.size	__arm7tdmi_proc_info, . - __arm7dmi_proc_info
+		.size	__arm7tdmi_proc_info, . - __arm7tdmi_proc_info
 
 		.type	__triscenda7_proc_info, #object
 __triscenda7_proc_info:
diff --git a/arch/arm/mm/proc-arm9tdmi.S b/arch/arm/mm/proc-arm9tdmi.S
index db67e31..1de9d10 100644
--- a/arch/arm/mm/proc-arm9tdmi.S
+++ b/arch/arm/mm/proc-arm9tdmi.S
@@ -113,7 +113,7 @@ __arm9tdmi_proc_info:
 		.long	0
 		.long	0
 		.long	v4_cache_fns
-		.size	__arm9tdmi_proc_info, . - __arm9dmi_proc_info
+		.size	__arm9tdmi_proc_info, . - __arm9tdmi_proc_info
 
 		.type	__p2001_proc_info, #object
 __p2001_proc_info:
-- 
1.7.4.1
