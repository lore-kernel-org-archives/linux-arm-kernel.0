From: premi@ti.com (Premi, Sanjeev)
Date: Fri, 24 Jun 2011 19:39:41 +0530
Subject: [PATCHv2] omap2+: pm: cpufreq: Fix loops_per_jiffy calculation
In-Reply-To: <20110624140142.GM9449@n2100.arm.linux.org.uk>
References: <1308923618-5333-1-git-send-email-premi@ti.com>
	<20110624140142.GM9449@n2100.arm.linux.org.uk>
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB593024D6C2EF2@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Russell King - ARM Linux [mailto:linux at arm.linux.org.uk] 
> Sent: Friday, June 24, 2011 7:32 PM
> To: Premi, Sanjeev
> Cc: linux-omap at vger.kernel.org; linux-arm-kernel at lists.infradead.org
> Subject: Re: [PATCHv2] omap2+: pm: cpufreq: Fix 
> loops_per_jiffy calculation

[snip]...[snip]

> > 
> > +#ifdef CONFIG_SMP
> > +	/* Adjust jiffies before transition */
> > +	for_each_cpu(i, policy->cpus) {
> > +		unsigned long lpj = per_cpu(cpu_data, 
> i).loops_per_jiffy;
> > +
> > +		per_cpu(cpu_data, i).loops_per_jiffy = 
> cpufreq_scale(lpj,
> > +							freqs.old,
> > +							freqs.new);
> > +	}
> > +#endif
> > +
> 
> You didn't listen to what I told you.  It'll be quicker for 
> me to write
> this patch myself if you send me the *original* file.
> 

Russell,

The function adjust_jiffies() is no-op for CONFIG_SMP - but it
is not the case with cpufreq_scale().

So, when CONFIG_SMP is defined, then loops_per_jiffy would be
calculated for both UP and SMP processors.

Did I miss something else?

~sanjeev


[snip]...[snip]
