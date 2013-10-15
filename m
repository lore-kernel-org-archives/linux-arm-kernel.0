From: dave.long@linaro.org (David Long)
Date: Tue, 15 Oct 2013 17:04:28 -0400
Subject: [PATCH v2 13/13] ARM: Remove uprobes dependency on kprobes
In-Reply-To: <1381871068-27660-1-git-send-email-dave.long@linaro.org>
References: <1381871068-27660-1-git-send-email-dave.long@linaro.org>
Message-ID: <1381871068-27660-14-git-send-email-dave.long@linaro.org>
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
index 5b2cc2b..5f4b5d1 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -199,7 +199,6 @@ config NEED_DMA_MAP_STATE
        def_bool y
 
 config ARCH_SUPPORTS_UPROBES
-	depends on KPROBES
 	def_bool y
 
 config ARCH_HAS_DMA_SET_COHERENT_MASK
-- 
1.8.1.2
