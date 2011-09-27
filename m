From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 27 Sep 2011 13:21:55 +0100
Subject: [PATCH 8/9] regulator: helper to extract regulator node based on
	supply name
In-Reply-To: <1317118372-17052-9-git-send-email-rnayak@ti.com>
References: <1317118372-17052-1-git-send-email-rnayak@ti.com>
	<1317118372-17052-9-git-send-email-rnayak@ti.com>
Message-ID: <20110927122155.GE4289@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 27, 2011 at 03:42:51PM +0530, Rajendra Nayak wrote:

> +	if (!dev)
> +		return NULL;

So how do we handle CPUs?  cpufreq is one of the most active users of
regulators...

> +	snprintf(prop_name, 32, "%s-supply", supply);
> +
> +	prop = of_get_property(dev->of_node, prop_name, &sz);
> +	if (!prop || sz < 4)
> +		return NULL;

sz < 4?  Magic!  :)

> +extern struct device_node *of_get_regulator(struct device *dev,
> +	const char *supply);

This shouldn't be part of the public API, it should be transparently
handled within the core.
