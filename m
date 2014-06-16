From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Mon, 16 Jun 2014 10:48:30 -0400 (EDT)
Subject: [PATCH v4 1/6] Documentation: arm: define DT idle states bindings
In-Reply-To: <20140616142259.GA6650@e102568-lin.cambridge.arm.com>
References: <1402503520-8611-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1402503520-8611-2-git-send-email-lorenzo.pieralisi@arm.com>
 <alpine.LFD.2.11.1406111240010.25775@knanqh.ubzr>
 <20140613164954.GA16745@e102568-lin.cambridge.arm.com>
 <alpine.LFD.2.11.1406131306160.25775@knanqh.ubzr>
 <20140616142259.GA6650@e102568-lin.cambridge.arm.com>
Message-ID: <alpine.LFD.2.11.1406161044180.31631@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 16 Jun 2014, Lorenzo Pieralisi wrote:

> On Fri, Jun 13, 2014 at 06:33:35PM +0100, Nicolas Pitre wrote:
> > >    idle_state.exit_latency = worst-wakeup-latency
> > >    idle_state.target_residency = min-residency-us
> > 
> > But exit_latency is not necessarily equal to worst-wakeup-latency.  
> > We'll need any of those 4 values depending on the context.  So I'd add 
> > entry_latency and worst_wakeup_latency to struct cpuidle_state.  If a 
> > driver doesn't initialize entry_latency then it can be left to 0, and if 
> > worst_wakeup_latency is 0 then it should be set to entry_latency + 
> > exit_latency by the core code.
> 
> Well, that's why I mentioned idle_state.exit_latency, because in CPUidle
> today, the struct cpuidle_state.exit_latency field corresponds to our
> worst-wakeup-latency property, not to the exit_latency property; I know
> it is confusing but at least by defining proper bindings the kernel
> structures can be updated with clear semantics (I would not rename them
> for the time being though).

Why not?  Adding more confusion or even simply keeping the existing one, 
even if it is temporary, doesn't benefit anyone.

> Fields required by the scheduler (ie entry_latency) can be added in 
> the patches that rely on them, when we agreed on the bindings, adding 
> the variables is no big deal.

Sure.


Nicolas
