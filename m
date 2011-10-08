From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 08 Oct 2011 17:15:50 +0200
Subject: [PATCH 1/3] ARM: imx: always select CACHE_L2X0 on i.MX3
In-Reply-To: <109850802.HMOqKGRdrl@wuerfel>
References: <20111004092015.GM31404@pengutronix.de>
	<20111008101322.GH31404@pengutronix.de>
	<109850802.HMOqKGRdrl@wuerfel>
Message-ID: <101401532.609jSdenqo@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The i.MX3 and i.MX35 files unconditionally call the l2x0_init
function, so we should make sure that this is built into the
kernel.

arch/arm/mach-imx/built-in.o: In function `imx3_init_l2x0':
mm-imx3.c:(.text+0x154): undefined reference to `l2x0_init'

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-imx/Kconfig |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index 6c12836..3de9ac9 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -64,6 +64,7 @@ config SOC_IMX31
 	select ARCH_MXC_AUDMUX_V2
 	select ARCH_MX31
 	select MXC_AVIC
+	select CACHE_L2X0
 
 config SOC_IMX35
 	bool
@@ -73,7 +74,7 @@ config SOC_IMX35
 	select HAVE_EPIT
 	select ARCH_MX35
 	select MXC_AVIC
-
+	select CACHE_L2X0
 
 if ARCH_IMX_V4_V5
 
-- 
1.7.5.4
