From: arvind.yadav.cs@gmail.com (arvind Yadav)
Date: Mon, 22 Aug 2016 23:12:32 +0530
Subject: [v.1] clocksource:clps711x-timer:- Unmap a region obtained by
 remap
In-Reply-To: <57B30F68.4080701@linaro.org>
References: <1470937308-9480-1-git-send-email-arvind.yadav.cs@gmail.com>
 <57B30F68.4080701@linaro.org>
Message-ID: <6da41be1-a147-3d9c-88c1-2441a28b9e8e@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Tuesday 16 August 2016 06:34 PM, Daniel Lezcano wrote:
> Hi Arvind,
>
> On 08/11/2016 07:41 PM, Arvind Yadav wrote:
>> iounmap frees the mapping when timer id is not matching.
>>
>> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
>> ---
> Even if this fix is correct, it does actually rollback a minimalist part
> of what was done and only if the clock type is wrong. Can you properly
> handle the undo from the different init functions and regarding their
> success/error ?
>
> Thanks.
>
>    -- Daniel
As per your concern, I have done the changes.
please review it.

--Arvind
>>   drivers/clocksource/clps711x-timer.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/clocksource/clps711x-timer.c b/drivers/clocksource/clps711x-timer.c
>> index 84aed78..deaca51 100644
>> --- a/drivers/clocksource/clps711x-timer.c
>> +++ b/drivers/clocksource/clps711x-timer.c
>> @@ -116,6 +116,7 @@ static int __init clps711x_timer_init(struct device_node *np)
>>   	case CLPS711X_CLKSRC_CLOCKEVENT:
>>   		return _clps711x_clkevt_init(clock, base, irq);
>>   	default:
>> +		iounmap(base);
>>   		return -EINVAL;
>>   	}
>>   }
>>
>
