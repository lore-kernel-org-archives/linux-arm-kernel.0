From: sean.wang@mediatek.com (Sean Wang)
Date: Fri, 23 Feb 2018 10:22:10 +0800
Subject: [PATCH] cpufreq: mediatek: Convert pr_warn() to pr_debug()
In-Reply-To: <5bc4db542fa521c32d295f490a1ad1dadf715098.1519278976.git.viresh.kumar@linaro.org>
References: <5bc4db542fa521c32d295f490a1ad1dadf715098.1519278976.git.viresh.kumar@linaro.org>
Message-ID: <1519352530.9025.63.camel@mtkswgap22>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2018-02-22 at 11:26 +0530, Viresh Kumar wrote:
> With multi-platform build images, this shows a message on non mediatek
> platforms, which is unnecessary. Convert pr_warn() to pr_debug() here.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/cpufreq/mediatek-cpufreq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/mediatek-cpufreq.c b/drivers/cpufreq/mediatek-cpufreq.c
> index 8c04dddd3c28..84d658d57029 100644
> --- a/drivers/cpufreq/mediatek-cpufreq.c
> +++ b/drivers/cpufreq/mediatek-cpufreq.c
> @@ -578,7 +578,7 @@ static int __init mtk_cpufreq_driver_init(void)
>  	match = of_match_node(mtk_cpufreq_machines, np);
>  	of_node_put(np);
>  	if (!match) {
> -		pr_warn("Machine is not compatible with mtk-cpufreq\n");
> +		pr_debug("Machine is not compatible with mtk-cpufreq\n");
>  		return -ENODEV;
>  	}
>  

Acked-by: Sean Wang <sean.wang@mediatek.com>
