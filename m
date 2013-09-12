From: will.deacon@arm.com (Will Deacon)
Date: Thu, 12 Sep 2013 10:37:50 +0100
Subject: KVM virtual timer issue with trinity
In-Reply-To: <20130906163052.GG30450@mudshark.cambridge.arm.com>
References: <20130906163052.GG30450@mudshark.cambridge.arm.com>
Message-ID: <20130912093750.GE15357@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 06, 2013 at 05:30:52PM +0100, Will Deacon wrote:
> Running trinity as a normal user in a KVM guest on my TC2 (A15s only)
> eventually leads to a situation where responsiveness is extremely sluggish.
> Further investigation shows that issuing a `sleep 1' command never returns.
> This seems to be because the virtual timer has stopped generating interrupts
> on CPU0 (CPU1 seems ok).
> 
> Dumping the timer state (see below), it looks like CPU0's timer expired in
> the past, but we're perhaps not receiving the interrupt. The trinity logs
> don't reveal anything obvious (and they're huge, so I can't include them
> here).
> 
> I can reproduce this in an hour or so, so if you want me to try anything out
> in the host, I can give it a go. I'm using 3.11 as both the guest and host.

Any ideas on things I can do to get to the bottom of this? It's preventing
me from running trinity to find any other issues and there's no reason you
couldn't hit this lockup under other workloads.

Will
