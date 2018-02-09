From: tony@atomide.com (Tony Lindgren)
Date: Fri, 9 Feb 2018 12:54:22 -0800
Subject: [PATCH] ARM: OMAP2+: Handle errors from cpu_pm_enter()
In-Reply-To: <b00819ef-2daf-6209-c6e4-4c27d1074b94@ti.com>
References: <20180209174739.31072-1-tony@atomide.com>
 <b00819ef-2daf-6209-c6e4-4c27d1074b94@ti.com>
Message-ID: <20180209205422.GC4383@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Grygorii Strashko <grygorii.strashko@ti.com> [180209 20:09]:
> On 02/09/2018 11:47 AM, Tony Lindgren wrote:
> > @@ -196,18 +199,18 @@ static int omap_enter_idle_coupled(struct cpuidle_device *dev,
> >   		}
> >   	}
> > -	/*
> > -	 * Call idle CPU PM exit notifier chain to restore
> > -	 * VFP and per CPU IRQ context.
> > -	 */
> > -	cpu_pm_exit();
> > -
> >   	/*
> >   	 * Call idle CPU cluster PM exit notifier chain
> >   	 * to restore GIC and wakeupgen context.
> >   	 */
> >   	if (dev->cpu == 0 && mpuss_can_lose_context)
> >   		cpu_cluster_pm_exit();
> > +cpu_pm_out:
> > +	/*
> > +	 * Call idle CPU PM exit notifier chain to restore
> > +	 * VFP and per CPU IRQ context.
> > +	 */
> > +	cpu_pm_exit();
> 
> It looks ok, in general, but you've changed order of calls here,
> so may be commit message need to be updated

Hmm yeah good point, that's how it's usually done. I'll check
and update the description like you suggested.

Regards,

Tony
