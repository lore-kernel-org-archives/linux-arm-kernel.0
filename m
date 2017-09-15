From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 14 Sep 2017 18:19:15 -0700
Subject: [PATCH] arm64: Unconditionally support ARCH_HAVE_NMI_SAFE_CMPXCHG
Message-ID: <20170915011915.7993-1-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>From what I can see there isn't anything about ACPI_APEI_SEA that
means the arm64 architecture can or cannot support NMI safe
cmpxchg, so the if condition here is not important. Let's remove
it. Doing that allows us to support ftrace histograms via
CONFIG_HIST_TRIGGERS that depends on the arch having this config
selected.

Cc: Tyler Baicar <tbaicar@codeaurora.org>
Cc: Jonathan (Zhixiong) Zhang <zjzhang@codeaurora.org>
Cc: James Morse <james.morse@arm.com>
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 arch/arm64/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 0df64a6a56d4..27ce2ab7b080 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -21,7 +21,7 @@ config ARM64
 	select ARCH_HAS_STRICT_KERNEL_RWX
 	select ARCH_HAS_STRICT_MODULE_RWX
 	select ARCH_HAS_TICK_BROADCAST if GENERIC_CLOCKEVENTS_BROADCAST
-	select ARCH_HAVE_NMI_SAFE_CMPXCHG if ACPI_APEI_SEA
+	select ARCH_HAVE_NMI_SAFE_CMPXCHG
 	select ARCH_USE_CMPXCHG_LOCKREF
 	select ARCH_SUPPORTS_MEMORY_FAILURE
 	select ARCH_SUPPORTS_ATOMIC_RMW
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
