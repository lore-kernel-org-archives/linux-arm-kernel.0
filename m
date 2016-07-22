From: sudeep.holla@arm.com (Sudeep Holla)
Date: Fri, 22 Jul 2016 15:42:07 +0100
Subject: [PATCH] arm64: Kconfig: select ALPINE_MSI only if PCI is selected
Message-ID: <1469198527-12525-1-git-send-email-sudeep.holla@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Even when PCI is disabled, ARCH_ALPINE selects ALPINE_MSI triggerring
the following config warning:

warning: (ARCH_ALPINE) selects ALPINE_MSI which has unmet direct dependencies (PCI)

This patch makes selection of ALPINE_MSI conditional on PCI.

Cc: Antoine Tenart <antoine.tenart@free-electrons.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 arch/arm64/Kconfig.platforms | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Hi Arnd,

I happened to end up with a config without PCI when switching between
DT and ACPI and saw the config warnings. This is against today's next,
not sure if you have some fix already queued. Also I am not sure if
ALPINE_MSI is must for this platform to boot in which case it needs to
select PCI.

Regards,
Sudeep

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index bb2616b16157..fd3ee3a392be 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -8,7 +8,7 @@ config ARCH_SUNXI

 config ARCH_ALPINE
 	bool "Annapurna Labs Alpine platform"
-	select ALPINE_MSI
+	select ALPINE_MSI if PCI
 	help
 	  This enables support for the Annapurna Labs Alpine
 	  Soc family.
--
2.7.4
