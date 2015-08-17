From: petr.cvek@tul.cz (Petr Cvek)
Date: Mon, 17 Aug 2015 23:56:16 +0200
Subject: [PATCH v2 01/21] ARM: pxa: magician: Fix Kconfig for magician to
 always include htc-egpio
In-Reply-To: <cover.1439843482.git.petr.cvek@tul.cz>
References: <cover.1439843482.git.petr.cvek@tul.cz>
Message-ID: <55D25880.3030507@tul.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The htc-egpio driver should be always included in the kernel as it
controls MMC/charging/IrDA power, which is the only way to get
an useful rootfs.

Signed-off-by: Petr Cvek <petr.cvek@tul.cz>
---
 arch/arm/mach-pxa/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-pxa/Kconfig b/arch/arm/mach-pxa/Kconfig
index f096836..5c7b6ee 100644
--- a/arch/arm/mach-pxa/Kconfig
+++ b/arch/arm/mach-pxa/Kconfig
@@ -294,6 +294,7 @@ config MACH_MAGICIAN
 	bool "Enable HTC Magician Support"
 	select IWMMXT
 	select PXA27x
+	select HTC_EGPIO
 
 config MACH_MIOA701
 	bool "Mitac Mio A701 Support"
-- 
1.7.12.1
