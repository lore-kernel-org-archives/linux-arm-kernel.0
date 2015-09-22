From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon, 21 Sep 2015 17:21:24 -0700
Subject: [PATCH v3 2/6] arm64: override generic version of
 early_init_dt_add_memory_arch()
In-Reply-To: <1442881288-13962-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1442881288-13962-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <1442881288-13962-3-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Override the __weak early_init_dt_add_memory_arch() with our own
version. We need this in a subsequent patch to make the handling of
the memory nodes conditional on whether we are booting via UEFI or
not. Note that for now, all that our version does is invoke the generic
implementation.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/mm/init.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index ad87ce826cce..d88e83ebf60d 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -374,3 +374,8 @@ static int __init keepinitrd_setup(char *__unused)
 
 __setup("keepinitrd", keepinitrd_setup);
 #endif
+
+void __init early_init_dt_add_memory_arch(u64 base, u64 size)
+{
+	early_init_dt_add_memory(base, size);
+}
-- 
1.9.1
