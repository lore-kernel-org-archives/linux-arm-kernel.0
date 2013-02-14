From: horms@verge.net.au (Simon Horman)
Date: Thu, 14 Feb 2013 11:48:50 +0900
Subject: [PATCH 2/3] ARM: mach-shmobile: armadillo800eva: enable
 REGULATOR in defconfig
In-Reply-To: <1360761103-17357-3-git-send-email-horms+renesas@verge.net.au>
References: <1360761103-17357-1-git-send-email-horms+renesas@verge.net.au>
 <1360761103-17357-3-git-send-email-horms+renesas@verge.net.au>
Message-ID: <20130214024847.GQ15879@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 13, 2013 at 10:11:42PM +0900, Simon Horman wrote:
> As well as being a generally sane thing to do this
> is required for MMCIF to function in conjunction with
> "ARM: shmobile: switch SDHI0 to GPIO regulator on armadillo800eva".
> 
> Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> 
> ---
> 
> v2
> * Don't enable REGULATOR_DUMMY, it is only intended for development / testing.
> ---
>  arch/arm/configs/armadillo800eva_defconfig |    1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/configs/armadillo800eva_defconfig b/arch/arm/configs/armadillo800eva_defconfig
> index 0b98100..0cc8014 100644
> --- a/arch/arm/configs/armadillo800eva_defconfig
> +++ b/arch/arm/configs/armadillo800eva_defconfig
> @@ -88,6 +88,7 @@ CONFIG_I2C=y
>  CONFIG_I2C_GPIO=y
>  CONFIG_I2C_SH_MOBILE=y
>  # CONFIG_HWMON is not set
> +CONFIG_REGULATOR=y
>  CONFIG_MEDIA_SUPPORT=y
>  CONFIG_VIDEO_DEV=y
>  CONFIG_MEDIA_CAMERA_SUPPORT=y

This patch seems to break NIC initialisation.

smsc911x: Driver version 2008-10-21
smsc911x smsc911x.0: Failed to get supply 'vdd33a': -517
smsc911x smsc911x.0 (unregistered net_device): couldn't get regulators -517
platform smsc911x.0: Driver smsc911x requests probe deferral
