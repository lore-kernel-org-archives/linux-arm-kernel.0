From: baruch@tkos.co.il (Baruch Siach)
Date: Wed, 27 Jan 2010 05:42:24 +0200
Subject: [PATCH 02/10] ARM: LPC32XX: arch Kconfig, platform Kconfig,
	and makefiles
In-Reply-To: <1264551582.6528.5@usb10132>
References: <1264551582.6528.5@usb10132>
Message-ID: <20100127034223.GB31899@tarshish>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kevin,

On Tue, Jan 26, 2010 at 04:19:42PM -0800, Kevin Wells wrote:
> LPC32xx architecture Kconfig, platform Kconfig, and makefiles
> 
> 
> Signed-off-by: Kevin Wells <kevin.wells@nxp.com>
> ---
>  arch/arm/mach-lpc32xx/Kconfig       |  158
> +++++++++++++++++++++++++++++++++++
>  arch/arm/mach-lpc32xx/Kconfig.plat  |   98 ++++++++++++++++++++++
>  arch/arm/mach-lpc32xx/Makefile      |    9 ++
>  arch/arm/mach-lpc32xx/Makefile.boot |    4 +
>  4 files changed, 269 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-lpc32xx/Kconfig
> b/arch/arm/mach-lpc32xx/Kconfig
> new file mode 100644
> index 0000000..a277885
> --- /dev/null
> +++ b/arch/arm/mach-lpc32xx/Kconfig
> @@ -0,0 +1,158 @@
> +if ARCH_LPC32XX
> +
> +menu "LPC32XX chip options"
> +
> +config ARCH_LPC32XX_IRAM_SIZE
> +	int
> +	default 131072 if ARCH_LPC32XX_20
> +	default 262144 if ARCH_LPC32XX_30 || ARCH_LPC32XX_40 ||
> ARCH_LPC32XX_50
  ^^^^^^^^^^^^^^^

You mailer (Balsa?) wraps long lines in this and in other patches, thus 
corrupting them. Please fix.

baruch

-- 
                                                     ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch at tkos.co.il - tel: +972.2.679.5364, http://www.tkos.co.il -
