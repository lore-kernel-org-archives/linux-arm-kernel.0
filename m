From: g.liakhovetski@gmx.de (Guennadi Liakhovetski)
Date: Wed, 13 Feb 2013 14:21:53 +0100 (CET)
Subject: [PATCH 1/3] ARM: mach-shmobile: mackerel: enable REGULATOR in
 defconfig
In-Reply-To: <1360761103-17357-2-git-send-email-horms+renesas@verge.net.au>
References: <1360761103-17357-1-git-send-email-horms+renesas@verge.net.au>
 <1360761103-17357-2-git-send-email-horms+renesas@verge.net.au>
Message-ID: <Pine.LNX.4.64.1302131418350.18535@axis700.grange>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Simon

On Wed, 13 Feb 2013, Simon Horman wrote:

> As well as being a generally sane thing to do this
> is required for MMCIF to function in conjunction with
> " ARM: shmobile: streamline mackerel SD and MMC devices".
> 
> Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> 
> ---
> 
> v2
> * Don't enable REGULATOR_DUMMY, it is only intended for development / testing.
> ---
>  arch/arm/configs/mackerel_defconfig |    1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/configs/mackerel_defconfig b/arch/arm/configs/mackerel_defconfig
> index ec8e605..9fb1189 100644
> --- a/arch/arm/configs/mackerel_defconfig
> +++ b/arch/arm/configs/mackerel_defconfig
> @@ -75,6 +75,7 @@ CONFIG_I2C=y
>  CONFIG_I2C_SH_MOBILE=y
>  # CONFIG_HWMON is not set
>  # CONFIG_MFD_SUPPORT is not set
> +CONFIG_REGULATOR=y

We really don't have to enable CONFIG_REGULATOR_GPIO and 
CONFIG_REGULATOR_FIXED_VOLTAGE? IIRC, CONFIG_REGULATOR_GPIO is so far only 
used on armadillo800eva, but the fixed regulator is required for other 
boards too?

Thanks
Guennadi

>  CONFIG_FB=y
>  CONFIG_FB_MODE_HELPERS=y
>  CONFIG_FB_SH_MOBILE_LCDC=y
> -- 
> 1.7.10.4

---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
