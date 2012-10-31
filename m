From: rjw@sisk.pl (Rafael J. Wysocki)
Date: Wed, 31 Oct 2012 01:44:50 +0100
Subject: [PATCH] cpufreq: Avoid calling cpufreq driver's target() routine
 if target_freq == policy->cur
In-Reply-To: <5056958.0bPciFrxt5@vostro.rjw.lan>
References: <1d7b6e421a335255da956804b43ce3517538409c.1351244153.git.viresh.kumar@linaro.org>
 <5056958.0bPciFrxt5@vostro.rjw.lan>
Message-ID: <11869950.r5dVYWTkdx@vostro.rjw.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday, October 26, 2012 01:17:12 PM Rafael J. Wysocki wrote:
> On Friday, October 26, 2012 03:06:26 PM Viresh Kumar wrote:
> > Avoid calling cpufreq driver's target() routine if new frequency is same as
> > policies current frequency.
> > 
> > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> 
> Looks reasonable.
> 
> Any objection from anyone?

OK, no objections.

Applied to the linux-next branch of linux-pm.git as v3.8 material.

Thanks,
Rafael


> > ---
> >  drivers/cpufreq/cpufreq.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> > index 261ef65..28dc134 100644
> > --- a/drivers/cpufreq/cpufreq.c
> > +++ b/drivers/cpufreq/cpufreq.c
> > @@ -1476,6 +1476,10 @@ int __cpufreq_driver_target(struct cpufreq_policy *policy,
> >  
> >  	pr_debug("target for CPU %u: %u kHz, relation %u\n", policy->cpu,
> >  		target_freq, relation);
> > +
> > +	if (target_freq == policy->cur)
> > +		return 0;
> > +
> >  	if (cpu_online(policy->cpu) && cpufreq_driver->target)
> >  		retval = cpufreq_driver->target(policy, target_freq, relation);
> >  
> > 
> 
-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
