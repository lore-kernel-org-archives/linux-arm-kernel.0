From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 02 Jun 2014 10:11:55 -0600
Subject: [PATCH 2/3] arm: tegra: enable igb, stmpe, i2c chardev, spidev,
 lm95245, pwm leds
In-Reply-To: <39a8704a4c8170d6b0620a1e5e44042eae6d8810.1401665237.git.marcel@ziswiler.com>
References: <c5522b0efcbfc7690dcde6aaf78b9dd568f99604.1401665237.git.marcel@ziswiler.com>
 <39a8704a4c8170d6b0620a1e5e44042eae6d8810.1401665237.git.marcel@ziswiler.com>
Message-ID: <538CA24B.1010602@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/01/2014 05:37 PM, Marcel Ziswiler wrote:
> The NVIDIA Tegra 3 based Apalis T30 module contains an Intel i210 resp.
> i211 gigabit Ethernet controller, an STMPE811 ADC/touch controller, I2C
> as well as SPI buses and PWM LEDs generically accessible from user
> space and an LM95245 temperature sensor chip. The later five can also
> be found on the Colibri T30 module.
> 
> While at it move the PCA953x GPIO entry down to its proper place to
> have it all nicely ordered again.
> 
> Signed-off-by: Marcel Ziswiler <marcel@ziswiler.com>
> ---
> BTW: How about MTD_SPI_NOR,

That might only exist in linux-next.

> PROC_DEVICETREE and CRYPTO_DEV_TEGRA_AES
> which I haven't found any mentioning anywhere?

The TEGRA_AES driver has been removed, so the option should be removed
from defconfig too. I don't know what happened to PROC_DEVICTREE - it
doesn't seem to exist any more. Was it replaced by something else or
deleted? Feel free to send patches for those.

> diff --git a/arch/arm/configs/tegra_defconfig b/arch/arm/configs/tegra_defconfig

> +CONFIG_SPI_SPIDEV=y

Is this useful with DT? I thought that unlike I2C_CHARDEV, spidev needed
dummy devices to exist in DT for spidev to work? If so, there's not much
point adding the option to defconfig, since people can add it when they
put the dummy devices into DT.
