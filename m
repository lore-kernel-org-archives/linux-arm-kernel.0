From: marcel@ziswiler.com (Marcel Ziswiler)
Date: Mon, 02 Jun 2014 18:28:37 +0200
Subject: [PATCH 2/3] arm: tegra: enable igb, stmpe, i2c chardev, spidev,
 lm95245, pwm leds
In-Reply-To: <538CA24B.1010602@wwwdotorg.org>
References: <c5522b0efcbfc7690dcde6aaf78b9dd568f99604.1401665237.git.marcel@ziswiler.com>
 <39a8704a4c8170d6b0620a1e5e44042eae6d8810.1401665237.git.marcel@ziswiler.com>
 <538CA24B.1010602@wwwdotorg.org>
Message-ID: <538CA635.4050502@ziswiler.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/02/2014 06:11 PM, Stephen Warren wrote:
>> BTW: How about MTD_SPI_NOR,
>
> That might only exist in linux-next.
>
>> PROC_DEVICETREE and CRYPTO_DEV_TEGRA_AES
>> which I haven't found any mentioning anywhere?
>
> The TEGRA_AES driver has been removed, so the option should be removed
> from defconfig too. I don't know what happened to PROC_DEVICTREE - it
> doesn't seem to exist any more. Was it replaced by something else or
> deleted? Feel free to send patches for those.

OK, will do.

>> diff --git a/arch/arm/configs/tegra_defconfig b/arch/arm/configs/tegra_defconfig
>
>> +CONFIG_SPI_SPIDEV=y
>
> Is this useful with DT? I thought that unlike I2C_CHARDEV, spidev needed
> dummy devices to exist in DT for spidev to work? If so, there's not much
> point adding the option to defconfig, since people can add it when they
> put the dummy devices into DT.

Yes, the Apalis T30 DT I sent actually contains two of them which we 
call generic Apalis SPI1 and SPI2 out-of-the-box configured for exactly 
that. Without the config enabled though it probably does not make much 
sense to include it in the DT so I would consider removing it again.
