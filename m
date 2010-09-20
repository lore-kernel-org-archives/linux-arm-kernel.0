From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 20 Sep 2010 10:50:01 +0100
Subject: [PATCH] regulator: Add support samsung power domain
In-Reply-To: <009d01cb588a$d45ce520$7d16af60$%kim@samsung.com>
References: <1284717532-9992-1-git-send-email-kgene.kim@samsung.com>
	<20100917113050.GA4322@rakim.wolfsonmicro.main>
	<009d01cb588a$d45ce520$7d16af60$%kim@samsung.com>
Message-ID: <20100920095001.GB31167@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 20, 2010 at 03:12:34PM +0900, Kukjin Kim wrote:

> The reason the implementation is located in machine-specific code is that
> the way to handle power domain in S5PV210 and S5PV310 is different but we
> can handle this using platform_device_id.

Yes, I think it's reasonable to implement stuff under arch/arm - my only
issue with what you'd done was that I didn't feel the glue layer was
adding anything.

> > Another option to consider here is using runtime PM - other platforms
> > seem to be going down that route, and are using it to also factor clock
> > management for the IP blocks out (so that the block's clocks get enabled
> > and disabled automatically when the block is active without needing any
> > code in the driver).

> To use runtime PM cannot be a substitute for using regulator API.
> It's related to when to control the power domain whether using regulator API
> is to how to control the power domain.

The runtime PM API will give you very similar reference counting to the
regulator API, for all you're using the regulator API for here there's
not a massive difference.  If you started using voltage scaling then
there'd be more win.

> We have a plan to support runtime PM using regulator API.
> Am I on the right track ?

That's doable.
