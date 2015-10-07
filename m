From: jeremy.linton@arm.com (Jeremy Linton)
Date: Wed,  7 Oct 2015 12:00:24 -0500
Subject: [PATCH 6/7] arm64: Add a kernel Kconfig option to enable contiguous
 PTE marking
In-Reply-To: <1444237225-13802-1-git-send-email-jeremy.linton@arm.com>
References: <1444237225-13802-1-git-send-email-jeremy.linton@arm.com>
Message-ID: <1444237225-13802-7-git-send-email-jeremy.linton@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add ARM64_CONT_PTE, so that the contiguous PTE marking
in the kernel's linear mapping may be turned off.
In general this should not be necessary, but it can
help sanity check that the code/hardware is working properly.

Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
---
 arch/arm64/Kconfig | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 07d1811..9485c14 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -400,6 +400,13 @@ config ARM64_VA_BITS
 	default 42 if ARM64_VA_BITS_42
 	default 48 if ARM64_VA_BITS_48
 
+config ARM64_CONT_PTE
+	bool "Use contiguous page hint for kernel linear mapping"
+	default y
+	help
+          Marking kernel pages contiguous can reduce TLB pressure for
+	  certain workloads. If unsure, say Y.
+
 config CPU_BIG_ENDIAN
        bool "Build big-endian kernel"
        help
-- 
2.4.3
