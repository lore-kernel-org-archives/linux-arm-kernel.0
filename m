From: sudeep.holla@arm.com (Sudeep Holla)
Date: Wed,  3 Aug 2016 15:29:34 +0100
Subject: [PATCH 2/2] arm64: Kconfig: select HISILICON_IRQ_MBIGEN only if PCI
 is selected
In-Reply-To: <1470234574-19027-1-git-send-email-sudeep.holla@arm.com>
References: <1470234574-19027-1-git-send-email-sudeep.holla@arm.com>
Message-ID: <1470234574-19027-2-git-send-email-sudeep.holla@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Even when PCI is disabled, ARCH_HISI selects HISILICON_IRQ_MBIGEN
triggerring the following config warning:

warning: (ARM64 && HISILICON_IRQ_MBIGEN) selects ARM_GIC_V3_ITS which
	has unmet direct dependencies (PCI && PCI_MSI)

This patch makes selection of HISILICON_IRQ_MBIGEN conditional on PCI.

Cc: Ma Jun <majun258@huawei.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 arch/arm64/Kconfig.platforms | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index b0e6850aa3e4..41d82b327e6a 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -66,7 +66,7 @@ config ARCH_LG1K
 config ARCH_HISI
 	bool "Hisilicon SoC Family"
 	select ARM_TIMER_SP804
-	select HISILICON_IRQ_MBIGEN
+	select HISILICON_IRQ_MBIGEN if PCI
 	help
 	  This enables support for Hisilicon ARMv8 SoC family

--
2.7.4
