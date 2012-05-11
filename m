From: will.deacon@arm.com (Will Deacon)
Date: Fri, 11 May 2012 14:49:21 +0100
Subject: oprofile and ARM A9 hardware counter
In-Reply-To: <4FAD1865.70003@ti.com>
References: <4FA9588E.9020906@ti.com> <87sjfal65t.fsf@ti.com>
 <4FAA4DB9.8060504@ti.com> <4FAAB1A3.9040806@ti.com>
 <4FAAC549.6010206@ti.com> <4FAAE564.6040708@ti.com>
 <20120510084422.GB27276@mudshark.cambridge.arm.com>
 <4FAC0F05.3060803@ti.com>
 <20120511122547.GE17453@mudshark.cambridge.arm.com>
 <4FAD1865.70003@ti.com>
Message-ID: <20120511134920.GC2626@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 11, 2012 at 02:47:17PM +0100, Jon Hunter wrote:
> On 05/11/2012 07:25 AM, Will Deacon wrote:
> > I figured I may as well take perf for a spin and see how I got on. The good
> > news is that the hwmod bits all seem to work as before and the correct IRQs
> > are requested:
> > 
> > root at florentine-pogen:~# cat /proc/interrupts
> >            CPU0       CPU1
> >  29:      44527      17916       GIC  twd
> >  33:          0          0       GIC  arm-pmu
> >  34:          0          0       GIC  arm-pmu
> > 
> > But, unfortunately, as you can see from the above, I just can't persuade them
> > to fire. The PMU counters do tick, but they happily increment through zero
> > without us realising. I retested with my perf/omap4 branch to make sure my
> > board is ok, and the irqs do fire there.
> > 
> > Any ideas?
> 
> Do you disable OMAP2/3 support in the kernel config, so that CPU_HAS_PMU
> is enabled?

I enabled OMAP3 debug peripherals, so I selected CPU_HAS_PMU that way.

Will
