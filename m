From: xuwei5@hisilicon.com (Wei Xu)
Date: Wed, 24 Aug 2016 16:09:29 +0100
Subject: [RFC][PATCH] Kconfig: ARCH_HISI: Add PINCTRL to HISI platform
In-Reply-To: <1471905930-12438-1-git-send-email-john.stultz@linaro.org>
References: <1471905930-12438-1-git-send-email-john.stultz@linaro.org>
Message-ID: <57BDB8A9.3050905@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi John,

On 22/08/2016 23:45, John Stultz wrote:
> Things won't work if PINCTRL isn't enabled,
> so make sure to explicitly set it rather
> then betting that we have some other platform
> configed in which selects it.
> 
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Wei Xu <xuwei5@hisilicon.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: linux-arm-kernel at lists.infradead.org
> Signed-off-by: John Stultz <john.stultz@linaro.org>
> ---

Applied to hisi-defconfig-4.9 branch.
Thanks!

Best Regards,
Wei

>  arch/arm64/Kconfig.platforms | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
> index be5d824..f848946 100644
> --- a/arch/arm64/Kconfig.platforms
> +++ b/arch/arm64/Kconfig.platforms
> @@ -67,6 +67,7 @@ config ARCH_HISI
>  	bool "Hisilicon SoC Family"
>  	select ARM_TIMER_SP804
>  	select HISILICON_IRQ_MBIGEN if PCI
> +	select PINCTRL
>  	help
>  	  This enables support for Hisilicon ARMv8 SoC family
>  
> 
