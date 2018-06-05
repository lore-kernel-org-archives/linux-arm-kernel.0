From: sudeep.holla@arm.com (Sudeep Holla)
Date: Tue,  5 Jun 2018 15:35:04 +0100
Subject: [PATCH v2 3/3] arm64: disable ACPI PPTT support temporarily
In-Reply-To: <1528209304-3280-1-git-send-email-sudeep.holla@arm.com>
References: <1528209304-3280-1-git-send-email-sudeep.holla@arm.com>
Message-ID: <1528209304-3280-3-git-send-email-sudeep.holla@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently, ARM64 doesn't support updating the CPU topology masks on
CPU hotplug operations. ACPI PPTT support rely on that missing feature
which is technically not incorrect. Instead of reverting all the PPTT
support, let's keep it simple and disable ACPI PPTT support on ARM64
for time-being until the topology updates are added for CPU hotplug
operations.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 arch/arm64/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 9fd4a8ccce07..98a5c78a80f9 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -7,7 +7,6 @@ config ARM64
 	select ACPI_REDUCED_HARDWARE_ONLY if ACPI
 	select ACPI_MCFG if ACPI
 	select ACPI_SPCR_TABLE if ACPI
-	select ACPI_PPTT if ACPI
 	select ARCH_CLOCKSOURCE_DATA
 	select ARCH_HAS_DEBUG_VIRTUAL
 	select ARCH_HAS_DEVMEM_IS_ALLOWED
-- 
2.7.4
