From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Mon,  4 Aug 2014 10:46:26 +0200
Subject: [GIT PULL 09/51] arm64: boot protocol documentation update for GICv3
In-Reply-To: <1407142028-31105-1-git-send-email-christoffer.dall@linaro.org>
References: <1407142028-31105-1-git-send-email-christoffer.dall@linaro.org>
Message-ID: <1407142028-31105-10-git-send-email-christoffer.dall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marc Zyngier <marc.zyngier@arm.com>

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
