From: sudeep.holla@arm.com (Sudeep Holla)
Date: Mon, 4 Sep 2017 14:37:14 +0100
Subject: [PATCH v2 15/18] clk: add support for clocks provided by SCMI
In-Reply-To: <20170901001901.GJ21656@codeaurora.org>
References: <1501857104-11279-1-git-send-email-sudeep.holla@arm.com>
 <1501857104-11279-16-git-send-email-sudeep.holla@arm.com>
 <20170901001901.GJ21656@codeaurora.org>
Message-ID: <51391c6f-2c20-119e-f8d4-cc4800c79124@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 01/09/17 01:19, Stephen Boyd wrote:
> On 08/04, Sudeep Holla wrote:
>> diff --git a/drivers/clk/clk-scmi.c b/drivers/clk/clk-scmi.c
>> new file mode 100644
>> index 000000000000..37f98a6439a0
>> --- /dev/null
>> +++ b/drivers/clk/clk-scmi.c

[...]

>> +static int scmi_clocks_probe(struct platform_device *pdev)
>> +{
>> +	struct device *dev = &pdev->dev;
>> +	struct device_node *np = dev->of_node;
>> +	const struct scmi_handle *handle = devm_scmi_handle_get(dev);
>> +
>> +	if (IS_ERR_OR_NULL(handle) || !handle->clk_ops)
>> +		return -EPROBE_DEFER;
>> +
>> +	return scmi_clk_add(dev, np, handle);
> 
> Why the function? We support more than just platform devices?
> Just fold scmi_clk_add() into this function instead please.
> 

All valid points. Fixed locally now, will post as part of next posting
of the series.

-- 
Regards,
Sudeep
