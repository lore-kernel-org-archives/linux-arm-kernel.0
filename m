From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Fri, 11 Oct 2013 10:17:50 -0700
Subject: KVM virtual timer issue with trinity
In-Reply-To: <20131009110039.GD6564@mudshark.cambridge.arm.com>
References: <20130906163052.GG30450@mudshark.cambridge.arm.com>
 <20130912093750.GE15357@mudshark.cambridge.arm.com>
 <20130912152716.GP9860@cbox>
 <20131009110039.GD6564@mudshark.cambridge.arm.com>
Message-ID: <20131011171750.GF5108@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 09, 2013 at 12:00:39PM +0100, Will Deacon wrote:
> On Thu, Sep 12, 2013 at 04:27:16PM +0100, Christoffer Dall wrote:
> > On Thu, Sep 12, 2013 at 10:37:50AM +0100, Will Deacon wrote:
> > > On Fri, Sep 06, 2013 at 05:30:52PM +0100, Will Deacon wrote:
> > > > Running trinity as a normal user in a KVM guest on my TC2 (A15s only)
> > > > eventually leads to a situation where responsiveness is extremely sluggish.
> > > > Further investigation shows that issuing a `sleep 1' command never returns.
> > > > This seems to be because the virtual timer has stopped generating interrupts
> > > > on CPU0 (CPU1 seems ok).
> > > > 
> > > > Dumping the timer state (see below), it looks like CPU0's timer expired in
> > > > the past, but we're perhaps not receiving the interrupt. The trinity logs
> > > > don't reveal anything obvious (and they're huge, so I can't include them
> > > > here).
> > > > 
> > > > I can reproduce this in an hour or so, so if you want me to try anything out
> > > > in the host, I can give it a go. I'm using 3.11 as both the guest and host.
> > > 
> > > Any ideas on things I can do to get to the bottom of this? It's preventing
> > > me from running trinity to find any other issues and there's no reason you
> > > couldn't hit this lockup under other workloads.
> > > 
> > I've been thinking on this, sorry about the late response.
> > 
> > I see something similar when resuming a suspended guest, but I don't
> > have very clever ideas or debug strategies yet.  I plan on looking at
> > this once I get a new revision of the save/restore QEMU patches out.
> 
> Marc was saying that you'd managed to resolve the issue with suspend, but I
> can still reproduce the issue with trinity on a 3.12-rc4 kernel (host and
> guest).

Yeah, that issue turned out to be simply overwriting the restored
counter values.  I need to look at this some more, still present in my
todo list...

> 
> I tried to reproduce in a model, but I ran into a bunch of other unrelated
> problems that look like bugs in the model itself.
> 
Great...

-Christoffer
