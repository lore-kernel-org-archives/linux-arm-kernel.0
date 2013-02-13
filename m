From: g.liakhovetski@gmx.de (Guennadi Liakhovetski)
Date: Wed, 13 Feb 2013 13:26:55 +0100 (CET)
Subject: [PATCH] ARM: mach-shmobile: armadillo800eva: enable REGULATOR
 in defconfig
In-Reply-To: <1360757745-15251-1-git-send-email-horms+renesas@verge.net.au>
References: <1360757745-15251-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <Pine.LNX.4.64.1302131324200.18535@axis700.grange>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Simon

On Wed, 13 Feb 2013, Simon Horman wrote:

> As well as being a generally sane thing to do this
> is required for MMCIF to function in conjunction with
> "ARM: shmobile: switch SDHI0 to GPIO regulator on armadillo800eva".
> 
> Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> ---
>  arch/arm/configs/armadillo800eva_defconfig |    2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm/configs/armadillo800eva_defconfig b/arch/arm/configs/armadillo800eva_defconfig
> index 0b98100..6ceb79f 100644
> --- a/arch/arm/configs/armadillo800eva_defconfig
> +++ b/arch/arm/configs/armadillo800eva_defconfig
> @@ -88,6 +88,8 @@ CONFIG_I2C=y
>  CONFIG_I2C_GPIO=y
>  CONFIG_I2C_SH_MOBILE=y
>  # CONFIG_HWMON is not set
> +CONFIG_REGULATOR=y
> +CONFIG_REGULATOR_DUMMY=y

I don't think it's a good idea to enable the dummy regulator by default in 
defconfig. It has been explained to me, that that regulator is only meant 
for development / testing. For production you really should have the 
_correct_ regulators in place. So, encouraging it by default is probably 
not a very good idea.

Thanks
Guennadi

>  CONFIG_MEDIA_SUPPORT=y
>  CONFIG_VIDEO_DEV=y
>  CONFIG_MEDIA_CAMERA_SUPPORT=y
> -- 
> 1.7.10.4
> 

---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
