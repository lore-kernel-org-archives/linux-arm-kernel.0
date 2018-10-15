From: anarsoul@gmail.com (Vasily Khoruzhick)
Date: Mon, 15 Oct 2018 09:09:31 -0700
Subject: [PATCH v3 6/9] ASoC: sunxi: allow the sun8i-codec driver to be built
 on ARM64
In-Reply-To: <20181015160934.20948-1-anarsoul@gmail.com>
References: <20181015160934.20948-1-anarsoul@gmail.com>
Message-ID: <20181015160934.20948-7-anarsoul@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Allwinner A64 uses the same digital codec part as in A33, so we need
to build this driver on ARM64 as well.

Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
---
 sound/soc/sunxi/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/sunxi/Kconfig b/sound/soc/sunxi/Kconfig
index 8a055ca1819a..66aad0d3f9c7 100644
--- a/sound/soc/sunxi/Kconfig
+++ b/sound/soc/sunxi/Kconfig
@@ -12,7 +12,7 @@ config SND_SUN4I_CODEC
 config SND_SUN8I_CODEC
 	tristate "Allwinner SUN8I audio codec"
 	depends on OF
-	depends on MACH_SUN8I || COMPILE_TEST
+	depends on MACH_SUN8I || (ARM64 && ARCH_SUNXI) || COMPILE_TEST
 	select REGMAP_MMIO
 	help
 	  This option enables the digital part of the internal audio codec for
-- 
2.19.0
