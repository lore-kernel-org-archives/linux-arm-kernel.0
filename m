From: pankaj.dubey@samsung.com (Pankaj Dubey)
Date: Mon, 12 Jan 2015 14:59:23 +0530
Subject: [PATCH v5 1/2] soc: samsung: add exynos chipid driver support
In-Reply-To: <1521226.qVx3V7aJT6@wuerfel>
References: <1418285264-21763-1-git-send-email-pankaj.dubey@samsung.com>
 <CAL_JsqKaf+w_D-xLCUizuTmxwT7uUHExA=qMpawQ+00G7uMcBg@mail.gmail.com>
 <548A9D27.1000504@samsung.com> <1521226.qVx3V7aJT6@wuerfel>
Message-ID: <54B393F3.8070403@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

Sorry for late reply.

On Friday 12 December 2014 05:01 PM, Arnd Bergmann wrote:
> On Friday 12 December 2014 13:15:43 Pankaj Dubey wrote:
>>>> +
>>>> +static void __iomem *exynos_chipid_base;
>>>> +
>>>> +struct exynos_chipid_info exynos_soc_info;
>>>> +EXPORT_SYMBOL(exynos_soc_info);
>>>
>>> The soc_device already has similar data.Why is this needed? Is it
>>> temporary for compatibility?
>>
>> struct soc_device_attribute can hold these two (product_id, and
>> revision) but they are defined as char * in soc_device_atttribute, and I
>> feel it's more specific for exposing via sysfs.
>> Also existing code in mach-exynos compares them via product_id/revision
>> macros, so I can say to keep compatibility.
>
> We had a similar discussion about the Marvell SoCs a while ago, and at
> the time we concluded that it would be best to create a platform-
> independent API to match the strings in soc_device_attribute against
> a list of strings in the driver, either by matching the start of the
> string, or using the glob_match() function. Would that work for you?
>

It might be useful, will you please point me to that discussion so that 
I can dig more and see how I can reuse it, or if required work on it.

Thanks,
Pankaj Dubey
> 	Arnd
>
