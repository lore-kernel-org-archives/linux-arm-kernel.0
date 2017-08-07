From: sudeep.holla@arm.com (Sudeep Holla)
Date: Mon, 7 Aug 2017 13:25:14 +0100
Subject: [PATCH v2 16/18] hwmon: add support for sensors exported via ARM
 SCMI
In-Reply-To: <20170804193231.GA18153@roeck-us.net>
References: <1501857104-11279-1-git-send-email-sudeep.holla@arm.com>
 <1501857104-11279-17-git-send-email-sudeep.holla@arm.com>
 <20170804193231.GA18153@roeck-us.net>
Message-ID: <20e0a388-79a1-a7f1-57b4-fa5993eed9bf@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 04/08/17 20:32, Guenter Roeck wrote:
> On Fri, Aug 04, 2017 at 03:31:42PM +0100, Sudeep Holla wrote:

[...]

>> +	platform_set_drvdata(pdev, scmi_sensors);
>> +
>> +	hwdev = devm_hwmon_device_register_with_groups(dev, "scmi_sensors",
>> +						       scmi_sensors,
>> +						       scmi_sensors->groups);
> 
> Can you rework this to use devm_hwmon_device_register_with_info(),
> and if possible let it handle the thermal registration ? 
> 

Thanks for the pointers. I will check on the possibility and use it if
possible.

-- 
Regards,
Sudeep
