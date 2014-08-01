From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Fri, 1 Aug 2014 14:52:49 +0530
Subject: [PATCH] cpufreq: arm_big_little: fix module license spec
In-Reply-To: <1406792216-827-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <mvmmwbqateb.fsf@hawking.suse.de>
 <1406792216-827-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <CAKohpokVOZhZ3j+mxkX0ogP_Dk=WtmfgJavzMV1EZ3WWgi-AiA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 31 July 2014 13:06, Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de> wrote:
> Having no license specification in a module taints the kernel during load
> with:
>
>         arm_big_little: module license 'unspecified' taints kernel.
>
> and also the linker doesn't allow it to make use of GPL-exported symbols
> which in this case also results in errors like:
>
>         arm_big_little: Unknown symbol cpufreq_register_driver (err 0)
>
> . The header of the driver specifies a GPL v2 license, so note that
> accordingly. While at it also add a description and an author and fix
> the license in a companion file to explicit v2.
>
> Reported-by: Andreas Schwab <schwab@suse.de>
> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/cpufreq/arm_big_little.c    | 4 ++++
>  drivers/cpufreq/arm_big_little_dt.c | 2 +-
>  2 files changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/cpufreq/arm_big_little.c b/drivers/cpufreq/arm_big_little.c
> index 1f4d4e315057..b600f3107bef 100644
> --- a/drivers/cpufreq/arm_big_little.c
> +++ b/drivers/cpufreq/arm_big_little.c
> @@ -593,3 +593,7 @@ void bL_cpufreq_unregister(struct cpufreq_arm_bL_ops *ops)
>         arm_bL_ops = NULL;
>  }
>  EXPORT_SYMBOL_GPL(bL_cpufreq_unregister);
> +
> +MODULE_AUTHOR("Viresh Kumar <viresh.kumar@linaro.org>");
> +MODULE_DESCRIPTION("Generic ARM big LITTLE cpufreq driver");
> +MODULE_LICENSE("GPL v2");
> diff --git a/drivers/cpufreq/arm_big_little_dt.c b/drivers/cpufreq/arm_big_little_dt.c
> index 8d9d59108906..4550f6976768 100644
> --- a/drivers/cpufreq/arm_big_little_dt.c
> +++ b/drivers/cpufreq/arm_big_little_dt.c
> @@ -114,4 +114,4 @@ module_platform_driver(generic_bL_platdrv);
>
>  MODULE_AUTHOR("Viresh Kumar <viresh.kumar@linaro.org>");
>  MODULE_DESCRIPTION("Generic ARM big LITTLE cpufreq driver via DT");
> -MODULE_LICENSE("GPL");
> +MODULE_LICENSE("GPL v2");

Thanks..

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
