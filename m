From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Mon, 10 Aug 2015 13:00:56 +0200
Subject: [PATCH] ARM: mvebu: update mvebu_v7_defconfig for Armada 38x
 USB3.0
In-Reply-To: <1439200314-26850-1-git-send-email-jaz@semihalf.com>
References: <1439200314-26850-1-git-send-email-jaz@semihalf.com>
Message-ID: <55C88468.2000400@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Grzegorz,

On 10/08/2015 11:51, Grzegorz Jaszczyk wrote:
> 	This patch enables the fixed voltage regulator and the gpio PCA953X
> 	drivers in mvebu_v7_defconfig, as they are used for enabling the USB3.0
> 	phy on some of the Armada's 38x boards.
> 

The same patch had already been merged in arm-soc and should be part of
4.3: See: "ARM: mvebu: update mvebu_v7_defconfig with features needed
for Armada 388 GP".
http://thread.gmane.org/gmane.linux.ports.arm.kernel/421082/focus=425086

Thanks,

Gregory

> Signed-off-by: Grzegorz Jaszczyk <jaz@semihalf.com>
> Cc: <stable@vger.kernel.org>
> ---
>  arch/arm/configs/mvebu_v7_defconfig | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/arm/configs/mvebu_v7_defconfig b/arch/arm/configs/mvebu_v7_defconfig
> index cacc9f4..1b8ecf4 100644
> --- a/arch/arm/configs/mvebu_v7_defconfig
> +++ b/arch/arm/configs/mvebu_v7_defconfig
> @@ -83,11 +83,14 @@ CONFIG_I2C_MV64XXX=y
>  CONFIG_SPI=y
>  CONFIG_SPI_ORION=y
>  CONFIG_GPIO_SYSFS=y
> +CONFIG_GPIO_PCA953X=y
>  CONFIG_SENSORS_GPIO_FAN=y
>  CONFIG_THERMAL=y
>  CONFIG_ARMADA_THERMAL=y
>  CONFIG_WATCHDOG=y
>  CONFIG_ORION_WATCHDOG=y
> +CONFIG_REGULATOR=y
> +CONFIG_REGULATOR_FIXED_VOLTAGE=y
>  CONFIG_SOUND=y
>  CONFIG_SND=y
>  CONFIG_SND_SOC=y
> 


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
