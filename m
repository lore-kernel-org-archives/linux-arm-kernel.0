From: jason@lakedaemon.net (Jason Cooper)
Date: Tue, 1 Oct 2013 11:01:30 -0400
Subject: [PATCH 3/4] clk: kirkwood: Add CLK_IGNORE_UNUSED to ethernet
 ge0 and ge1 clocks
In-Reply-To: <20131001141716.GE2448@localhost>
References: <1380575010-8573-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1380575010-8573-4-git-send-email-ezequiel.garcia@free-electrons.com>
 <20131001004009.GK31178@titan.lakedaemon.net>
 <20131001134213.GC2448@localhost>
 <20131001135800.GS31178@titan.lakedaemon.net>
 <20131001141716.GE2448@localhost>
Message-ID: <20131001150130.GT31178@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 01, 2013 at 11:17:18AM -0300, Ezequiel Garcia wrote:
> On Tue, Oct 01, 2013 at 09:58:00AM -0400, Jason Cooper wrote:
...
> > However, I think the problem is that the IP block loses it's mac address
> > when gated.  That hasn't been solved, all you're doing is moving the
> > hack/workaround from one place to another less visible place.
> > 
> 
> There's an already existing and clock-framework-specific way of preventing
> a clock from being ever gated -which seems to match exactly this case-
> so I have a hard time seeing why we wouldn't use it.
> 
> Also: I'm wondering why you think this change would 'hide' the clock gating.
> It seems whenever a (future?) developer finds these clocks are not gated,
> one of the first places he will look for is precisely on those flags.

True, I'm approaching it from "I unloaded mv643xx_eth.ko, and my power
draw didn't change.  Let's go look at the driver."  But you are correct.

I'd really like to see if we can extend your patch to having the
driver's probe function detect the mac address in the DT, and change the
IGNORE_UNUSED flag on the clock.  MikeT might have some thoughts on that
since I don't see anyone doing that atm.

thx,

Jason.
