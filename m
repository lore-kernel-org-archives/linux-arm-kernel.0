From: muelli@cryptobitch.de (Tobias Mueller)
Date: Fri,  9 Aug 2013 13:39:21 +0200
Subject: [PATCH] arm: Fix is_gate_vma to have a == instead of a single =
Message-ID: <1376048361-25836-1-git-send-email-muelli@cryptobitch.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A typo was introduced when merging the "security-fixes" branch which made the
comparison an assignment.
---
 arch/arm/kernel/process.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/kernel/process.c b/arch/arm/kernel/process.c
index 536c85f..94f6b05 100644
--- a/arch/arm/kernel/process.c
+++ b/arch/arm/kernel/process.c
@@ -462,7 +462,7 @@ int in_gate_area_no_mm(unsigned long addr)
 {
 	return in_gate_area(NULL, addr);
 }
-#define is_gate_vma(vma)	((vma) = &gate_vma)
+#define is_gate_vma(vma)	((vma) == &gate_vma)
 #else
 #define is_gate_vma(vma)	0
 #endif
-- 
1.7.8.6
