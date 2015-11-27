From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Fri, 27 Nov 2015 18:27:51 +0000
Subject: [PATCH] arm: renesas: select PINCTRL for Renesas SoC
Message-ID: <1448648871-15008-1-git-send-email-ben.dooks@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If Renesas SoCs are the only devices selected then the
pinctrl core is not selected and the renesas pfc controller
will not get included in the kernel.

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
 arch/arm64/Kconfig.platforms | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index 25a9031..fc3d692 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -72,6 +72,7 @@ config ARCH_SHMOBILE
 config ARCH_RENESAS
 	bool "Renesas SoC Platform"
 	select ARCH_SHMOBILE
+	select PINCTRL	
 	select PM_GENERIC_DOMAINS if PM
 	help
 	  This enables support for the ARMv8 based Renesas SoCs.
-- 
2.6.2
