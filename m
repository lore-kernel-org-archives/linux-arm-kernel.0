From: will.deacon@arm.com (Will Deacon)
Date: Tue, 24 Jul 2012 10:15:05 +0100
Subject: [PATCH v2 2/2] ARM: delay: allow timer-based delay
 implementation to be selected
In-Reply-To: <500E657E.8070301@renesas.com>
References: <20120713085746.GA18079@mudshark.cambridge.arm.com>
 <CAMQu2gwPm_Y1as6dc4S-f9OEOZA32CCNKv_07MB+U7T4OS6qXg@mail.gmail.com>
 <20120713111337.GH18079@mudshark.cambridge.arm.com>
 <5004D78E.4050606@renesas.com>
 <CAMQu2gx9EU4GZ634RKiwD+sg0MoO-FAqc-pPU+HkryX8rXVBjA@mail.gmail.com>
 <5005176C.6050904@renesas.com>
 <20120718175233.GB16928@mudshark.cambridge.arm.com>
 <50082598.5090706@arm.com>
 <20120720101751.GB26658@mudshark.cambridge.arm.com>
 <500E657E.8070301@renesas.com>
Message-ID: <20120724091505.GB16435@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 24, 2012 at 10:06:06AM +0100, Shinya Kuribayashi wrote:
> Hi Will, Jonathan,
> 
> On 7/20/2012 7:17 PM, Will Deacon wrote:
> > On Thu, Jul 19, 2012 at 04:19:52PM +0100, Jonathan Austin wrote:
> >> We should probably also ignore and additional registration calls, not just
> >> those made after the delay loop has been calibrated...
> >>
> >> Something like the patch below should do the trick.
> > 
> > [...]
> > 
> > Cheers, pushed into my delay branch.
> 
> Thanks for the registration machanism.  It looks nice, and works for
> me on a Cortex-A9 SMP platform with a non-arch_timer counter.

That's good to hear, thanks.

> I've picked up a revised version of the patch from will/delay and
> merged it into our local development branch.  We'll give it a try
> in different conditions, UP and SMP, with/without DVFS and so on,
> and let you know if I find anything.

Great! If everything looks good, and you're interested in using this in
mainline, I could push the registration for 3.7. I just don't want to see it
there if nobody's using it.

Will
