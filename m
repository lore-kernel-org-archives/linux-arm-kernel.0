From: rnayak@ti.com (Rajendra Nayak)
Date: Tue, 27 Sep 2011 20:18:04 +0530
Subject: [PATCH 2/9] regulator: helper routine to extract
	regulator_init_data
In-Reply-To: <20110927121003.GB4289@opensource.wolfsonmicro.com>
References: <1317118372-17052-1-git-send-email-rnayak@ti.com>
	<1317118372-17052-3-git-send-email-rnayak@ti.com>
	<20110927121003.GB4289@opensource.wolfsonmicro.com>
Message-ID: <4E81E224.2070408@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 27 September 2011 05:40 PM, Mark Brown wrote:
> On Tue, Sep 27, 2011 at 03:42:45PM +0530, Rajendra Nayak wrote:
>
>> +	init_data = devm_kzalloc(dev, sizeof(struct regulator_init_data),
>> +						 GFP_KERNEL);
>> +	if (!init_data)
>> +		return NULL; /* Out of memory? */
>
> This means that the init data will be kept around for the entire
> lifetime of the device rather than being discarded.

Wasn't it the same while this was passed around as platform_data?

>
>> +	init_data->supply_regulator = (char *)of_get_property(dev->of_node,
>> +						"regulator-supplies", NULL);
>
> I'd expect that in the device tree world the supply regulator would
> reference the node for that regulator.

You mean using phandles? Thats what Grant proposed too but
I thought you instead had an inclination towards names? Or maybe
I misunderstood.

>
>>   	/* voltage output range (inclusive) - for voltage control */
>> -	int min_uV;
>> -	int max_uV;
>> +	u32 min_uV;
>> +	u32 max_uV;
>>
>> -	int uV_offset;
>> +	u32 uV_offset;
>>
>>   	/* current output range (inclusive) - for current control */
>> -	int min_uA;
>> -	int max_uA;
>> +	u32 min_uA;
>> +	u32 max_uA;
>
> Hrm, I think loosing the signs here is bad karma - negative voltages do
> exist after all.

Oops.. they do? didn't know about that.
