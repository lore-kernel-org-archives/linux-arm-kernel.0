From: rrichter@caviumnetworks.com (Robert Richter)
Date: Tue, 9 Feb 2016 14:53:42 +0100
Subject: [PATCH v4 2/6] arm64: override generic version of
 early_init_dt_add_memory_arch()
In-Reply-To: <1455026026-11571-1-git-send-email-rrichter@caviumnetworks.com>
References: <1455026026-11571-1-git-send-email-rrichter@caviumnetworks.com>
Message-ID: <1455026026-11571-3-git-send-email-rrichter@caviumnetworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ard Biesheuvel <ard.biesheuvel@linaro.org>

Override the __weak early_init_dt_add_memory_arch() with our own
version. We need this in a subsequent patch to make the handling of
the memory nodes conditional on whether we are booting via UEFI or
not. Note that for now, all that our version does is invoke the generic
implementation.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Message-Id: <1442881288-13962-3-git-send-email-ard.biesheuvel@linaro.org>
Signed-off-by: Robert Richter <rrichter@cavium.com>
---
 arch/arm64/mm/init.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index f3b061e67bfe..208c1d359018 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -380,3 +380,8 @@ static int __init keepinitrd_setup(char *__unused)
 
 __setup("keepinitrd", keepinitrd_setup);
 #endif
+
+void __init early_init_dt_add_memory_arch(u64 base, u64 size)
+{
+	early_init_dt_add_memory(base, size);
+}
-- 
2.7.0.rc3
