From: icenowy@aosc.xyz (Icenowy Zheng)
Date: Thu, 26 Jan 2017 23:43:46 +0800
Subject: [PATCH v2 2/7] arm64: allwinner: Kconfig: add essential pinctrl
 driver for H5
In-Reply-To: <20170126154353.55238-1-icenowy@aosc.xyz>
References: <20170126154353.55238-1-icenowy@aosc.xyz>
Message-ID: <20170126154353.55238-2-icenowy@aosc.xyz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

H5 SoC has two pin controllers, one (in user manual called "CPUx") needs
a slightly advanced driver, and the other (called "CPUs") is just equal
to the on in H3, and the H3 driver can be just reused.

Select the two necessary pinctrl drivers when building kernel for
Allwinner SoCs.

Also add H5 in the option's description.

Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>
---
 arch/arm64/Kconfig.platforms | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index 715ef1256838..e11523d204b5 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -5,8 +5,11 @@ config ARCH_SUNXI
 	select GENERIC_IRQ_CHIP
 	select PINCTRL
 	select PINCTRL_SUN50I_A64
+	select PINCTRL_SUN50I_H5
+	select PINCTRL_SUN8I_H3_R
 	help
-	  This enables support for Allwinner sunxi based SoCs like the A64.
+	  This enables support for Allwinner sunxi based SoCs like the A64
+	  and H5.
 
 config ARCH_ALPINE
 	bool "Annapurna Labs Alpine platform"
-- 
2.11.0
