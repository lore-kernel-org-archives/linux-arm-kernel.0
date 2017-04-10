From: xuwei5@hisilicon.com (Wei Xu)
Date: Mon, 10 Apr 2017 16:23:37 +0100
Subject: [PATCH -next v2] ARM: hisi: fix error return code in
 hip04_smp_init()
In-Reply-To: <20170205163255.28589-1-weiyj.lk@gmail.com>
References: <20170122164128.29381-1-weiyj.lk@gmail.com>
 <20170205163255.28589-1-weiyj.lk@gmail.com>
Message-ID: <58EBA379.90401@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Yongjun,

On 2017/2/5 16:32, Wei Yongjun wrote:
> From: Wei Yongjun <weiyongjun1@huawei.com>
> 
> Fix to return error code -ENODEV from the of_find_compatible_node()
> error handling case instead of 0, as done elsewhere in this function.
> 
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>

Thanks!
Applied to the hisilicon soc tree.

Best Regards,
Wei

> ---
> v1 -> v2: fix file module
> ---
>  arch/arm/mach-hisi/platmcpm.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm/mach-hisi/platmcpm.c b/arch/arm/mach-hisi/platmcpm.c
> index a6c1176..f0fff21 100644
> --- a/arch/arm/mach-hisi/platmcpm.c
> +++ b/arch/arm/mach-hisi/platmcpm.c
> @@ -279,6 +279,8 @@ static int __init hip04_smp_init(void)
>  					 &hip04_boot_method[0], 4);
>  	if (ret)
>  		goto err;
> +
> +	ret = -ENODEV;
>  	np_sctl = of_find_compatible_node(NULL, NULL, "hisilicon,sysctrl");
>  	if (!np_sctl)
>  		goto err;
> 
> 
> 
