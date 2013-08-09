From: muelli@cryptobitch.de (Tobias Mueller)
Date: Fri,  9 Aug 2013 17:43:59 +0200
Subject: [PATCH v2] arm: Fix is_gate_vma to have a == instead of a single =
In-Reply-To: <1376048361-25836-1-git-send-email-muelli@cryptobitch.de>
References: <1376048361-25836-1-git-send-email-muelli@cryptobitch.de>
Message-ID: <1376063039-30544-1-git-send-email-muelli@cryptobitch.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A typo was introduced when merging the "security-fixes" branch which made the
comparison an assignment.

Signed-off-by: Tobias Mueller <muelli@cryptobitch.de>
---
In the previous version I forgot the Signed-off-by header
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
