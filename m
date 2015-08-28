From: lee.jones@linaro.org (Lee Jones)
Date: Fri, 28 Aug 2015 07:58:30 +0100
Subject: [PATCH v2 3/5] [media] c8sectpfe: Remove select on undefined
 LIBELF_32
In-Reply-To: <1440678575-21646-4-git-send-email-peter.griffin@linaro.org>
References: <1440678575-21646-1-git-send-email-peter.griffin@linaro.org>
 <1440678575-21646-4-git-send-email-peter.griffin@linaro.org>
Message-ID: <20150828065830.GE4796@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 27 Aug 2015, Peter Griffin wrote:

> LIBELF_32 is not defined in Kconfig, and is left over legacy
> which is not required in the upstream driver, so remove it.
> 
> Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
> Suggested-by: Valentin Rothberg <valentinrothberg@gmail.com>

These are the wrong way round, they should be in chronological order.

> ---
>  drivers/media/platform/sti/c8sectpfe/Kconfig | 1 -
>  1 file changed, 1 deletion(-)

Acked-by: Lee Jones <lee.jones@linaro.org>

> diff --git a/drivers/media/platform/sti/c8sectpfe/Kconfig b/drivers/media/platform/sti/c8sectpfe/Kconfig
> index d1bfd4c..b9ec667 100644
> --- a/drivers/media/platform/sti/c8sectpfe/Kconfig
> +++ b/drivers/media/platform/sti/c8sectpfe/Kconfig
> @@ -1,7 +1,6 @@
>  config DVB_C8SECTPFE
>  	tristate "STMicroelectronics C8SECTPFE DVB support"
>  	depends on DVB_CORE && I2C && (ARCH_STI || ARCH_MULTIPLATFORM)
> -	select LIBELF_32
>  	select FW_LOADER
>  	select FW_LOADER_USER_HELPER_FALLBACK
>  	select DEBUG_FS

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
