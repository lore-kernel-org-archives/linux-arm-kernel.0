From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed, 14 Jun 2017 12:43:55 +0200
Subject: [PATCH v2 2/2] arm64: mm: select CONFIG_ARCH_PROC_KCORE_TEXT
In-Reply-To: <1497437035-11979-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1497437035-11979-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <1497437035-11979-3-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To avoid issues with the /proc/kcore code getting confused about the
kernels block mappings in the VMALLOC region, enable the existing
facility that describes the [_text, _end) interval as a separate
KCORE_TEXT region, which supersedes the KCORE_VMALLOC region that
it intersects with on arm64.

Reported-by: Tan Xiaojun <tanxiaojun@huawei.com>
Tested-by: Tan Xiaojun <tanxiaojun@huawei.com>
Tested-by: Mark Rutland <mark.rutland@arm.com>
Acked-by: Mark Rutland <mark.rutland@arm.com>
Reviewed-by: Laura Abbott <labbott@redhat.com>
Reviewed-by: Jiri Olsa <jolsa@kernel.org>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/Kconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index b2024db225a9..233611abffb2 100644
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
2.7.4
