From: will.deacon@arm.com (Will Deacon)
Date: Mon,  6 Jun 2011 17:55:50 +0100
Subject: [PATCH 06/11] ARM: cortex-a5: add HWCAP_VFPv4D16 to proc info
	structure
In-Reply-To: <1307379355-13802-1-git-send-email-will.deacon@arm.com>
References: <1307379355-13802-1-git-send-email-will.deacon@arm.com>
Message-ID: <1307379355-13802-7-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Cortex-A5 implements VFPv4D16, so add this to the hwcaps for this
processor.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/mm/proc-v7.S |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mm/proc-v7.S b/arch/arm/mm/proc-v7.S
index b22d98d..8eba506 100644
--- a/arch/arm/mm/proc-v7.S
+++ b/arch/arm/mm/proc-v7.S
@@ -466,7 +466,7 @@ cpu_elf_name:
 __v7_ca5mp_proc_info:
 	.long	0x410fc050
 	.long	0xff0ffff0
-	__v7_proc __v7_ca5mp_setup
+	__v7_proc __v7_ca5mp_setup, HWCAP_VFPv4D16
 	.size	__v7_ca5mp_proc_info, . - __v7_ca5mp_proc_info
 
 	/*
-- 
1.7.0.4
