From: icenowy@aosc.xyz (Icenowy Zheng)
Date: Wed,  8 Feb 2017 02:30:40 +0800
Subject: [PATCH v4 7/9] ASoC: sunxi: allow the analog codec driver to be built
 on ARM64
In-Reply-To: <20170207183042.62699-1-icenowy@aosc.xyz>
References: <20170207183042.62699-1-icenowy@aosc.xyz>
Message-ID: <20170207183042.62699-8-icenowy@aosc.xyz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As the 64-bit Allwinner H5 SoC has the same analog codec part (also the
same digital part) as H3, enable the driver to be built on ARM64
Allwinner platform, so that it can be used on H5.

Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>
Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>
Acked-by: Chen-Yu Tsai <wens@csie.org>
---
 sound/soc/sunxi/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/sunxi/Kconfig b/sound/soc/sunxi/Kconfig
index 6c344e16aca4..49b71719c9b9 100644
--- a/sound/soc/sunxi/Kconfig
+++ b/sound/soc/sunxi/Kconfig
@@ -11,7 +11,7 @@ config SND_SUN4I_CODEC
 
 config SND_SUN8I_CODEC_ANALOG
 	tristate "Allwinner sun8i Codec Analog Controls Support"
-	depends on MACH_SUN8I || COMPILE_TEST
+	depends on MACH_SUN8I || (ARM64 && ARCH_SUNXI) || COMPILE_TEST
 	select REGMAP
 	help
 	  Say Y or M if you want to add support for the analog controls for
-- 
2.11.0
