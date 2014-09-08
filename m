From: daniel.thompson@linaro.org (Daniel Thompson)
Date: Mon,  8 Sep 2014 16:28:34 +0100
Subject: [PATCH v3 4/5] arm64: Introduce dummy version of asm/fiq.h
In-Reply-To: <1410190115-32604-1-git-send-email-daniel.thompson@linaro.org>
References: <1409931198-22600-1-git-send-email-daniel.thompson@linaro.org>
 <1410190115-32604-1-git-send-email-daniel.thompson@linaro.org>
Message-ID: <1410190115-32604-5-git-send-email-daniel.thompson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Drivers that are shared between arm and arm64 and which employ
FIQ on arm cannot include asm/fiq.h without #ifdef'ing. This patch
introduces a dummy version of asm/fiq.h to arm64 to avoid this.

Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/include/asm/fiq.h | 8 ++++++++
 1 file changed, 8 insertions(+)
 create mode 100644 arch/arm64/include/asm/fiq.h

diff --git a/arch/arm64/include/asm/fiq.h b/arch/arm64/include/asm/fiq.h
new file mode 100644
index 0000000..d3776b8
--- /dev/null
+++ b/arch/arm64/include/asm/fiq.h
@@ -0,0 +1,8 @@
+/*
+ * Placeholder to reduce #ifdef'ing in shared arm/arm64 drivers. It
+ * allows code of the following form to be made unconditional.
+ *
+ * #ifdef CONFIG_FIQ
+ * #include <asm/fiq.h>
+ * #endif
+ */
-- 
1.9.3
