From: samitolvanen@google.com (Sami Tolvanen)
Date: Thu, 30 Nov 2017 15:39:05 -0800
Subject: [PATCH v2 7/7] arm64: add a workaround for GNU gold with
 ARM64_MODULE_PLTS
In-Reply-To: <20171130233905.130602-1-samitolvanen@google.com>
References: <20171129234442.655-1-samitolvanen@google.com>
 <20171130233905.130602-1-samitolvanen@google.com>
Message-ID: <20171130233905.130602-8-samitolvanen@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

All current versions of GNU gold crash when linking kernel modules
with ARM64_MODULE_PLTS due to a known bug:

  https://sourceware.org/bugzilla/show_bug.cgi?id=14592

To work around the problem, this change removes NOLOAD from .plt
and .init.plt.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/kernel/module.lds | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/module.lds b/arch/arm64/kernel/module.lds
index f7c9781a9d48..eacb5c67f61e 100644
--- a/arch/arm64/kernel/module.lds
+++ b/arch/arm64/kernel/module.lds
@@ -1,4 +1,4 @@
 SECTIONS {
-	.plt (NOLOAD) : { BYTE(0) }
-	.init.plt (NOLOAD) : { BYTE(0) }
+	.plt : { BYTE(0) }
+	.init.plt : { BYTE(0) }
 }
-- 
2.15.0.531.g2ccb3012c9-goog
