From: will.deacon@arm.com (Will Deacon)
Date: Fri, 17 Nov 2017 18:21:45 +0000
Subject: [PATCH 02/18] arm64: mm: Temporarily disable ARM64_SW_TTBR0_PAN
In-Reply-To: <1510942921-12564-1-git-send-email-will.deacon@arm.com>
References: <1510942921-12564-1-git-send-email-will.deacon@arm.com>
Message-ID: <1510942921-12564-3-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We're about to rework the way ASIDs are allocated, switch_mm is
implemented and low-level kernel entry/exit is handled, so keep the
ARM64_SW_TTBR0_PAN code out of the way whilst we do the heavy lifting.

It will be re-enabled in a subsequent patch.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 0df64a6a56d4..582bbd77c390 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -872,6 +872,7 @@ endif
 
 config ARM64_SW_TTBR0_PAN
 	bool "Emulate Privileged Access Never using TTBR0_EL1 switching"
+	depends on BROKEN       # Temporary while switch_mm is reworked
 	help
 	  Enabling this option prevents the kernel from accessing
 	  user-space memory directly by pointing TTBR0_EL1 to a reserved
-- 
2.1.4
