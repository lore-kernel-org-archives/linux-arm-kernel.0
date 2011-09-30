From: rnayak@ti.com (Rajendra Nayak)
Date: Fri, 30 Sep 2011 09:57:30 +0530
Subject: [PATCH 2/9] regulator: helper routine to extract
	regulator_init_data
In-Reply-To: <20110927150511.GM4289@opensource.wolfsonmicro.com>
References: <1317118372-17052-1-git-send-email-rnayak@ti.com>
	<1317118372-17052-3-git-send-email-rnayak@ti.com>
	<20110927121003.GB4289@opensource.wolfsonmicro.com>
	<4E81E224.2070408@ti.com>
	<20110927150511.GM4289@opensource.wolfsonmicro.com>
Message-ID: <4E854532.6080605@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[]...
>
>>>> +	init_data->supply_regulator = (char *)of_get_property(dev->of_node,
>>>> +						"regulator-supplies", NULL);
>
>>> I'd expect that in the device tree world the supply regulator would
>>> reference the node for that regulator.
>
>> You mean using phandles? Thats what Grant proposed too but
>> I thought you instead had an inclination towards names? Or maybe
>> I misunderstood.
>
> They need both.  We need to reference the device that provides the
> supply and use a name to say which of the potentially multiple supplies
> on the consumer device is which.

Mark, I still seem to be a little confused with this one as to why
we would need a phandle *and* a supply-name to reference a parent
regulator/supply.
The phandle would point to a regulator dt node and that node internally
would have just one name associated with it.

>
>>> Hrm, I think loosing the signs here is bad karma - negative voltages do
>>> exist after all.
>
>> Oops.. they do? didn't know about that.
>
> Yup, ground is just a reference point.
