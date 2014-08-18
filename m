From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Mon, 18 Aug 2014 13:29:53 +0530
Subject: [PATCH] cpufreq: exynos: free memory immediately on unknown SoC
In-Reply-To: <1408248374-1638-1-git-send-email-arjun024@gmail.com>
References: <1408248374-1638-1-git-send-email-arjun024@gmail.com>
Message-ID: <CAKohpoke=3vGOoQ9s0snYKZxA_5xMuPtGfAS9uJp1xLJnBwuEA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17 August 2014 09:36, Arjun Sreedharan <arjun024@gmail.com> wrote:
> Signed-off-by: Arjun Sreedharan <arjun024@gmail.com>
> ---
>  drivers/cpufreq/exynos-cpufreq.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/cpufreq/exynos-cpufreq.c b/drivers/cpufreq/exynos-cpufreq.c
> index 1e0ec57..e47d165 100644
> --- a/drivers/cpufreq/exynos-cpufreq.c
> +++ b/drivers/cpufreq/exynos-cpufreq.c
> @@ -178,6 +178,7 @@ static int exynos_cpufreq_probe(struct platform_device *pdev)
>                 ret = exynos5250_cpufreq_init(exynos_info);
>         } else {
>                 pr_err("%s: Unknown SoC type\n", __func__);
> +               kfree(exynos_info);
>                 return -ENODEV;
>         }

Apart from the fact that we could have added some logs and improved
$subject a bit,
it looks fine.

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
