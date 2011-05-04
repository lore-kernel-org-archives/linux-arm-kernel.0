From: tony@atomide.com (Tony Lindgren)
Date: Wed, 4 May 2011 06:59:30 -0700
Subject: [PATCH 1/8] OMAP PM: create a PM layer plugin for per-device
	constraints
In-Reply-To: <1304516117-9334-2-git-send-email-j-pihet@ti.com>
References: <1304516117-9334-1-git-send-email-j-pihet@ti.com>
	<1304516117-9334-2-git-send-email-j-pihet@ti.com>
Message-ID: <20110504135930.GE2092@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* jean.pihet at newoldbits.com <jean.pihet@newoldbits.com> [110504 06:32]:
>
> +int omap_pm_set_max_mpu_wakeup_lat(struct device *dev, long t)
...

> +int omap_pm_set_max_dev_wakeup_lat(struct device *req_dev, struct device *dev,
...

> +int omap_pm_set_min_clk_rate(struct device *dev, struct clk *c, long r)
...

You should implement this as a Linux generic framework, we don't
want to add more omap specific frameworks.

Or maybe you can leave this out if they're just stubs for TI CDP code?

Tony
