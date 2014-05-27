From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 27 May 2014 13:14:54 +0100
Subject: [PATCH 1/1] ARM: ux500: Staticize ux500_soc_attr
In-Reply-To: <1401192188-10936-1-git-send-email-sachin.kamat@linaro.org>
References: <1401192188-10936-1-git-send-email-sachin.kamat@linaro.org>
Message-ID: <20140527121454.GA26391@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 27 May 2014, Sachin Kamat wrote:

> 'ux500_soc_attr' is local to this file.
> 
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> ---
>  arch/arm/mach-ux500/cpu.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-ux500/cpu.c b/arch/arm/mach-ux500/cpu.c
> index db16b5a04ad5..4dfa04a96f4d 100644
> --- a/arch/arm/mach-ux500/cpu.c
> +++ b/arch/arm/mach-ux500/cpu.c
> @@ -125,7 +125,7 @@ static void __init soc_info_populate(struct soc_device_attribute *soc_dev_attr,
>  	soc_dev_attr->revision = ux500_get_revision();
>  }
>  
> -struct device_attribute ux500_soc_attr =
> +static struct device_attribute ux500_soc_attr =

Should probably be const too.

>  	__ATTR(process,  S_IRUGO, ux500_get_process,  NULL);
>  
>  struct device * __init ux500_soc_device_init(const char *soc_id)

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
