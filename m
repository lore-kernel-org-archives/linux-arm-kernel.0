From: khilman@ti.com (Kevin Hilman)
Date: Wed, 04 May 2011 07:36:58 -0700
Subject: [PATCH 1/8] OMAP PM: create a PM layer plugin for per-device
	constraints
In-Reply-To: <20110504135930.GE2092@atomide.com> (Tony Lindgren's message of
	"Wed, 4 May 2011 06:59:30 -0700")
References: <1304516117-9334-1-git-send-email-j-pihet@ti.com>
	<1304516117-9334-2-git-send-email-j-pihet@ti.com>
	<20110504135930.GE2092@atomide.com>
Message-ID: <87vcxqv8fp.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tony,

Tony Lindgren <tony@atomide.com> writes:

> * jean.pihet at newoldbits.com <jean.pihet@newoldbits.com> [110504 06:32]:
>>
>> +int omap_pm_set_max_mpu_wakeup_lat(struct device *dev, long t)
> ...
>
>> +int omap_pm_set_max_dev_wakeup_lat(struct device *req_dev, struct device *dev,
> ...
>
>> +int omap_pm_set_min_clk_rate(struct device *dev, struct clk *c, long r)
> ...
>
> You should implement this as a Linux generic framework, we don't
> want to add more omap specific frameworks.

This series isn't adding any new OMAP-specific frameworks.  The OMAP PM
layer is already in place, and has been there for awhile.  OMAP PM is a
layer which can have "plugins" so we can experiment with ways of
handling constraints without changing the driver interface, and this
series is just implementing a new plugin.

Once we are happy with a constraint layer, and can prove it will work,
the plan is to get rid of the (existing) OMAP-specific APIs and propose
a generic interface.

Kevin
