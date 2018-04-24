From: rdunlap@infradead.org (Randy Dunlap)
Date: Tue, 24 Apr 2018 08:39:03 -0700
Subject: [v2 resend 03/10] mfd: mtk-mmsys: Add mmsys driver
In-Reply-To: <99bef17c57ad60eff6104da780cf59b785bd3e42.1524563001.git.mbrugger@suse.com>
References: <cover.1524563001.git.mbrugger@suse.com>
 <99bef17c57ad60eff6104da780cf59b785bd3e42.1524563001.git.mbrugger@suse.com>
Message-ID: <9b023ba1-fb66-a955-e54d-d0a9cbbd7b45@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/24/2018 02:47 AM, matthias.bgg at kernel.org wrote:
> From: Matthias Brugger <mbrugger@suse.com>
> 
> The MMSYS subsystem includes clocks and drm components.
> This patch adds a MFD device to probe both drivers from the same
> device tree compatible.
> 
> Signed-off-by: Matthias Brugger <mbrugger@suse.com>
> ---
>  drivers/mfd/Kconfig     |  9 ++++++
>  drivers/mfd/Makefile    |  2 ++
>  drivers/mfd/mtk-mmsys.c | 79 +++++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 90 insertions(+)
>  create mode 100644 drivers/mfd/mtk-mmsys.c
> 
> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index b860eb5aa194..a2c928e26026 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -378,6 +378,15 @@ config MFD_MC13XXX_I2C
>  	help
>  	  Select this if your MC13xxx is connected via an I2C bus.
>  
> +config MFD_MEDIATEK_MMSYS
> +	tristate "Mediatek MMSYS interface"
> +	select MDF_CORE

	select MFD_CORE

tested??

> +	select REGMAP_MMIO
> +	help
> +	  Select this if you have a MMSYS subsystem in your SoC. The
> +	  MMSYS subsystem has at least a clock driver part and some
> +	  DRM components.
> +
>  config MFD_MXS_LRADC
>  	tristate "Freescale i.MX23/i.MX28 LRADC"
>  	depends on ARCH_MXS || COMPILE_TEST


-- 
~Randy
