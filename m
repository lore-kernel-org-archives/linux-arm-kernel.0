From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Thu, 7 Aug 2014 17:29:34 +0200
Subject: [PATCH] cpufreq: arm_big_little: fix module license spec
In-Reply-To: <mvmiom48knf.fsf@hawking.suse.de>
References: <mvmmwbqateb.fsf@hawking.suse.de>
 <1406792216-827-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <mvmiom48knf.fsf@hawking.suse.de>
Message-ID: <20140807152934.GT1933@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 07, 2014 at 04:00:20PM +0200, Andreas Schwab wrote:
> Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de> writes:
> 
> > Having no license specification in a module taints the kernel during load
> > with:
> >
> > 	arm_big_little: module license 'unspecified' taints kernel.
> >
> > and also the linker doesn't allow it to make use of GPL-exported symbols
> > which in this case also results in errors like:
> >
> > 	arm_big_little: Unknown symbol cpufreq_register_driver (err 0)
> >
> > . The header of the driver specifies a GPL v2 license, so note that
> > accordingly. While at it also add a description and an author and fix
> > the license in a companion file to explicit v2.
> >
> > Reported-by: Andreas Schwab <schwab@suse.de>
> > Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> > ---
> >  drivers/cpufreq/arm_big_little.c    | 4 ++++
> >  drivers/cpufreq/arm_big_little_dt.c | 2 +-
> >  2 files changed, 5 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/cpufreq/arm_big_little.c b/drivers/cpufreq/arm_big_little.c
> > index 1f4d4e315057..b600f3107bef 100644
> > --- a/drivers/cpufreq/arm_big_little.c
> > +++ b/drivers/cpufreq/arm_big_little.c
> > @@ -593,3 +593,7 @@ void bL_cpufreq_unregister(struct cpufreq_arm_bL_ops *ops)
> >  	arm_bL_ops = NULL;
> >  }
> >  EXPORT_SYMBOL_GPL(bL_cpufreq_unregister);
> > +
> > +MODULE_AUTHOR("Viresh Kumar <viresh.kumar@linaro.org>");
> > +MODULE_DESCRIPTION("Generic ARM big LITTLE cpufreq driver");
> > +MODULE_LICENSE("GPL v2");
> 
> drivers/cpufreq/arm_big_little.c:613:15: error: expected declaration specifiers or ?...? before string constant
>  MODULE_AUTHOR("Viresh Kumar <viresh.kumar@linaro.org>");
>                ^
> drivers/cpufreq/arm_big_little.c:614:20: error: expected declaration specifiers or ?...? before string constant
>  MODULE_DESCRIPTION("Generic ARM big LITTLE cpufreq driver");
>                     ^
> drivers/cpufreq/arm_big_little.c:615:16: error: expected declaration specifiers or ?...? before string constant
>  MODULE_LICENSE("GPL v2");
>                 ^
> 
Does adding

	#include <linux/module.h>

in that file fix the problem?

Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
