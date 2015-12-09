From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Wed, 9 Dec 2015 14:49:07 +0530
Subject: [PATCH v5 08/11] ARM: STi: Register CPUFreq device
In-Reply-To: <3682335.fAt9xNcJFr@wuerfel>
References: <1449585124-15596-1-git-send-email-lee.jones@linaro.org>
 <1449585124-15596-9-git-send-email-lee.jones@linaro.org>
 <3682335.fAt9xNcJFr@wuerfel>
Message-ID: <20151209091907.GF28374@ubuntu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09-12-15, 10:15, Arnd Bergmann wrote:
> On Tuesday 08 December 2015 14:32:01 Lee Jones wrote:
> > @@ -161,3 +166,11 @@ struct smp_operations __initdata sti_smp_ops = {
> >         .smp_secondary_init     = sti_secondary_init,
> >         .smp_boot_secondary     = sti_boot_secondary,
> >  };
> > +
> > +/**
> > + * CPUFreq Registration
> > + */
> > +void init_cpufreq(void)
> > +{
> > +       platform_device_register_simple("sti-cpufreq", -1, NULL, 0);
> > +}
> > 
> 
> Can you please do this under drivers/cpufreq somewhere?
> 
> I really don't want to any more of these in platform code. Requiring a
> device to be created just to probe the driver is really silly.

He is actually creating two device right now..

- create sti-cpufreq device
  - so that sti-cpufreq driver get probed
    - And fix OPPs here first and then create cpufreq-dt device
      - so that cpufreq-dt driver get probed

:)

I already recommended him that he can replace the first two points by
doing things from module_init() instead. And then create cpufreq-dt
device.

-- 
viresh
