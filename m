From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 14 May 2013 15:14:00 +0100
Subject: [PATCH v4 32/32] arm64: KVM: document kernel object mappings in HYP
In-Reply-To: <1368540840-26750-1-git-send-email-marc.zyngier@arm.com>
References: <1368540840-26750-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1368540840-26750-33-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

HYP mode has access to some of the kernel pages. Document the
memory mapping and the offset between kernel VA and HYP VA.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 Documentation/arm64/memory.txt | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/arm64/memory.txt b/Documentation/arm64/memory.txt
index 5f583af..78a37712 100644
--- a/Documentation/arm64/memory.txt
+++ b/Documentation/arm64/memory.txt
@@ -73,3 +73,10 @@ Translation table lookup with 64KB pages:
  |                 |    +--------------------------> [41:29] L2 index (only 38:29 used)
  |                 +-------------------------------> [47:42] L1 index (not used)
  +-------------------------------------------------> [63] TTBR0/1
+
+When using KVM, the hypervisor maps kernel pages in EL2, at a fixed
+offset from the kernel VA (top 24bits of the kernel VA set to zero):
+
+Start			End			Size		Use
+-----------------------------------------------------------------------
+0000004000000000	0000007fffffffff	 256GB		kernel objects mapped in HYP
-- 
1.8.2.3
