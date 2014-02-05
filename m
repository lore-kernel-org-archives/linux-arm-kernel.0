From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed,  5 Feb 2014 13:30:35 +0000
Subject: [PATCH 03/18] arm64: boot protocol documentation update for GICv3
In-Reply-To: <1391607050-540-1-git-send-email-marc.zyngier@arm.com>
References: <1391607050-540-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1391607050-540-4-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Linux has some requirements that must be satisfied in order to boot
on a system built with a GICv3.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 Documentation/arm64/booting.txt | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/arm64/booting.txt b/Documentation/arm64/booting.txt
index a9691cc..4a02ebd 100644
--- a/Documentation/arm64/booting.txt
+++ b/Documentation/arm64/booting.txt
@@ -131,6 +131,13 @@ Before jumping into the kernel, the following conditions must be met:
   the kernel image will be entered must be initialised by software at a
   higher exception level to prevent execution in an UNKNOWN state.
 
+  For systems with a GICv3 interrupt controller, it is expected that:
+  - ID_AA64PFR0_EL1.GIC (bits [27:24]) must have the value 0b0001
+  - If EL3 is present, it must program ICC_SRE_EL3.Enable (bit 3) to
+    0b1 and ICC_SRE_EL3.SRE (bit 0) to 0b1.
+  - If the kernel is entered at EL1, EL2 must set ICC_SRE_EL2.Enable
+    (bit 3) to 0b1 and ICC_SRE_EL2.SRE (bit 0) to 0b1.
+
 The requirements described above for CPU mode, caches, MMUs, architected
 timers, coherency and system registers apply to all CPUs.  All CPUs must
 enter the kernel in the same exception level.
-- 
1.8.3.4
