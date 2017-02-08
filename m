From: icenowy@aosc.xyz (Icenowy Zheng)
Date: Wed,  8 Feb 2017 18:00:05 +0800
Subject: [PATCH 4/8] arm64: allwinner: select A64 R_PIO driver
In-Reply-To: <20170208100009.29362-1-icenowy@aosc.xyz>
References: <20170208100009.29362-1-icenowy@aosc.xyz>
Message-ID: <20170208100009.29362-4-icenowy@aosc.xyz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As the pinctrl drivers of ARM64 Allwinner SoCs do not have a way to
be explicitly enabled, it should be select by the platform option.

Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>
---
 arch/arm64/Kconfig.platforms | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index 715ef1256838..d539ac54a36a 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -5,6 +5,7 @@ config ARCH_SUNXI
 	select GENERIC_IRQ_CHIP
 	select PINCTRL
 	select PINCTRL_SUN50I_A64
+	select PINCTRL_SUN50I_A64_R
 	help
 	  This enables support for Allwinner sunxi based SoCs like the A64.
 
-- 
2.11.0
