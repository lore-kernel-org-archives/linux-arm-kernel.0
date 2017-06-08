From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Thu,  8 Jun 2017 19:41:39 +0000
Subject: [PATCH 2/2] arm64: mm: select CONFIG_ARCH_PROC_KCORE_TEXT
In-Reply-To: <20170608194139.9250-1-ard.biesheuvel@linaro.org>
References: <20170608194139.9250-1-ard.biesheuvel@linaro.org>
Message-ID: <20170608194139.9250-3-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To avoid issues with the /proc/kcore code getting confused about the
kernels block mappings in the VMALLOC region, enable the existing
facility that describes the [_text, _end) interval as a separate
KCORE_TEXT region, which supersedes the KCORE_VMALLOC region that
it intersects with on arm64.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/Kconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 3dcd7ec69bca..65173b39cfc2 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -244,6 +244,9 @@ config PGTABLE_LEVELS
 config ARCH_SUPPORTS_UPROBES
 	def_bool y
 
+config ARCH_PROC_KCORE_TEXT
+	def_bool y
+
 source "init/Kconfig"
 
 source "kernel/Kconfig.freezer"
-- 
2.9.3
