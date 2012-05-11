From: tony@atomide.com (Tony Lindgren)
Date: Fri, 11 May 2012 12:51:48 -0700
Subject: [PATCH] pinctrl: Add generic pinctrl-simple driver that
 supports omap2+ padconf
In-Reply-To: <4FAD65D8.30109@wwwdotorg.org>
References: <20120504150342.GI5140@atomide.com>
 <20120504153251.GE7788@game.jcrosoft.org>
 <20120504163420.GA5613@atomide.com>
 <4FA42631.6060304@wwwdotorg.org>
 <20120504220809.GW5613@atomide.com>
 <4FAAD141.3090306@wwwdotorg.org>
 <20120509204925.GV5088@atomide.com> <4FABF553.20601@wwwdotorg.org>
 <20120510172722.GE21851@atomide.com> <4FAD65D8.30109@wwwdotorg.org>
Message-ID: <20120511195147.GW21851@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Stephen Warren <swarren@wwwdotorg.org> [120511 12:21]:
> 
> The mapping of GPIO to pinctrl pins would presumably be driven solely by
> the HW design of the pin controller and GPIO, and not by the mux
> selection in the pin controller (otherwise, I'd argue this isn't a
> simple case that should be handled by pinctrl-simple).
> 
> As such, I'd expect some properties/table at the top-level of the pin
> controller object to describe the GPIO mapping. In turn, that implies
> that the individual per-pin mux-selection/configuration nodes don't need
> to describe any GPIO-related information.

Yes good point. I agree it's a HW design issue, and could be in the properties
for the pin controller object.

Just to summarize, the things to consider with the GPIO to mux mapping are:

1. Having this table as static data in the driver is is not a nice
   solution as it seems that we'd currently need six mapping tables for
   omap2+ alone.

2. This table is not needed for most of the (hundreds of) pins, it's
   only needed for a few selected pins, let's say ten or so on an average
   device. So there's no need to stuff the kernel with information about
   the unused GPIO pins.

It seems that the conclusion here is that we don't need to worry about
GPIOs in the pinctrl-simple binding for now, and it can be added later
without having to change the basic binding.

Regards,

Tony
