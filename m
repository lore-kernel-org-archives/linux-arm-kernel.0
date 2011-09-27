From: rnayak@ti.com (Rajendra Nayak)
Date: Tue, 27 Sep 2011 20:19:37 +0530
Subject: [PATCH 8/9] regulator: helper to extract regulator node based
	on supply name
In-Reply-To: <20110927122155.GE4289@opensource.wolfsonmicro.com>
References: <1317118372-17052-1-git-send-email-rnayak@ti.com>
	<1317118372-17052-9-git-send-email-rnayak@ti.com>
	<20110927122155.GE4289@opensource.wolfsonmicro.com>
Message-ID: <4E81E281.505@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 27 September 2011 05:51 PM, Mark Brown wrote:
> On Tue, Sep 27, 2011 at 03:42:51PM +0530, Rajendra Nayak wrote:
>
>> +	if (!dev)
>> +		return NULL;
>
> So how do we handle CPUs?  cpufreq is one of the most active users of
> regulators...

Hmm, never thought of it :(
Maybe I should associate a supply name with all
regulators and then lookup from the global registered
list.

>
>> +	snprintf(prop_name, 32, "%s-supply", supply);
>> +
>> +	prop = of_get_property(dev->of_node, prop_name,&sz);
>> +	if (!prop || sz<  4)
>> +		return NULL;
>
> sz<  4?  Magic!  :)

Its the valid phandle size.
I guess I need a sz != 4

>
>> +extern struct device_node *of_get_regulator(struct device *dev,
>> +	const char *supply);
>
> This shouldn't be part of the public API, it should be transparently
> handled within the core.

agreed.
