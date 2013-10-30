From: robherring2@gmail.com (Rob Herring)
Date: Wed, 30 Oct 2013 00:35:26 -0500
Subject: [PATCH -next] arm64: use for_each_node_by_type() macro
In-Reply-To: <CAPgLHd_aQROa0-vycghYz9A9Jx4MbC131C819xPHZg_hrTQC7w@mail.gmail.com>
References: <CAPgLHd_aQROa0-vycghYz9A9Jx4MbC131C819xPHZg_hrTQC7w@mail.gmail.com>
Message-ID: <52709A9E.8060800@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/30/2013 12:25 AM, Wei Yongjun wrote:
> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> 
> Use for_each_node_by_type() macro instead of open coding it.
> 
> Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> ---
>  arch/arm64/kernel/cpu_ops.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/kernel/cpu_ops.c b/arch/arm64/kernel/cpu_ops.c
> index aa0c9e7..37a4977 100644
> --- a/arch/arm64/kernel/cpu_ops.c
> +++ b/arch/arm64/kernel/cpu_ops.c
> @@ -78,10 +78,10 @@ int __init cpu_read_ops(struct device_node *dn, int cpu)
>  
>  void __init cpu_read_bootcpu_ops(void)
>  {
> -	struct device_node *dn = NULL;
> +	struct device_node *dn;
>  	u64 mpidr = cpu_logical_map(0);
>  
> -	while ((dn = of_find_node_by_type(dn, "cpu"))) {
> +	for_each_node_by_type(dn,  "cpu") {
                                  ^
Extra space here.

>  		u64 hwid;
>  		const __be32 *prop;
>  
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
