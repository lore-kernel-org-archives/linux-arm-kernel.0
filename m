From: samitolvanen@google.com (Sami Tolvanen)
Date: Wed, 15 Nov 2017 13:34:27 -0800
Subject: [PATCH v2 17/18] arm64: disable RANDOMIZE_MODULE_REGION_FULL with
 LTO_CLANG
In-Reply-To: <20171115213428.22559-1-samitolvanen@google.com>
References: <20171115213428.22559-1-samitolvanen@google.com>
Message-ID: <20171115213428.22559-18-samitolvanen@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

RANDOMIZE_MODULE_REGION_FULL results in "overflow in relocation type 275"
when loading a module linked with GNU gold. As a workaround, disable when
LTO_CLANG is selected.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 arch/arm64/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index ba6aab55d464..3a70f763e18a 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1064,7 +1064,7 @@ config RANDOMIZE_BASE
 
 config RANDOMIZE_MODULE_REGION_FULL
 	bool "Randomize the module region independently from the core kernel"
-	depends on RANDOMIZE_BASE
+	depends on RANDOMIZE_BASE && !LTO_CLANG
 	default y
 	help
 	  Randomizes the location of the module region without considering the
-- 
2.15.0.448.gf294e3d99a-goog
