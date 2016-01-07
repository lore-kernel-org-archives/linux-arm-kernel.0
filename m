From: linux.amoon@gmail.com (Anand Moon)
Date: Thu, 7 Jan 2016 22:42:24 +0530
Subject: [PATCH 2/2] ARM: exynos_defconfig: Enable s5p-secss driver
In-Reply-To: <1452132905-8587-2-git-send-email-k.kozlowski@samsung.com>
References: <1452132905-8587-1-git-send-email-k.kozlowski@samsung.com>
 <1452132905-8587-2-git-send-email-k.kozlowski@samsung.com>
Message-ID: <CANAwSgSDuwQdgsfa6nHc5WwW-ZiRbifPHeNAvS5LNxWiQ0oNiQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Krzysztof,

On 7 January 2016 at 07:45, Krzysztof Kozlowski <k.kozlowski@samsung.com> wrote:
> The Exynos SoC provides a Security SubSystem block for accelerating some
> cryptographic operations. Enable the driver for it - s5p-secss to
> utilize the hardware acceleration.
>
> Currently the s5p-secss driver supports AES in CBC and ECB modes.
> However on Odroid XU4 (Exynos5422) and Trats2 (Exynos4412) boards this
> change introduces one booting error:
>
>         alg: skcipher: encryption failed on chunk test 1 for ecb-aes-s5p: ret=22
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
>  CONFIG_ARM_CRYPTO=y
>  CONFIG_CRYPTO_SHA1_ARM_NEON=m
>  CONFIG_CRYPTO_SHA256_ARM=m
> --
> 1.9.1
>

Reviewed-by: Anand Moon <linux.amoon@gmail.com>

Best Regards,
-Anand Moon
