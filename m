From: khilman@baylibre.com (Kevin Hilman)
Date: Wed, 03 Feb 2016 16:53:37 -0800
Subject: [PATCH] ARM: multi_v7_defconfig: enable DW_WATCHDOG
In-Reply-To: <1454518986-25953-1-git-send-email-dinguyen@opensource.altera.com>
 (dinguyen@opensource.altera.com's message of "Wed, 3 Feb 2016 11:03:06
 -0600")
References: <1454518986-25953-1-git-send-email-dinguyen@opensource.altera.com>
Message-ID: <7htwlpb8j2.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

<dinguyen@opensource.altera.com> writes:

> From: Dinh Nguyen <dinguyen@opensource.altera.com>
>
> The watchdog timer on the SoCFPGA platform is the Synopsys Designware watchdog.
> Enable CONFIG_DW_WATCHDOG for the driver to get built.
>
> Signed-off-by: Dinh Nguyen <dinguyen@opensource.altera.com>

Tested-by: Kevin Hilman <khilman@baylibre.com>

I confirm that this fixes the boot problems I was seeing on my socfpga
board.

Kevin

> ---
>  arch/arm/configs/multi_v7_defconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
> index 69d6a6d..24ceac2 100644
> --- a/arch/arm/configs/multi_v7_defconfig
> +++ b/arch/arm/configs/multi_v7_defconfig
> @@ -426,6 +426,7 @@ CONFIG_SUNXI_WATCHDOG=y
>  CONFIG_IMX2_WDT=y
>  CONFIG_TEGRA_WATCHDOG=m
>  CONFIG_MESON_WATCHDOG=y
> +CONFIG_DW_WATCHDOG=y
>  CONFIG_DIGICOLOR_WATCHDOG=y
>  CONFIG_MFD_AS3711=y
>  CONFIG_MFD_AS3722=y
