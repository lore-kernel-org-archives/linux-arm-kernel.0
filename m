From: rjw@sisk.pl (Rafael J. Wysocki)
Date: Fri, 22 Mar 2013 00:50:56 +0100
Subject: [PATCH V2] cpufreq: ARM big LITTLE: Add generic cpufreq driver
 and its DT glue
In-Reply-To: <CAKohponV8MR=J8bbNFxGF9JXQB0uadv7iDcbW9D-qr2N53U_kQ@mail.gmail.com>
References: <6cba8f153cfd4b0d3075a34a6dfe287bdec2eb06.1362676407.git.viresh.kumar@linaro.org>
 <513CAD9B.908@gmail.com>
 <CAKohponV8MR=J8bbNFxGF9JXQB0uadv7iDcbW9D-qr2N53U_kQ@mail.gmail.com>
Message-ID: <3782512.fC3ZOYy3MV@vostro.rjw.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday, March 11, 2013 08:57:49 AM Viresh Kumar wrote:
> On 10 March 2013 23:58, Francesco Lavra <francescolavra.fl@gmail.com> wrote:
> > On 03/07/2013 06:14 PM, Viresh Kumar wrote:
> >> +void bL_cpufreq_unregister(struct cpufreq_arm_bL_ops *ops)
> >> +{
> >> +     if (arm_bL_ops != ops) {
> >> +             pr_info("%s: Registered with: %s, can't unregister, exiting\n",
> >> +                             __func__, arm_bL_ops->name);
> >> +     }
> >
> > The code is not doing what the info message says.
> 
> Yes, following is the improvement:

Please post a complete update patch if you want me to take it.  I'd also would
like it to be ACKed by someone involved in the big-LITTLE work on the arch
side.

Thanks,
Rafael


> diff --git a/drivers/cpufreq/arm_big_little.c b/drivers/cpufreq/arm_big_little.c
> index 8b8b07e..9d449cf 100644
> --- a/drivers/cpufreq/arm_big_little.c
> +++ b/drivers/cpufreq/arm_big_little.c
> @@ -264,8 +264,9 @@ EXPORT_SYMBOL_GPL(bL_cpufreq_register);
>  void bL_cpufreq_unregister(struct cpufreq_arm_bL_ops *ops)
>  {
>         if (arm_bL_ops != ops) {
> -               pr_info("%s: Registered with: %s, can't unregister, exiting\n",
> +               pr_err("%s: Registered with: %s, can't unregister, exiting\n",
>                                 __func__, arm_bL_ops->name);
> +               return;
>         }
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
