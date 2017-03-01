From: icenowy@aosc.xyz (Icenowy Zheng)
Date: Thu,  2 Mar 2017 02:01:08 +0800
Subject: [PATCH v2 2/5] arm64: only select PINCTRL for Allwinner platforms
In-Reply-To: <20170301180111.12365-1-icenowy@aosc.xyz>
References: <20170301180111.12365-1-icenowy@aosc.xyz>
Message-ID: <20170301180111.12365-3-icenowy@aosc.xyz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As the pinctrl driver selecting is refactored in Kconfig file of
pinctrl-sunxi, now we can select only PINCTRL for Allwinner platform,
and the default value of several pinctrl drivers useful on ARM64
Allwinner SoCs will become Y.

This is the situation of 32-bit ARM ARCH_SUNXI option.

Drop the select of per-SoC pinctrl choices, but keep selecting PINCTRL.

Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>
---
Changes in v2:
- Do not select PINCTRL_SUNXI, as it will be selected by PINCTRL_SUN50I_*.

 arch/arm64/Kconfig.platforms | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index 129cc5ae4091..ff867b8d7810 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -4,7 +4,6 @@ config ARCH_SUNXI
 	bool "Allwinner sunxi 64-bit SoC Family"
 	select GENERIC_IRQ_CHIP
 	select PINCTRL
-	select PINCTRL_SUN50I_A64
 	help
 	  This enables support for Allwinner sunxi based SoCs like the A64.
 
-- 
2.11.1
