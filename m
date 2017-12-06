From: will.deacon@arm.com (Will Deacon)
Date: Wed,  6 Dec 2017 12:35:21 +0000
Subject: [PATCH v3 02/20] arm64: mm: Temporarily disable ARM64_SW_TTBR0_PAN
In-Reply-To: <1512563739-25239-1-git-send-email-will.deacon@arm.com>
References: <1512563739-25239-1-git-send-email-will.deacon@arm.com>
Message-ID: <1512563739-25239-3-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We're about to rework the way ASIDs are allocated, switch_mm is
implemented and low-level kernel entry/exit is handled, so keep the
ARM64_SW_TTBR0_PAN code out of the way whilst we do the heavy lifting.

It will be re-enabled in a subsequent patch.

Reviewed-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index a93339f5178f..7e7d7fd152c4 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -910,6 +910,7 @@ endif
 
 config ARM64_SW_TTBR0_PAN
 	bool "Emulate Privileged Access Never using TTBR0_EL1 switching"
+	depends on BROKEN       # Temporary while switch_mm is reworked
 	help
 	  Enabling this option prevents the kernel from accessing
 	  user-space memory directly by pointing TTBR0_EL1 to a reserved
-- 
2.1.4
