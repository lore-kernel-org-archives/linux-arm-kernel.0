From: g.liakhovetski@gmx.de (Guennadi Liakhovetski)
Date: Wed, 13 Feb 2013 13:27:53 +0100 (CET)
Subject: [PATCH] ARM: mach-shmobile: mackerel: enable REGULATOR in
 defconfig
In-Reply-To: <1360757770-15360-1-git-send-email-horms+renesas@verge.net.au>
References: <1360757770-15360-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <Pine.LNX.4.64.1302131327130.18535@axis700.grange>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 13 Feb 2013, Simon Horman wrote:

> As well as being a generally sane thing to do this
> is required for MMCIF to function in conjunction with
> " ARM: shmobile: streamline mackerel SD and MMC devices".
> 
> Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> ---
>  arch/arm/configs/mackerel_defconfig |    2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm/configs/mackerel_defconfig b/arch/arm/configs/mackerel_defconfig
> index ec8e605..fdced32 100644
> --- a/arch/arm/configs/mackerel_defconfig
> +++ b/arch/arm/configs/mackerel_defconfig
> @@ -75,6 +75,8 @@ CONFIG_I2C=y
>  CONFIG_I2C_SH_MOBILE=y
>  # CONFIG_HWMON is not set
>  # CONFIG_MFD_SUPPORT is not set
> +CONFIG_REGULATOR=y
> +CONFIG_REGULATOR_DUMMY=y

Same comment, in fact, we probably need the fixed regulator, and, on 
armadillo800eva the GPIO regulator.

Thanks
Guennadi

>  CONFIG_FB=y
>  CONFIG_FB_MODE_HELPERS=y
>  CONFIG_FB_SH_MOBILE_LCDC=y
> -- 
> 1.7.10.4
> 

---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
