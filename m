From: robherring2@gmail.com (Rob Herring)
Date: Tue,  1 Mar 2011 12:38:06 -0600
Subject: [PATCH] ARM: enable CONFIG_KTIME_SCALAR
Message-ID: <1299004686-9281-1-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

Use straight 64-bit values as 64-bit operations are fairly efficient on ARM.
Comparing the asm output with and without KTIME_SCALAR, using 64-bit math
generates clearly better code.

Comparing kernel/hrtimer.c .text size, it goes from 0x1414 to 0x119c with
this change.

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
---
 arch/arm/Kconfig |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 166efa2..0efbea4 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -63,6 +63,10 @@ config GENERIC_CLOCKEVENTS_BROADCAST
 	depends on GENERIC_CLOCKEVENTS
 	default y if SMP
 
+config KTIME_SCALAR
+	bool
+	default y
+
 config HAVE_TCM
 	bool
 	select GENERIC_ALLOCATOR
-- 
1.7.1
