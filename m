From: yang.shi@linaro.org (Yang Shi)
Date: Mon,  9 Nov 2015 09:43:57 -0800
Subject: [PATCH 2/2] arm64: force to select FRAME_POINTER
In-Reply-To: <1447091037-11434-1-git-send-email-yang.shi@linaro.org>
References: <1447091037-11434-1-git-send-email-yang.shi@linaro.org>
Message-ID: <1447091037-11434-3-git-send-email-yang.shi@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ARM64 depends on frame pointer to get correct stack backtrace and need
FRAME_POINTER kconfig option enabled all the time.
However, currect implementation makes it could be disabled, so force it
to be selected by ARM64.

Signed-off-by: Yang Shi <yang.shi@linaro.org>
---
 arch/arm64/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 440d906..b554da2 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -27,6 +27,7 @@ config ARM64
 	select CPU_PM if (SUSPEND || CPU_IDLE)
 	select DCACHE_WORD_ACCESS
 	select EDAC_SUPPORT
+	select FRAME_POINTER
 	select GENERIC_ALLOCATOR
 	select GENERIC_CLOCKEVENTS
 	select GENERIC_CLOCKEVENTS_BROADCAST
-- 
2.0.2
