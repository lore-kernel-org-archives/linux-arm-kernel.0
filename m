From: jg1.han@samsung.com (Jingoo Han)
Date: Thu, 20 Mar 2014 17:22:41 +0900
Subject: please revert: regulator: dbx500: use seq_puts() instead of
 seq_printf()
In-Reply-To: <6651295.YIkvtDO9zo@wuerfel>
References: <6651295.YIkvtDO9zo@wuerfel>
Message-ID: <001001cf4415$902bdf30$b0839d90$%han@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday, March 20, 2014 4:57 PM, Arnd Bergmann wrote:
> 
> This patch has shown up in linux-next yesterday, breaking a randconfig
> build:

(+cc Fengguang Wu)

Hi Arnd,

I really appreciate your report.
However, it was already reported by Fengguang Wu 2 days ago.
And, a modified patch was already merged to the current regulator
next tree. 

Thus, today's linux-next (20140320) cannot make the problem
anymore. As presented above, the modified patch was merged
to today's linux-next. [1]

I will be more careful next time. Sorry for annoying you.
Thank you.

[1] http://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git/commit/?id=80c48e72f831bbfea4bf58d8e78ff2b18c90ec17)

Best regards,
Jingoo Han

> 
> commit d5d2ced88dc2690cf28fd531c83a53f0ba132f27
> Author: Jingoo Han <jg1.han@samsung.com>
> Date:   Wed Feb 26 10:21:01 2014 +0900
> 
>     regulator: dbx500: use seq_puts() instead of seq_printf()
> 
>     For a constant format without additional arguments, use seq_puts()
>     instead of seq_printf(). Also, it fixes the following checkpatch
>     warning.
> 
>       WARNING: Prefer seq_puts to seq_printf
> 
>     Signed-off-by: Jingoo Han <jg1.han@samsung.com>
>     Signed-off-by: Mark Brown <broonie@linaro.org>
> 
> diff --git a/drivers/regulator/dbx500-prcmu.c b/drivers/regulator/dbx500-prcmu.c
> index f111dfb..3dd1096 100644
> --- a/drivers/regulator/dbx500-prcmu.c
> +++ b/drivers/regulator/dbx500-prcmu.c
> @@ -97,10 +97,10 @@ static int ux500_regulator_power_state_cnt_print(struct seq_file *s, void *p)
>         int err;
> 
>         /* print power state count */
> -       err = seq_printf(s, "ux500-regulator power state count: %i\n",
> -               power_state_active_get());
> +       err = seq_puts(s, "ux500-regulator power state count: %i\n",
> +                       power_state_active_get());
>         if (err < 0)
> -               dev_err(dev, "seq_printf overflow\n");
> +               dev_err(dev, "seq_puts overflow\n");
> 
>         return 0;
>  }
> 
> drivers/regulator/dbx500-prcmu.c:103:4: error: too many arguments to function 'seq_puts'
> 
> The other half of the patch is ok though.
> 
> 	Arnd
