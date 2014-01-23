From: dave.long@linaro.org (David Long)
Date: Thu, 23 Jan 2014 15:05:59 -0500
Subject: [PATCH v5 16/16] ARM: Remove uprobes dependency on kprobes
In-Reply-To: <1390507559-4697-1-git-send-email-dave.long@linaro.org>
References: <1390507559-4697-1-git-send-email-dave.long@linaro.org>
Message-ID: <1390507559-4697-17-git-send-email-dave.long@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: "David A. Long" <dave.long@linaro.org>

Now that arm uprobes support has been made separate from the arm kprobes code
the Kconfig can be changed to reflect that.

Signed-off-by: David A. Long <dave.long@linaro.org>
---
 arch/arm/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index fec5a6b..9ddc4ae 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -204,7 +204,6 @@ config NEED_DMA_MAP_STATE
        def_bool y
 
 config ARCH_SUPPORTS_UPROBES
-	depends on KPROBES
 	def_bool y
 
 config ARCH_HAS_DMA_SET_COHERENT_MASK
-- 
1.8.1.2
