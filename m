From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Thu, 8 May 2014 13:41:45 +0300
Subject: [PATCH] video: exynos: Add a dependency to the menu
In-Reply-To: <20140408120056.57556a00@endymion.delvare>
References: <20140408120056.57556a00@endymion.delvare>
Message-ID: <536B5F69.9000707@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/04/14 13:00, Jean Delvare wrote:
> All drivers under menu EXYNOS_VIDEO depend on either ARCH_S5PV210 or
> ARCH_EXYNOS, so add these as dependencies to the menu itself. This
> avoids presenting an empty and useless menu on other architectures.
> 
> Then drivers under the menu only need a dependency if they depend on
> one of the supported architectures specifically.
> 
> Signed-off-by: Jean Delvare <jdelvare@suse.de>
> Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
> Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
> Cc: Kukjin Kim <kgene.kim@samsung.com>
> ---
>  drivers/video/exynos/Kconfig |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- linux-3.15-rc0.orig/drivers/video/exynos/Kconfig	2014-04-07 10:23:07.316226676 +0200
> +++ linux-3.15-rc0/drivers/video/exynos/Kconfig	2014-04-08 11:50:17.406723187 +0200
> @@ -4,6 +4,7 @@
>  
>  menuconfig EXYNOS_VIDEO
>  	bool "Exynos Video driver support"
> +	depends on ARCH_S5PV210 || ARCH_EXYNOS
>  	help
>  	  This enables support for EXYNOS Video device.
>  
> @@ -15,7 +16,6 @@ if EXYNOS_VIDEO
>  
>  config EXYNOS_MIPI_DSI
>  	bool "EXYNOS MIPI DSI driver support."
> -	depends on ARCH_S5PV210 || ARCH_EXYNOS
>  	select GENERIC_PHY
>  	help
>  	  This enables support for MIPI-DSI device.
> 
> 

I've applied this for 3.16.

 Tomi


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140508/99244fbd/attachment.sig>
