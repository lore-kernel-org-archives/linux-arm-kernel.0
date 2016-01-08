From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Fri, 8 Jan 2016 12:35:15 -0300
Subject: [PATCH 2/2] ARM: exynos_defconfig: Enable s5p-secss driver
In-Reply-To: <1452132905-8587-2-git-send-email-k.kozlowski@samsung.com>
References: <1452132905-8587-1-git-send-email-k.kozlowski@samsung.com>
 <1452132905-8587-2-git-send-email-k.kozlowski@samsung.com>
Message-ID: <568FD733.8030601@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Krzysztof,

On 01/06/2016 11:15 PM, Krzysztof Kozlowski wrote:
> The Exynos SoC provides a Security SubSystem block for accelerating some
> cryptographic operations. Enable the driver for it - s5p-secss to
> utilize the hardware acceleration.
> 
> Currently the s5p-secss driver supports AES in CBC and ECB modes.
> However on Odroid XU4 (Exynos5422) and Trats2 (Exynos4412) boards this
> change introduces one booting error:
> 
> 	alg: skcipher: encryption failed on chunk test 1 for ecb-aes-s5p: ret=22
> 
> The cbc-aes-s5p properly registers itself and passes self-tests.
> 
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> ---
>  arch/arm/configs/exynos_defconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/configs/exynos_defconfig b/arch/arm/configs/exynos_defconfig
> index 0aee1e035be9..c47c7e069873 100644
> --- a/arch/arm/configs/exynos_defconfig
> +++ b/arch/arm/configs/exynos_defconfig
> @@ -240,6 +240,7 @@ CONFIG_DEBUG_RT_MUTEXES=y
>  CONFIG_DEBUG_SPINLOCK=y
>  CONFIG_DEBUG_MUTEXES=y
>  CONFIG_DEBUG_USER=y
> +CONFIG_CRYPTO_DEV_S5P=y

I noticed that this is not enabled in multi_v7_defconfig.
Are you planing to do it as well?

>  CONFIG_ARM_CRYPTO=y
>  CONFIG_CRYPTO_SHA1_ARM_NEON=m
>  CONFIG_CRYPTO_SHA256_ARM=m
> 

Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
