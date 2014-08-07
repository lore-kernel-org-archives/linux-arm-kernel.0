From: schwab@suse.de (Andreas Schwab)
Date: Thu, 07 Aug 2014 16:00:20 +0200
Subject: [PATCH] cpufreq: arm_big_little: fix module license spec
In-Reply-To: <1406792216-827-1-git-send-email-u.kleine-koenig@pengutronix.de>
 ("Uwe =?utf-8?Q?Kleine-K=C3=B6nig=22's?= message of "Thu, 31 Jul 2014
 09:36:56 +0200")
References: <mvmmwbqateb.fsf@hawking.suse.de>
 <1406792216-827-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <mvmiom48knf.fsf@hawking.suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de> writes:

> Having no license specification in a module taints the kernel during load
> with:
>
> 	arm_big_little: module license 'unspecified' taints kernel.
>
> and also the linker doesn't allow it to make use of GPL-exported symbols
> which in this case also results in errors like:
>
> 	arm_big_little: Unknown symbol cpufreq_register_driver (err 0)
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
>  	arm_bL_ops = NULL;
>  }
>  EXPORT_SYMBOL_GPL(bL_cpufreq_unregister);
> +
> +MODULE_AUTHOR("Viresh Kumar <viresh.kumar@linaro.org>");
> +MODULE_DESCRIPTION("Generic ARM big LITTLE cpufreq driver");
> +MODULE_LICENSE("GPL v2");

drivers/cpufreq/arm_big_little.c:613:15: error: expected declaration specifiers or ?...? before string constant
 MODULE_AUTHOR("Viresh Kumar <viresh.kumar@linaro.org>");
               ^
drivers/cpufreq/arm_big_little.c:614:20: error: expected declaration specifiers or ?...? before string constant
 MODULE_DESCRIPTION("Generic ARM big LITTLE cpufreq driver");
                    ^
drivers/cpufreq/arm_big_little.c:615:16: error: expected declaration specifiers or ?...? before string constant
 MODULE_LICENSE("GPL v2");
                ^

Andreas.

-- 
Andreas Schwab, SUSE Labs, schwab at suse.de
GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."
