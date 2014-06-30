From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 30 Jun 2014 16:01:33 +0100
Subject: [PATCH v6 04/21] arm64: boot protocol documentation update for GICv3
In-Reply-To: <1404140510-5382-1-git-send-email-marc.zyngier@arm.com>
References: <1404140510-5382-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1404140510-5382-5-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Linux has some requirements that must be satisfied in order to boot
on a system built with a GICv3.

Acked-by: Christoffer Dall <christoffer.dall@linaro.org>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 Documentation/arm64/booting.txt | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/arm64/booting.txt b/Documentation/arm64/booting.txt
index 37fc4f6..da1d4bf 100644
--- a/Documentation/arm64/booting.txt
+++ b/Documentation/arm64/booting.txt
@@ -141,6 +141,14 @@ Before jumping into the kernel, the following conditions must be met:
   the kernel image will be entered must be initialised by software at a
   higher exception level to prevent execution in an UNKNOWN state.
 
+  For systems with a GICv3 interrupt controller:
+  - If EL3 is present:
+    ICC_SRE_EL3.Enable (bit 3) must be initialiased to 0b1.
+    ICC_SRE_EL3.SRE (bit 0) must be initialised to 0b1.
+  - If the kernel is entered at EL1:
+    ICC.SRE_EL2.Enable (bit 3) must be initialised to 0b1
+    ICC_SRE_EL2.SRE (bit 0) must be initialised to 0b1.
+
 The requirements described above for CPU mode, caches, MMUs, architected
 timers, coherency and system registers apply to all CPUs.  All CPUs must
 enter the kernel in the same exception level.
-- 
2.0.0
