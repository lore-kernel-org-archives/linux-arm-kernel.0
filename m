From: johlstei@codeaurora.org (Jeff Ohlstein)
Date: Fri, 23 Jul 2010 11:58:02 -0700
Subject: [PATCH 2/3] arm: mm: do not set missing flags on ScorpionMP
In-Reply-To: <1279911483-7039-1-git-send-email-johlstei@codeaurora.org>
References: <1279911483-7039-1-git-send-email-johlstei@codeaurora.org>
Message-ID: <1279911483-7039-3-git-send-email-johlstei@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Steve Muckle <smuckle@codeaurora.org>

ScorpionMP does not have the SMP/nAMP mode and TLB ops
broadcasting bits in the ACTLR.

Signed-off-by: Steve Muckle <smuckle@codeaurora.org>
Signed-off-by: Jeff Ohlstein <johlstei@codeaurora.org>
---
 arch/arm/mm/proc-v7.S |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mm/proc-v7.S b/arch/arm/mm/proc-v7.S
index 7aaf88a..6bddf5d 100644
--- a/arch/arm/mm/proc-v7.S
+++ b/arch/arm/mm/proc-v7.S
@@ -190,7 +190,7 @@ cpu_v7_name:
  *	- cache type register is implemented
  */
 __v7_setup:
-#ifdef CONFIG_SMP
+#if defined(CONFIG_SMP) && !defined(CONFIG_ARCH_MSM_SCORPIONMP)
 	mrc	p15, 0, r0, c1, c0, 1
 	tst	r0, #(1 << 6)			@ SMP/nAMP mode enabled?
 	orreq	r0, r0, #(1 << 6) | (1 << 0)	@ Enable SMP/nAMP mode and
-- 
1.7.1.1
