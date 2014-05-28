From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 28 May 2014 08:14:19 +0100
Subject: [PATCH v2 1/1] ARM: ux500: Staticize ux500_soc_attr
In-Reply-To: <1401247907-8366-1-git-send-email-sachin.kamat@linaro.org>
References: <1401247907-8366-1-git-send-email-sachin.kamat@linaro.org>
Message-ID: <20140528071419.GI4227@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> 'ux500_soc_attr' is local to this file. While at it also make it
> const to match the argument list of device_create_file.
> 
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> ---
> Made ux500_soc_attr const as suggested by Lee Jones.
> ---
>  arch/arm/mach-ux500/cpu.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Acked-by: Lee Jones <lee.jones@linaro.org>

> diff --git a/arch/arm/mach-ux500/cpu.c b/arch/arm/mach-ux500/cpu.c
> index db16b5a04ad5..dbb2970ee7da 100644
> --- a/arch/arm/mach-ux500/cpu.c
> +++ b/arch/arm/mach-ux500/cpu.c
> @@ -125,7 +125,7 @@ static void __init soc_info_populate(struct soc_device_attribute *soc_dev_attr,
>  	soc_dev_attr->revision = ux500_get_revision();
>  }
>  
> -struct device_attribute ux500_soc_attr =
> +static const struct device_attribute ux500_soc_attr =
>  	__ATTR(process,  S_IRUGO, ux500_get_process,  NULL);
>  
>  struct device * __init ux500_soc_device_init(const char *soc_id)

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
