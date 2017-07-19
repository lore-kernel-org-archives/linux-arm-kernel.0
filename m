From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Wed, 19 Jul 2017 12:08:40 +0530
Subject: [PATCH] cpufreq: Convert to using %pOF instead of full_name
In-Reply-To: <20170718214339.7774-14-robh@kernel.org>
References: <20170718214339.7774-14-robh@kernel.org>
Message-ID: <20170719063840.GD352@vireshk-i7>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18-07-17, 16:42, Rob Herring wrote:
> Now that we have a custom printf format specifier, convert users of
> full_name to use %pOF instead. This is preparation to remove storing
> of the full path string for each node.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Patrice Chotard <patrice.chotard@st.com>
> Cc: linux-pm at vger.kernel.org
> Cc: linuxppc-dev at lists.ozlabs.org
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: kernel at stlinux.com
> ---
>  drivers/cpufreq/pmac64-cpufreq.c | 2 +-
>  drivers/cpufreq/sti-cpufreq.c    | 8 ++++----
>  2 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/cpufreq/pmac64-cpufreq.c b/drivers/cpufreq/pmac64-cpufreq.c
> index 267e0894c62d..be623dd7b9f2 100644
> --- a/drivers/cpufreq/pmac64-cpufreq.c
> +++ b/drivers/cpufreq/pmac64-cpufreq.c
> @@ -516,7 +516,7 @@ static int __init g5_pm72_cpufreq_init(struct device_node *cpunode)
>  		goto bail;
>  	}
> 
> -	DBG("cpufreq: i2c clock chip found: %s\n", hwclock->full_name);
> +	DBG("cpufreq: i2c clock chip found: %pOF\n", hwclock);
> 
>  	/* Now get all the platform functions */
>  	pfunc_cpu_getfreq =
> diff --git a/drivers/cpufreq/sti-cpufreq.c b/drivers/cpufreq/sti-cpufreq.c
> index d2d0430d09d4..47105735df12 100644
> --- a/drivers/cpufreq/sti-cpufreq.c
> +++ b/drivers/cpufreq/sti-cpufreq.c
> @@ -65,8 +65,8 @@ static int sti_cpufreq_fetch_major(void) {
>  	ret = of_property_read_u32_index(np, "st,syscfg",
>  					 MAJOR_ID_INDEX, &major_offset);
>  	if (ret) {
> -		dev_err(dev, "No major number offset provided in %s [%d]\n",
> -			np->full_name, ret);
> +		dev_err(dev, "No major number offset provided in %pOF [%d]\n",
> +			np, ret);
>  		return ret;
>  	}
> 
> @@ -92,8 +92,8 @@ static int sti_cpufreq_fetch_minor(void)
>  					 MINOR_ID_INDEX, &minor_offset);
>  	if (ret) {
>  		dev_err(dev,
> -			"No minor number offset provided %s [%d]\n",
> -			np->full_name, ret);
> +			"No minor number offset provided %pOF [%d]\n",
> +			np, ret);
>  		return ret;
>  	}

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
