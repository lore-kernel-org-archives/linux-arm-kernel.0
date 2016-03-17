From: Vineet.Gupta1@synopsys.com (Vineet Gupta)
Date: Thu, 17 Mar 2016 11:29:13 +0000
Subject: [PATCH v2 all 04/14] arc: use of_platform_default_populate() to
 populate default bus
References: <1458113743-15131-1-git-send-email-wangkefeng.wang@huawei.com>
 <1458113743-15131-5-git-send-email-wangkefeng.wang@huawei.com>
Message-ID: <C2D7FE5348E1B147BCA15975FBA23075F4E903CE@us01wembx1.internal.synopsys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 16 March 2016 01:03 PM, Kefeng Wang wrote:
> Use helper of_platform_default_populate() in linux/of_platform
> when possible, instead of calling of_platform_populate() with
> the default match table.
>
> Acked-by: Vineet Gupta <vgupta@synopsys.com>
> Cc: Vineet Gupta <vgupta@synopsys.com>
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>

Thx Kefeng. I've added this to ARC for-curr for 4.6

> ---
>  arch/arc/kernel/setup.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arc/kernel/setup.c b/arch/arc/kernel/setup.c
> index cdc821d..401f51f 100644
> --- a/arch/arc/kernel/setup.c
> +++ b/arch/arc/kernel/setup.c
> @@ -464,7 +464,7 @@ static int __init customize_machine(void)
>  	 * Traverses flattened DeviceTree - registering platform devices
>  	 * (if any) complete with their resources
>  	 */
> -	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
> +	of_platform_default_populate(NULL, NULL, NULL);

Perhaps too late - but can't of_platform_default_populate just be a static inline
calling of_platform_populate in the header rather than exporting yet another symbol !

-Vineet

>  
>  	if (machine_desc->init_machine)
>  		machine_desc->init_machine();
