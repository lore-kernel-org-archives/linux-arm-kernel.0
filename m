From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 28 May 2014 09:36:49 +0100
Subject: [PATCH 1/1] ARM: ux500: Staticize ux500_soc_attr
In-Reply-To: <1401248417-10146-1-git-send-email-sachin.kamat@linaro.org>
References: <1401248417-10146-1-git-send-email-sachin.kamat@linaro.org>
Message-ID: <20140528083649.GB10803@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 28 May 2014, Sachin Kamat wrote:

> 'ux500_soc_attr' is local to this file. While at it also make it
> const to match the argument list of device_create_file.

What's going on Sachin?  I Acked v2 of this patch an hour ago, yet
you've resent it as a v1 and without the Ack?

> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> ---
>  arch/arm/mach-ux500/cpu.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
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
