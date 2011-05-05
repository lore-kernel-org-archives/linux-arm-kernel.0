From: tony@atomide.com (Tony Lindgren)
Date: Thu, 5 May 2011 09:00:13 +0300
Subject: [PATCH 1/8] OMAP PM: create a PM layer plugin for per-device
	constraints
In-Reply-To: <87vcxqv8fp.fsf@ti.com>
References: <1304516117-9334-1-git-send-email-j-pihet@ti.com>
	<1304516117-9334-2-git-send-email-j-pihet@ti.com>
	<20110504135930.GE2092@atomide.com> <87vcxqv8fp.fsf@ti.com>
Message-ID: <20110505060013.GJ27860@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Kevin Hilman <khilman@ti.com> [110504 17:33]:
> Tony,
> 
> Tony Lindgren <tony@atomide.com> writes:
> 
> > * jean.pihet at newoldbits.com <jean.pihet@newoldbits.com> [110504 06:32]:
> >>
> >> +int omap_pm_set_max_mpu_wakeup_lat(struct device *dev, long t)
> > ...
> >
> >> +int omap_pm_set_max_dev_wakeup_lat(struct device *req_dev, struct device *dev,
> > ...
> >
> >> +int omap_pm_set_min_clk_rate(struct device *dev, struct clk *c, long r)
> > ...
> >
> > You should implement this as a Linux generic framework, we don't
> > want to add more omap specific frameworks.
> 
> This series isn't adding any new OMAP-specific frameworks.  The OMAP PM
> layer is already in place, and has been there for awhile.  OMAP PM is a
> layer which can have "plugins" so we can experiment with ways of
> handling constraints without changing the driver interface, and this
> series is just implementing a new plugin.

But in this case the plugin is just stubs. The only function that does
something is omap_pm_get_dev_context_loss_count. And then patch 8 in
this series starts adding a new omap specific features for constraints.

So the problem is patches 1 & 8 in this series. The rest is just fine
as it's the necessary omap hardware specific implementation.

> Once we are happy with a constraint layer, and can prove it will work,
> the plan is to get rid of the (existing) OMAP-specific APIs and propose
> a generic interface.

Well I don't think we should start building new omap specific layer on
an omap specific framework.

Instead, the constraint layer should be made generic to start with, even
if it's just a minimal implementation initially.

Maybe it could be just a generic header file to start with?

Regards,

Tony
