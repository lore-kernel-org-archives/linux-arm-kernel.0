From: horms@verge.net.au (Simon Horman)
Date: Thu, 20 Oct 2011 17:08:24 +0900
Subject: Possible regression in kexec on ARM ARMv6 and ARMv7 cores
In-Reply-To: <20111020070105.GA28548@mudshark.cambridge.arm.com>
References: <20111020042444.GA20260@verge.net.au>
	<20111020070105.GA28548@mudshark.cambridge.arm.com>
Message-ID: <20111020080823.GA2716@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 20, 2011 at 08:01:06AM +0100, Will Deacon wrote:
> On Thu, Oct 20, 2011 at 05:24:45AM +0100, Simon Horman wrote:
> > Hi Will, Hi All,
> 
> Hi Simon,

Hi Will,

> > it appears that "ARM: proc: add definition of cpu_reset for
> >  ARMv6 and ARMv7 cores" (f4daf06fc23b99df5ca5b3e892428b91e148cc52),
> > which was introduced for 3.1-rc1, causes a regression and that
> > kexec no longer works on ARM. The board that I am testing
> > on is a Renesas Mackerel which has an SH7372 (ARMv7) processor.
> 
> Wow, I'm surprised the old code worked at all on an ARMv7 CPU! It's certainly
> highly unlikely to work by the letter of the architecture, so I guess the
> planets aligned in just the right way for your particular implementation.
> 
> Please can you try my kexec/mmu-off patches? They should add the bits and
> pieces you need for kexec to work reliably on a UP system. I plan to finish
> these off next week in Prague so hopefully they'll hit mainline in the near
> future.
> 
> https://github.com/wdeacon/linux-wd/commits/kexec/mmu-off

Thanks, I will try your patches and let you know how I go.

You mention UP in particular, which I will test.
Do you have any thoughts on SMP?
