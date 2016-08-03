From: sudeep.holla@arm.com (Sudeep Holla)
Date: Wed,  3 Aug 2016 15:29:33 +0100
Subject: [PATCH 1/2] arm64: Kconfig: select ALPINE_MSI only if PCI is selected
Message-ID: <1470234574-19027-1-git-send-email-sudeep.holla@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Even when PCI is disabled, ARCH_ALPINE selects ALPINE_MSI triggerring
the following config warning:

warning: (ARCH_ALPINE) selects ALPINE_MSI which has unmet direct
		dependencies (PCI)

This patch makes selection of ALPINE_MSI conditional on PCI.

Cc: Arnd Bergmann <arnd@arndb.de>
Acked-by: Antoine Tenart <antoine.tenart@free-electrons.com>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 arch/arm64/Kconfig.platforms | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Hi ARM-SoC guys,

I still see this couple of config warnings without PCI with today's next.

Regards,
Sudeep

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index 4fb0bef0f094..b0e6850aa3e4 100644
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
