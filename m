From: tixy@linaro.org (Jon Medhurst (Tixy))
Date: Mon, 01 Jul 2013 16:34:22 +0100
Subject: [PATCH] ARM: vexpress_defconfig: Enable voltage regulators
In-Reply-To: <1370901015-4159-1-git-send-email-christoffer.dall@linaro.org>
References: <1370901015-4159-1-git-send-email-christoffer.dall@linaro.org>
Message-ID: <1372692862.3716.57.camel@linaro1.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2013-06-10 at 14:50 -0700, Christoffer Dall wrote:
> Enable the Versatile Express voltage regulators by default.
> 
> This should work on all verstatile express platforms and not enabling it
> prevents a defconfig'ed kernel from using the SD card controller on the
> qemu emulated platform, which is unfortunate for first-time casual
> users.
> 
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
> ---
>  arch/arm/configs/vexpress_defconfig |    3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/arm/configs/vexpress_defconfig b/arch/arm/configs/vexpress_defconfig
> index f2de51f..17104d9 100644
> --- a/arch/arm/configs/vexpress_defconfig
> +++ b/arch/arm/configs/vexpress_defconfig
> @@ -138,3 +138,6 @@ CONFIG_DEBUG_LL=y
>  CONFIG_EARLY_PRINTK=y
>  # CONFIG_CRYPTO_ANSI_CPRNG is not set
>  # CONFIG_CRYPTO_HW is not set
> +CONFIG_REGULATOR=y
> +CONFIG_REGULATOR_FIXED_VOLTAGE=y
> +CONFIG_REGULATOR_VEXPRESS=y

>From my testing, only the CONFIG_REGULATOR=y is required to get MMC
working on real hardware with Linux 3.10. Is CONFIG_REGULATOR_VEXPRESS
actually required to get QEMU working properly?

We definitely don't need CONFIG_REGULATOR_FIXED_VOLTAGE because config
ARCH_VEXPRESS has "select REGULATOR_FIXED_VOLTAGE if REGULATOR".

-- 
Tixy
