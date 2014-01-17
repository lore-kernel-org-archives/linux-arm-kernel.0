From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Fri, 17 Jan 2014 20:25:02 +0800
Subject: [PATCH 08/20] ARM64 / ACPI: Select ACPI_REDUCED_HARDWARE_ONLY if ACPI
 is enabled on ARM64
In-Reply-To: <1389961514-13562-1-git-send-email-hanjun.guo@linaro.org>
References: <1389961514-13562-1-git-send-email-hanjun.guo@linaro.org>
Message-ID: <1389961514-13562-9-git-send-email-hanjun.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ACPI reduced hardware mode is disabled by default, but ARM64 can
only run properly in ACPI hardware reduced mode at now, so select
ACPI_REDUCED_HARDWARE_ONLY if ACPI is enabled on ARM64.

Signed-off-by: Al Stone <al.stone@linaro.org>
Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
---
 arch/arm64/Kconfig |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 2b1fb1d..741692c 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1,5 +1,6 @@
 config ARM64
 	def_bool y
+	select ACPI_REDUCED_HARDWARE_ONLY if ACPI
 	select ARCH_HAS_ATOMIC64_DEC_IF_POSITIVE
 	select ARCH_USE_CMPXCHG_LOCKREF
 	select ARCH_WANT_OPTIONAL_GPIOLIB
-- 
1.7.9.5
