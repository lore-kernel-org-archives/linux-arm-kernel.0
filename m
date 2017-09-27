From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 27 Sep 2017 08:51:30 -0700
Subject: [PATCH v2] arm64: Unconditionally support
 {ARCH_}HAVE_NMI{_SAFE_CMPXCHG}
Message-ID: <20170927155130.28539-1-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>From what I can see there isn't anything about ACPI_APEI_SEA that
means the arm64 architecture can or cannot support NMI safe
cmpxchg or NMIs, so the 'if' condition here is not important.
Let's remove it. Doing that allows us to support ftrace
histograms via CONFIG_HIST_TRIGGERS that depends on the arch
having the ARCH_HAVE_NMI_SAFE_CMPXCHG config selected.

Cc: Tyler Baicar <tbaicar@codeaurora.org>
Cc: Jonathan (Zhixiong) Zhang <zjzhang@codeaurora.org>
Cc: James Morse <james.morse@arm.com>
Cc: Dongjiu Geng <gengdongjiu@huawei.com>
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---

Changes from v1:
 * Also drop condition from HAVE_NMI (James Morse)

 arch/arm64/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 0df64a6a56d4..0e4cc113b74e 100644
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
@@ -98,7 +98,7 @@ config ARM64
 	select HAVE_IRQ_TIME_ACCOUNTING
 	select HAVE_MEMBLOCK
 	select HAVE_MEMBLOCK_NODE_MAP if NUMA
-	select HAVE_NMI if ACPI_APEI_SEA
+	select HAVE_NMI
 	select HAVE_PATA_PLATFORM
 	select HAVE_PERF_EVENTS
 	select HAVE_PERF_REGS
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
