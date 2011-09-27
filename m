From: rnayak@ti.com (Rajendra Nayak)
Date: Tue, 27 Sep 2011 20:19:45 +0530
Subject: [PATCH 9/9] regulator: map consumer regulator based on device tree
In-Reply-To: <20110927122357.GF4289@opensource.wolfsonmicro.com>
References: <1317118372-17052-1-git-send-email-rnayak@ti.com>
	<1317118372-17052-10-git-send-email-rnayak@ti.com>
	<20110927122357.GF4289@opensource.wolfsonmicro.com>
Message-ID: <4E81E289.5060904@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 27 September 2011 05:53 PM, Mark Brown wrote:
> On Tue, Sep 27, 2011 at 03:42:52PM +0530, Rajendra Nayak wrote:
>> Look up the regulator for a given consumer from device tree, during
>> a regulator_get(). If not found fallback and lookup through
>> the regulator_map_list instead.
>
> As with the fixed voltage regulator patch just use the code along with
> adding it, no need to split it just makes it harder to review.

Ok.

>
>> +	if (dev->of_node) {
>> +		node = of_get_regulator(dev, id);
>> +		if (!node)
>> +			goto retry; /* fallback and chk regulator_map_list */
>> +		list_for_each_entry(rdev,&regulator_list, list)
>> +			if (node == rdev->node)
>> +				goto found;
>> +	}
>> +retry:
>
> retry is a confusing name for the target, we don't ever actually retry
> using it.  Given the simplicity of the code I'd be inclined to just
> intert the if (!node) check.

Ok.
