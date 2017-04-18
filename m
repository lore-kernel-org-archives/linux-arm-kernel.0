From: f.fainelli@gmail.com (Florian Fainelli)
Date: Tue, 18 Apr 2017 15:29:55 -0700
Subject: [PATCH 2/2] hwmon: (brcmstb) Add driver for Broadcom STB DPFE
In-Reply-To: <20170418205839.GA3554@roeck-us.net>
References: <20170418201702.57019-1-code@mmayer.net>
 <20170418201702.57019-3-code@mmayer.net> <20170418205839.GA3554@roeck-us.net>
Message-ID: <f8c99c6f-8c53-0d0e-0712-d001c1e45f75@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hey Guenter,

On 04/18/2017 01:58 PM, Guenter Roeck wrote:
> Hi Markus,
> 
> On Tue, Apr 18, 2017 at 01:17:02PM -0700, Markus Mayer wrote:
>> From: Markus Mayer <mmayer@broadcom.com>
>>
>> This driver allows access to DRAM properties, such as the refresh rate,
>> via the Broadcom STB DDR PHY Front End (DPFE). The refresh rate can be
>> used as indirect indicator of the DRAM temperature.
>>
>> The driver also allows setting of the sampling interval.
>>
>> Signed-off-by: Markus Mayer <mmayer@broadcom.com>
>> ---
> [ ... ]
> 
>> +
>> +static SENSOR_DEVICE_ATTR(dpfe_info, 0444, show_info, NULL, 1000);
>> +static SENSOR_DEVICE_ATTR(dpfe_refresh, 0644, show_refresh, store_refresh,
>> +			  1000);
>> +static SENSOR_DEVICE_ATTR(dpfe_vendor, 0444, show_vendor, NULL, 1000);
>> +static struct attribute *dpfe_attrs[] = {
>> +	&sensor_dev_attr_dpfe_info.dev_attr.attr,
>> +	&sensor_dev_attr_dpfe_refresh.dev_attr.attr,
>> +	&sensor_dev_attr_dpfe_vendor.dev_attr.attr,
>> +	NULL
>> +};
>> +ATTRIBUTE_GROUPS(dpfe);
>> +
> 
> There is not a single standard hwmon attribute. I don't know how
> to classify this driver, and where it should reside, but it is not
> a hwmon driver. 

This is a driver that talks to an embedded CPU running firmware which is
capable of giving various informations about the DRAM chip being
populated, including a temperature trend (hotter or cooler). We thought
initially we would be able to expose the actual temperature, but this in
turn required a lot more knowledge about the DRAM chip that we wish we
knew about. That is sort of where and why this driver was proposed for
hwmon.

Which subsystem do you think would be best for this driver drivers/misc/
or drivers/soc/bcm/brcmstb/ maybe?
-- 
Florian
