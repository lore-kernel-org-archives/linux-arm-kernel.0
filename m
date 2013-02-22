From: fweisbec@gmail.com (Frederic Weisbecker)
Date: Fri, 22 Feb 2013 14:38:37 +0100
Subject: [PATCH 1/2] cpustat: use accessor functions for get/set/add
In-Reply-To: <1361512604-2720-2-git-send-email-khilman@linaro.org>
References: <1361512604-2720-1-git-send-email-khilman@linaro.org>
 <1361512604-2720-2-git-send-email-khilman@linaro.org>
Message-ID: <20130222133835.GF17948@somewhere.redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Looks good, just a minor neat:

On Thu, Feb 21, 2013 at 09:56:43PM -0800, Kevin Hilman wrote:
> diff --git a/include/linux/kernel_stat.h b/include/linux/kernel_stat.h
> index 66b7078..df8ad75 100644
> --- a/include/linux/kernel_stat.h
> +++ b/include/linux/kernel_stat.h
> @@ -32,7 +32,7 @@ enum cpu_usage_stat {
>  };
>  
>  struct kernel_cpustat {
> -	u64 cpustat[NR_STATS];
> +	u64 _cpustat[NR_STATS];

Why do you need the underscore?
