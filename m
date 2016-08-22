From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 22 Aug 2016 16:49:11 +0200
Subject: [PATCH] ASoC: sunxi: depend on ARCH_SUNXI
In-Reply-To: <20160822121242.18827-1-pbrobinson@gmail.com>
References: <20160822121242.18827-1-pbrobinson@gmail.com>
Message-ID: <2008659.grltYsYuN0@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday, August 22, 2016 1:12:42 PM CEST Peter Robinson wrote:
> Depend on ARCH_SUNXI or COMPILE_TEST as it doesn't make sense to enable
> these if the appropriate SoC they're embedded in isn't enabled.
> 
> Signed-off-by: Peter Robinson <pbrobinson@gmail.com>
> ---
>  sound/soc/sunxi/Kconfig | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/sound/soc/sunxi/Kconfig b/sound/soc/sunxi/Kconfig
> index 2a954bd..a2b62dc5 100644
> --- a/sound/soc/sunxi/Kconfig
> +++ b/sound/soc/sunxi/Kconfig
> @@ -2,6 +2,7 @@ menu "Allwinner SoC Audio support"
>  
>  config SND_SUN4I_CODEC
>         tristate "Allwinner A10 Codec Support"
> +       depends on ARCH_SUNXI || COMPILE_TEST
>         select SND_SOC_GENERIC_DMAENGINE_PCM
>         select REGMAP_MMIO
> 

Makes sense, though I think it's nicer to add the dependency to the entire
menu, so we hide that as well, and don't have to add the line to future
entries:

diff --git a/sound/soc/sunxi/Kconfig b/sound/soc/sunxi/Kconfig
index 2a954bd01fd8..dd2368297fd3 100644
--- a/sound/soc/sunxi/Kconfig
+++ b/sound/soc/sunxi/Kconfig
@@ -1,4 +1,5 @@
 menu "Allwinner SoC Audio support"
+	depends on ARCH_SUNXI || COMPILE_TEST
 
 config SND_SUN4I_CODEC
 	tristate "Allwinner A10 Codec Support"

Either way
Acked-by: Arnd Bergmann <arnd@arndb.de>
