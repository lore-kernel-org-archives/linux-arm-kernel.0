From: nsekhar@ti.com (Sekhar Nori)
Date: Tue, 3 Jan 2017 14:50:53 +0530
Subject: [PATCH] ARM: davinci_all_defconfig: enable dumb vga-dac drm bridge
In-Reply-To: <1480065182-7095-1-git-send-email-bgolaszewski@baylibre.com>
References: <1480065182-7095-1-git-send-email-bgolaszewski@baylibre.com>
Message-ID: <213a0474-b548-88fb-062b-958a905d1ea7@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 25 November 2016 02:43 PM, Bartosz Golaszewski wrote:
> This enables the dumb-vga-dac driver by default for davinci boards.
> 
> The driver is needed for tilcdc support on da850-lcdk board.
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---
>  arch/arm/configs/davinci_all_defconfig | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm/configs/davinci_all_defconfig b/arch/arm/configs/davinci_all_defconfig
> index b5e978f..ab1bf18 100644
> --- a/arch/arm/configs/davinci_all_defconfig
> +++ b/arch/arm/configs/davinci_all_defconfig
> @@ -127,6 +127,8 @@ CONFIG_REGULATOR_FIXED_VOLTAGE=y
>  CONFIG_REGULATOR_TPS6507X=y
>  CONFIG_DRM=m
>  CONFIG_DRM_TILCDC=m
> +CONFIG_DRM_BRIDGE=y

DRM_BRIDGE is a 'def_bool y'. So no need to explicitly enable it. And
actually it will get dropped with the next savedefconfig refresh anyway.

Applying this patch with this line dropped.

Thanks,
Sekhar
