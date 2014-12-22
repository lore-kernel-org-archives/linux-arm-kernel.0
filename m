From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon, 22 Dec 2014 19:08:39 +0000
Subject: [PATCH 5/8] of: fdt: register physmem in early_init_dt_scan_memory()
In-Reply-To: <1419275322-29811-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1419275322-29811-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <1419275322-29811-6-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch changes early_init_dt_scan_memory() so that all memory
covered by DT memory nodes is registered in the 'physmem' memblock
table if CONFIG_HAVE_MEMBLOCK_PHYS_MAP is enabled.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 drivers/of/fdt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index 510074226d57..6e59c2168536 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -894,6 +894,7 @@ int __init early_init_dt_scan_memory(unsigned long node, const char *uname,
 		    (unsigned long long)size);
 
 		early_init_dt_add_memory_arch(base, size);
+		memblock_add_phys(base, size);
 	}
 
 	return 0;
-- 
1.8.3.2
