From: steve.capper@arm.com (Steve Capper)
Date: Wed, 29 Aug 2018 13:45:43 +0100
Subject: [PATCH 5/5] arm64: mm: Activate 52-bit userspace VA support
In-Reply-To: <20180829124543.25314-1-steve.capper@arm.com>
References: <20180829124543.25314-1-steve.capper@arm.com>
Message-ID: <20180829124543.25314-6-steve.capper@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We have all the pieces in place now to support a 52-bit userspace VA.
This patch enables this logic for systems running with a 48-bit VA and a
64KB PAGE_SIZE.

Signed-off-by: Steve Capper <steve.capper@arm.com>
---
 arch/arm64/Kconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 29e75b47becd..2561b541c9df 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -691,6 +691,10 @@ config ARM64_PA_BITS_52
 
 endchoice
 
+config ARM64_TRY_52BIT_VA
+	def_bool y
+	depends on ARM64_VA_BITS_48 && ARM64_64K_PAGES
+
 config ARM64_PA_BITS
 	int
 	default 48 if ARM64_PA_BITS_48
-- 
2.11.0
