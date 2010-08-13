From: santosh.shilimkar@ti.com (Shilimkar, Santosh)
Date: Fri, 13 Aug 2010 14:34:13 +0530
Subject: [PATCH 6/6] omap: Fix omap_4430sdp_defconfig for make oldconfig
In-Reply-To: <20100813080213.18750.41042.stgit@baageli.muru.com>
References: <20100813080034.18750.15410.stgit@baageli.muru.com>
	<20100813080213.18750.41042.stgit@baageli.muru.com>
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02C65D7F91@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: linux-omap-owner at vger.kernel.org [mailto:linux-omap-
> owner at vger.kernel.org] On Behalf Of Tony Lindgren
> Sent: Friday, August 13, 2010 1:32 PM
> To: linux-arm-kernel at lists.infradead.org
> Cc: linux-omap at vger.kernel.org
> Subject: [PATCH 6/6] omap: Fix omap_4430sdp_defconfig for make oldconfig
> 
> Commit ffb63e3402849e1b70119ee0c9a81dc9da4dfa97 changed
> Kconfig to select support for omap2, 3 and 4 by default.
> 
> However, CONFIG_SMP won't currently work properly on
> uniprocessor ARMs, or if support for earlier ARM cores
> is selected in.
> 
> Fix this by updating omap_4430sdp_defconfig to not
> select omap2 or 3 at this point.
> 
> Signed-off-by: Tony Lindgren <tony@atomide.com>
With this patch and previous one in the series, OMAP4
SDP build and boot are working fine. Thanks

Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>

> ---
>  arch/arm/configs/omap_4430sdp_defconfig |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/configs/omap_4430sdp_defconfig
> b/arch/arm/configs/omap_4430sdp_defconfig
> index 63e0c2d..14c1e18 100644
> --- a/arch/arm/configs/omap_4430sdp_defconfig
> +++ b/arch/arm/configs/omap_4430sdp_defconfig
> @@ -13,6 +13,9 @@ CONFIG_MODULE_SRCVERSION_ALL=y
>  # CONFIG_BLK_DEV_BSG is not set
>  CONFIG_ARCH_OMAP=y
>  CONFIG_ARCH_OMAP4=y
> +# CONFIG_ARCH_OMAP2PLUS_TYPICAL is not set
> +# CONFIG_ARCH_OMAP2 is not set
> +# CONFIG_ARCH_OMAP3 is not set
>  # CONFIG_OMAP_MUX is not set
>  CONFIG_OMAP_32K_TIMER=y
>  CONFIG_OMAP_DM_TIMER=y
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
