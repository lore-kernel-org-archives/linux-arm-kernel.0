From: robh@kernel.org (Rob Herring)
Date: Fri, 18 Nov 2016 10:33:42 -0600
Subject: [RFC 2/6] drm/etnaviv: allow building etnaviv on omap devices
In-Reply-To: <20161118024436.13447-2-robertcnelson@gmail.com>
References: <20161118024436.13447-1-robertcnelson@gmail.com>
 <20161118024436.13447-2-robertcnelson@gmail.com>
Message-ID: <20161118163342.5t2tbsw54k2gmqe3@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 17, 2016 at 08:44:32PM -0600, Robert Nelson wrote:
> Signed-off-by: Robert Nelson <robertcnelson@gmail.com>
> CC: Christian Gmeiner <christian.gmeiner@gmail.com>
> CC: Russell King <rmk+kernel@arm.linux.org.uk>
> CC: Lucas Stach <l.stach@pengutronix.de>
> ---
>  drivers/gpu/drm/etnaviv/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/etnaviv/Kconfig b/drivers/gpu/drm/etnaviv/Kconfig
> index 2cde7a5..b776f41 100644
> --- a/drivers/gpu/drm/etnaviv/Kconfig
> +++ b/drivers/gpu/drm/etnaviv/Kconfig
> @@ -2,7 +2,7 @@
>  config DRM_ETNAVIV
>  	tristate "ETNAVIV (DRM support for Vivante GPU IP cores)"
>  	depends on DRM
> -	depends on ARCH_MXC || ARCH_DOVE
> +	depends on ARCH_MXC || ARCH_DOVE || ARCH_OMAP2PLUS

Why not just drop this line. Then it will get better build testing, too.

>  	select SHMEM
>  	select TMPFS
>  	select IOMMU_API
> -- 
> 2.10.2
> 
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
