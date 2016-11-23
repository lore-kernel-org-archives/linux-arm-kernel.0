From: david@lechnology.com (David Lechner)
Date: Wed, 23 Nov 2016 10:21:41 -0600
Subject: [PATCH 2/3] pinctrl: New driver for TI DA8XX/OMAP-L138/AM18XX
 pinconf
In-Reply-To: <88b3d16b-6e5b-ea75-d770-35d9adc6c677@ti.com>
References: <1479871767-20160-1-git-send-email-david@lechnology.com>
 <1479871767-20160-3-git-send-email-david@lechnology.com>
 <88b3d16b-6e5b-ea75-d770-35d9adc6c677@ti.com>
Message-ID: <6936ebc0-bb27-d741-3504-e2fbb231b87c@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/23/2016 05:04 AM, Sekhar Nori wrote:
> On Wednesday 23 November 2016 08:59 AM, David Lechner wrote:
>> This adds a new driver for pinconf on TI DA8XX/OMAP-L138/AM18XX. These
>
> s/DA8XX/DA850/
>
>> SoCs have a separate controller for controlling pullup/pulldown groups.
>>
>> Signed-off-by: David Lechner <david@lechnology.com>
>
>> +static const char *da850_pupd_get_get_group_name(struct pinctrl_dev *pctldev,
>> +						 unsigned int selector)
>> +{
>> +	return da850_pupd_group_names[selector];
>> +}
>> +
>> +static int da850_pupd_get_get_group_pins(struct pinctrl_dev *pctldev,
>> +					 unsigned int selector,
>> +					 const unsigned int **pins,
>> +					 unsigned int *num_pins)
>> +{
>> +	*num_pins = 0;
>> +
>> +	return 0;
>> +}
>
> usage of get_get_ in the function names above is odd.

Will fix (copy/paste error)

>
> Thanks,
> Sekhar
>
