From: mingo@elte.hu (Ingo Molnar)
Date: Sat, 11 Feb 2012 15:45:30 +0100
Subject: [PATCH RFC 0/4] Scheduler idle notifiers and users
In-Reply-To: <4F35DD3E.4020406@codeaurora.org>
References: <20120208013959.GA24535@panacea> <1328670355.2482.68.camel@laptop>
 <20120208202314.GA28290@redhat.com>
 <1328736834.2903.33.camel@pasglop> <20120209075106.GB18387@elte.hu>
 <4F35DD3E.4020406@codeaurora.org>
Message-ID: <20120211144530.GA497@elte.hu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


* Saravana Kannan <skannan@codeaurora.org> wrote:

> When you say accommodate all hardware, does it mean we will 
> keep around CPUfreq and allow attempts at improving it? Or we 
> will completely move to scheduler based CPU freq scaling, but 
> won't try to force atomicity? Say, may be queue up a 
> notification to a CPU driver to scale up the frequency as soon 
> as it can?

I don't think we should (or even could) force atomicity - we 
adapt to whatever the hardware can do.

But the design should be directed at systems where frequency 
changes can be done in a reasonably fast manner. That is what he 
future is - any change we initiate today takes years to reach 
actual products/systems.

> IMHO, I think the problem with CPUfreq and its dynamic 
> governors today is that they do a timer based sampling of the 
> CPU load instead of getting some hints from the scheduler when 
> the scheduler knows that the load average is quite high.

Yes - that is one of the "frequency changes are slow" 
assumptions - which is wrong.

Thanks,

	Ingo
