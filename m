From: rafael.j.wysocki@intel.com (Rafael J. Wysocki)
Date: Tue, 8 May 2018 23:39:45 +0200
Subject: [PATCH v6 3/6] kernel/reboot.c: export pm_power_off_prepare
In-Reply-To: <20180505070147.epsrglnypm72jr5u@pengutronix.de>
References: <20180305102524.5905-1-o.rempel@pengutronix.de>
 <20180305102524.5905-4-o.rempel@pengutronix.de>
 <20180504185052.bjhfkvpgrblc7tfc@pengutronix.de>
 <20180504134956.36dc72a253d03e94a517a867@linux-foundation.org>
 <20180505070147.epsrglnypm72jr5u@pengutronix.de>
Message-ID: <c1f2e09d-f64b-afe6-59bf-c0742409e4d6@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 5/5/2018 9:01 AM, Oleksij Rempel wrote:
> Moving Rafael from Cc to To.
>
> Hi Rafael,
>
> can you please help here?
> I need your ACK or NACK for this patch.

Sorry for the delay, I'll have a closer look at it in the next couple of 
days.

Thanks,
Rafael


> On Fri, May 04, 2018 at 01:49:56PM -0700, Andrew Morton wrote:
>> On Fri, 4 May 2018 20:50:52 +0200 Oleksij Rempel <o.rempel@pengutronix.de> wrote:
>>
>>> Hallo Andrew,
>>> I need your ACK or NACK for this patch.
>>>
>>> This function is used to configure external PMIC to interpret
>>> signal which will be triggered by pm_power_off as power off.
>>> Since same signal can be used for stand by, I linked PMIC configuration
>>> with pm_power_off_prepare to avoid possible conflicts.
>>>
>>> ...
>>>
>>>> --- a/kernel/reboot.c
>>>> +++ b/kernel/reboot.c
>>>> @@ -49,6 +49,7 @@ int reboot_force;
>>>>    */
>>>>   
>>>>   void (*pm_power_off_prepare)(void);
>>>> +EXPORT_SYMBOL(pm_power_off_prepare);
>>>>   
>> OK by me, but it's more of a Rafael thing.
>>
