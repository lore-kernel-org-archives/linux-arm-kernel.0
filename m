From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Fri, 27 Nov 2015 09:41:42 +0100
Subject: [PATCH v8 08/17] drm: rockchip: dp: add rockchip platform dp
 driver
In-Reply-To: <1446020865-10625-1-git-send-email-ykk@rock-chips.com>
References: <1446020143-32645-1-git-send-email-ykk@rock-chips.com>
 <1446020865-10625-1-git-send-email-ykk@rock-chips.com>
Message-ID: <4247009.9cF1Z5lRXe@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Yakir,

Am Mittwoch, 28. Oktober 2015, 16:27:45 schrieb Yakir Yang:
> Rockchip have three clocks for dp controller, we leave pclk_edp
> to analogix_dp driver control, and keep the sclk_edp_24m and
> sclk_edp in platform driver.
> 
> Tested-by: Javier Martinez Canillas <javier@osg.samsung.com>
> Signed-off-by: Yakir Yang <ykk@rock-chips.com>
> ---

> diff --git a/drivers/gpu/drm/rockchip/Kconfig
> b/drivers/gpu/drm/rockchip/Kconfig index 35215f6..c2ba945 100644
> --- a/drivers/gpu/drm/rockchip/Kconfig
> +++ b/drivers/gpu/drm/rockchip/Kconfig
> @@ -25,3 +25,12 @@ config ROCKCHIP_DW_HDMI
>  	  for the Synopsys DesignWare HDMI driver. If you want to
>  	  enable HDMI on RK3288 based SoC, you should selet this
>  	  option.
> +
> +config ROCKCHIP_ANALOGIX_DP
> +        tristate "Rockchip specific extensions for Analogix DP driver"
> +        depends on DRM_ROCKCHIP
> +        select DRM_ANALOGIX_DP
> +        help

the indentation should probably be tabs here, ROCKCHIP_DW_HDMI also does it 
wrong it seems, but DRM_ROCKCHIP looks correct :-)


Heiko
