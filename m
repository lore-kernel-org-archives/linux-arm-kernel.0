From: nsekhar@ti.com (Sekhar Nori)
Date: Tue, 2 Jul 2013 11:46:50 +0530
Subject: [PATCH 3/4] rtc: omap: add rtc wakeup support to alarm events
In-Reply-To: <1BAFE6F6C881BF42822005164F1491C33EC4E7CC@DBDE04.ent.ti.com>
References: <1372412109-986-1-git-send-email-gururaja.hebbar@ti.com>
 <1372412109-986-4-git-send-email-gururaja.hebbar@ti.com>
 <51D26CFA.5090500@ti.com>
 <1BAFE6F6C881BF42822005164F1491C33EC4E7AB@DBDE04.ent.ti.com>
 <51D26E98.9040303@ti.com>
 <1BAFE6F6C881BF42822005164F1491C33EC4E7CC@DBDE04.ent.ti.com>
Message-ID: <51D27052.6080303@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 7/2/2013 11:41 AM, Hebbar, Gururaja wrote:
> On Tue, Jul 02, 2013 at 11:39:28, Nori, Sekhar wrote:
>> On 7/2/2013 11:34 AM, Hebbar, Gururaja wrote:
>>> On Tue, Jul 02, 2013 at 11:32:34, Nori, Sekhar wrote:
>>>> On 6/28/2013 3:05 PM, Hebbar Gururaja wrote:
>>>>> On some platforms (like AM33xx), a special register (RTC_IRQWAKEEN)
>>>>> is available to enable Alarm Wakeup feature. This register needs to be
>>>>> properly handled for the rtcwake to work properly.
>>>>>
>>>>> Platforms using such IP should set "ti,am3352-rtc" in rtc device dt
>>>>> compatibility node.
>>>>>
>>>>> Signed-off-by: Hebbar Gururaja <gururaja.hebbar@ti.com>
>>>>> Cc: Grant Likely <grant.likely@linaro.org>
>>>>> Cc: Rob Herring <rob.herring@calxeda.com>
>>>>> Cc: Rob Landley <rob@landley.net>
>>>>> Cc: Sekhar Nori <nsekhar@ti.com>
>>>>> Cc: Kevin Hilman <khilman@linaro.org>
>>>>> Cc: Alessandro Zummo <a.zummo@towertech.it>
>>>>> Cc: rtc-linux at googlegroups.com
>>>>> Cc: devicetree-discuss at lists.ozlabs.org
>>>>> Cc: linux-doc at vger.kernel.org
>>>>> ---
>>>>
>>>> [...]
>>>>
>>>>> -#define	OMAP_RTC_DATA_DA830_IDX	1
>>>>> +#define	OMAP_RTC_DATA_DA830_IDX		1
>>>>> +#define	OMAP_RTC_DATA_AM335X_IDX	2
>>>>>  
>>>>>  static struct platform_device_id omap_rtc_devtype[] = {
>>>>>  	{
>>>>> @@ -309,6 +321,9 @@ static struct platform_device_id omap_rtc_devtype[] = {
>>>>>  	}, {
>>>>>  		.name	= "da830-rtc",
>>>>>  		.driver_data = OMAP_RTC_HAS_KICKER,
>>>>> +	}, {
>>>>> +		.name	= "am335x-rtc",
>>>>
>>>> may be use am3352-rtc here just to keep the platform device name and of
>>>> compatible in sync.
>>>
>>> Correct. I will update the same in v2.
>>>
>>>>
>>>>> +		.driver_data = OMAP_RTC_HAS_KICKER | OMAP_RTC_HAS_IRQWAKEEN,
>>>>>  	},
>>>>>  	{},
>>>>
>>>> It is better to use the index defined above in the static initialization
>>>> so they remain in sync.
>>>
>>> Sorry. I didn?t get this.
>>>
>>
>> See example below I provided. If its still not clear, let me know what
>> is not clear.
>>
>>>> 	...
>>>> 	[OMAP_RTC_DATA_DA830_IDX] = {
>>>> 		.name	= "da830-rtc",
>>>> 		.driver_data = OMAP_RTC_HAS_KICKER,
>>>> 	},
> 
> Thanks for the clarification. In this case will it ok if I update the previous
> member also.

You dont really reference [0] in omap_rtc_of_match[] so even if you
leave it as-is, that's fine with me. I am mostly concerned with the
index definitions and initialization order being out of sync and that's
really not an issue with [0].

Thanks,
Sekhar
