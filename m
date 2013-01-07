From: jason@lakedaemon.net (Jason Cooper)
Date: Mon, 7 Jan 2013 12:04:50 -0500
Subject: [PATCH 3.8-rc] arm: mvebu: add LEDs support to defconfig file
In-Reply-To: <1357576034-24193-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1357576034-24193-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20130107170450.GK5075@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 07, 2013 at 05:27:14PM +0100, Thomas Petazzoni wrote:
> The OpenBlocks AX3-4 platform has several LEDs, so it sounds wise to
> enable LED support in mvebu_defconfig. We anticipate that more
> platforms using Marvell EBU SoCs will have LEDs in the future.
> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> ---
> This is 3.8-rc material.

Is this patch fixing a problem?  I'm inclined to queue this up for 3.9

thx,

Jason.

> ---
>  arch/arm/configs/mvebu_defconfig |    5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/arch/arm/configs/mvebu_defconfig b/arch/arm/configs/mvebu_defconfig
> index 3ba35f1..6b9e95d 100644
> --- a/arch/arm/configs/mvebu_defconfig
> +++ b/arch/arm/configs/mvebu_defconfig
> @@ -40,6 +40,11 @@ CONFIG_I2C_MV64XXX=y
>  CONFIG_GPIOLIB=y
>  CONFIG_GPIO_SYSFS=y
>  # CONFIG_USB_SUPPORT is not set
> +CONFIG_NEW_LEDS=y
> +CONFIG_LEDS_CLASS=m
> +CONFIG_LEDS_TRIGGERS=y
> +CONFIG_LEDS_TRIGGER_TIMER=y
> +CONFIG_LEDS_TRIGGER_HEARTBEAT=y
>  CONFIG_RTC_CLASS=y
>  CONFIG_RTC_DRV_S35390A=y
>  CONFIG_DMADEVICES=y
> -- 
> 1.7.9.5
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
