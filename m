From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 25 Oct 2013 09:46:56 +0800
Subject: [PATCHv7][ 3/6] ARM: imx{25,27} DT: Permit the selection of the
 imxfb framebuffer driver.
In-Reply-To: <1382605103-9595-3-git-send-email-denis@eukrea.com>
References: <1382605103-9595-1-git-send-email-denis@eukrea.com>
 <1382605103-9595-3-git-send-email-denis@eukrea.com>
Message-ID: <20131025014652.GH14529@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 24, 2013 at 10:58:20AM +0200, Denis Carikli wrote:
> Without that patch, a user can't select the imxfb driver when the i.MX25 and/or
>   the i.MX27 device tree board are selected and that no boards that selects
>   IMX_HAVE_PLATFORM_IMX_FB are compiled in.
> 
> Cc: Rob Herring <rob.herring@calxeda.com>
> Cc: Pawel Moll <pawel.moll@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Stephen Warren <swarren@wwwdotorg.org>
> Cc: Ian Campbell <ijc+devicetree@hellion.org.uk>
> Cc: devicetree at vger.kernel.org
> Cc: Sascha Hauer <kernel@pengutronix.de>
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: Eric B?nard <eric@eukrea.com>
> 
> Signed-off-by: Denis Carikli <denis@eukrea.com>

This is a patch that should go through FB tree, so FB maintainer should
be copied, and patch subject should look like "video: ...".  Other than
that,

Acked-by: Shawn Guo <shawn.guo@linaro.org>

Shawn

> ---
> - Rework the patch to make imxfb more broadly selectable
>   (usefull for randconfig).
> ---
>  drivers/video/Kconfig |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
> index 14317b7..a9f2659 100644
> --- a/drivers/video/Kconfig
> +++ b/drivers/video/Kconfig
> @@ -363,7 +363,7 @@ config FB_SA1100
>  
>  config FB_IMX
>  	tristate "Freescale i.MX1/21/25/27 LCD support"
> -	depends on FB && IMX_HAVE_PLATFORM_IMX_FB
> +	depends on FB && ARCH_MXC
>  	select FB_CFB_FILLRECT
>  	select FB_CFB_COPYAREA
>  	select FB_CFB_IMAGEBLIT
> -- 
> 1.7.9.5
> 
