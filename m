From: baruch@tkos.co.il (Baruch Siach)
Date: Thu, 29 Jan 2015 00:04:11 +0200
Subject: [PATCH v4 2/2] ARM: digicolor: select syscon and timer
In-Reply-To: <8b74c50aebadc781a5aa8061f7639c9164433e84.1422481097.git.baruch@tkos.co.il>
References: <8b74c50aebadc781a5aa8061f7639c9164433e84.1422481097.git.baruch@tkos.co.il>
Message-ID: <2d0359c67f731aab3befa4b3f059cc9fdbcf2ff6.1422481097.git.baruch@tkos.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The digicolor interrupt controller driver now needs syscon.

Also, as per clocksource maintainer request, we now have a separate config
symbol, CONFIG_DIGICOLOR_TIMER, for the digicolor timer.

Signed-off-by: Baruch Siach <baruch@tkos.co.il>
---
v4:
   New patch in this series

 arch/arm/mach-digicolor/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-digicolor/Kconfig b/arch/arm/mach-digicolor/Kconfig
index 5a0669a2738e..4f36d8d2bc57 100644
--- a/arch/arm/mach-digicolor/Kconfig
+++ b/arch/arm/mach-digicolor/Kconfig
@@ -2,4 +2,6 @@ config ARCH_DIGICOLOR
 	bool "Conexant Digicolor SoC Support"
 	depends on ARCH_MULTI_V7
 	select CLKSRC_MMIO
+	select DIGICOLOR_TIMER
 	select GENERIC_IRQ_CHIP
+	select MFD_SYSCON
-- 
2.1.4
