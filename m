From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Wed, 17 Jul 2013 18:53:51 -0400 (EDT)
Subject: [PATCH] irqchip: gic: Don't complain in gic_get_cpumask() if UP
 system
In-Reply-To: <51E71C78.6080604@codeaurora.org>
References: <1373067573-29946-1-git-send-email-sboyd@codeaurora.org>
 <20130712111322.GC3213@e102654-lin.cambridge.arm.com>
 <20130712121023.GB27430@codeaurora.org> <51E71249.4050200@codeaurora.org>
 <alpine.LFD.2.03.1307171830170.14924@syhkavp.arg>
 <51E71C78.6080604@codeaurora.org>
Message-ID: <alpine.LFD.2.03.1307171849180.14924@syhkavp.arg>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 17 Jul 2013, Stephen Boyd wrote:

> On 07/17/13 15:34, Nicolas Pitre wrote:
> > On Wed, 17 Jul 2013, Stephen Boyd wrote:
> >
> >> On 07/12/13 05:10, Stephen Boyd wrote:
> >>> On 07/12, Javi Merino wrote:
> >>>> I agree, we should drop the check.  It's annoying in uniprocessors and
> >>>> unlikely to be found in the real world unless your gic entry in the dt
> >>>> is wrong.
> > And that's a likely outcome in the real world.
> >
> >>> Ok. How about this?
> >> Any comments?
> > What about this instead:
> 
> Unfortunately arm64 doesn't have SMP_ON_UP. 

And why does that matter?

> It sounds like you preferred the first patch using num_possible_cpus()

Probably, yes.  I didn't follow the early conversation though.


Nicolas
