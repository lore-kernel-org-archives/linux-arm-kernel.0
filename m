From: mark.yao@rock-chips.com (Mark yao)
Date: Wed, 15 Feb 2017 09:06:15 +0800
Subject: [PATCH] drm/rockchip: add extcon dependency for DP
In-Reply-To: <20170214213215.2888509-1-arnd@arndb.de>
References: <20170214213215.2888509-1-arnd@arndb.de>
Message-ID: <58A3A987.9020001@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2017?02?15? 05:31, Arnd Bergmann wrote:
> The newly added DP driver links against the extcon core, which fails when
> extcon is a module and this driver is not:
>
> drivers/gpu/drm/rockchip/cdn-dp-core.o: In function `cdn_dp_get_port_lanes':
> cdn-dp-core.c:(.text.cdn_dp_get_port_lanes+0x24): undefined reference to `extcon_get_state'
> cdn-dp-core.c:(.text.cdn_dp_get_port_lanes+0x44): undefined reference to `extcon_get_property'
>
> Let's make Kconfig enforce correct behavior with a dependency.

Thanks for the fix.

Applied to my drm-next.

> Fixes: 1a0f7ed3abe2 ("drm/rockchip: cdn-dp: add cdn DP support for rk3399")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>   drivers/gpu/drm/rockchip/Kconfig | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/rockchip/Kconfig b/drivers/gpu/drm/rockchip/Kconfig
> index ad31b3eb408f..0e4eb845cbb0 100644
> --- a/drivers/gpu/drm/rockchip/Kconfig
> +++ b/drivers/gpu/drm/rockchip/Kconfig
> @@ -24,6 +24,7 @@ config ROCKCHIP_ANALOGIX_DP
>   config ROCKCHIP_CDN_DP
>           tristate "Rockchip cdn DP"
>           depends on DRM_ROCKCHIP
> +	depends on EXTCON
>   	select SND_SOC_HDMI_CODEC if SND_SOC
>           help
>   	  This selects support for Rockchip SoC specific extensions


-- 
?ark Yao
