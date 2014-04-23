From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Wed, 23 Apr 2014 17:32:28 +0100
Subject: [Patch v2 2/4] driver: cpuidle: cpuidle-big-little: init driver
 for Exynos5420
In-Reply-To: <1398245154-18771-3-git-send-email-chander.kashyap@linaro.org>
References: <1398080958-21677-5-git-send-email-chander.kashyap@linaro.org>
 <1398245154-18771-1-git-send-email-chander.kashyap@linaro.org>
 <1398245154-18771-3-git-send-email-chander.kashyap@linaro.org>
Message-ID: <20140423163228.GC1243@e102568-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 23, 2014 at 10:25:52AM +0100, Chander Kashyap wrote:
> Add "samsung,exynos5420" compatible string to initialize generic
> big-little cpuidle driver for Exynos5420.
> 
> Signed-off-by: Chander Kashyap <chander.kashyap@linaro.org>
> Signed-off-by: Chander Kashyap <k.chander@samsung.com>
> Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  drivers/cpuidle/cpuidle-big_little.c |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cpuidle/cpuidle-big_little.c b/drivers/cpuidle/cpuidle-big_little.c
> index b45fc62..d0fac53 100644
> --- a/drivers/cpuidle/cpuidle-big_little.c
> +++ b/drivers/cpuidle/cpuidle-big_little.c
> @@ -170,7 +170,8 @@ static int __init bl_idle_init(void)
>  	/*
>  	 * Initialize the driver just for a compliant set of machines
>  	 */
> -	if (!of_machine_is_compatible("arm,vexpress,v2p-ca15_a7"))
> +	if (!of_machine_is_compatible("arm,vexpress,v2p-ca15_a7") &&
> +		(!of_machine_is_compatible("samsung,exynos5420")))
>  		return -ENODEV;

We should handle the string matching differently, we can't keep adding
comparisons.

Daniel raised the point already: what about the idle tables (data and
number of states ?). TC2 has just a cluster state, and specific
latencies, which are highly unlikely to be correct for this platform.

Lorenzo
