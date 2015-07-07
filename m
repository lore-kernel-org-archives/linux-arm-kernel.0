From: vaibhav.hiremath@linaro.org (Vaibhav Hiremath)
Date: Tue, 07 Jul 2015 20:17:39 +0530
Subject: [PATCH-V5 3/4] mfd: 88pm800: Set default interrupt clear method
In-Reply-To: <20150707125439.GE3182@x1>
References: <1435591877-18214-1-git-send-email-vaibhav.hiremath@linaro.org>
 <1435591877-18214-4-git-send-email-vaibhav.hiremath@linaro.org>
 <20150707072958.GN3182@x1> <559BA1AE.9050006@linaro.org>
 <20150707104028.GR3182@x1> <559BAF23.90002@linaro.org>
 <20150707111248.GU3182@x1> <559BB58E.9010406@linaro.org>
 <559BB727.2070106@linaro.org> <20150707125439.GE3182@x1>
Message-ID: <559BE68B.3020801@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Tuesday 07 July 2015 06:24 PM, Lee Jones wrote:
> On Tue, 07 Jul 2015, Vaibhav Hiremath wrote:
>
>>
>>
>> On Tuesday 07 July 2015 04:48 PM, Vaibhav Hiremath wrote:
>>>
>>>
>>> On Tuesday 07 July 2015 04:42 PM, Lee Jones wrote:
>>>> On Tue, 07 Jul 2015, Vaibhav Hiremath wrote:
>>>>> On Tuesday 07 July 2015 04:10 PM, Lee Jones wrote:
>>>>>> On Tue, 07 Jul 2015, Vaibhav Hiremath wrote:
>>>>>>> On Tuesday 07 July 2015 12:59 PM, Lee Jones wrote:
>>>>>>>> On Mon, 29 Jun 2015, Vaibhav Hiremath wrote:
>>>>>>>>
>>>>>>>>> As per the spec, bit 1 (INT_CLEAR_MODE) of reg addr 0xe
>>>>>>>>> (page 0) controls the method of clearing interrupt
>>>>>>>>> status of 88pm800 family of devices;
>>>>>>>>>
>>>>>>>>>    0: clear on read
>>>>>>>>>    1: clear on write
>>>>>>>>>
>>>>>>>>> If pdata is not coming from board file, then set the
>>>>>>>>> default irq clear method to "irq clear on write"
>>>>>>>>>
>>>>>>>>> Also, as suggested by "Lee Jones" renaming variable field
>>>>>>>>> to appropriate name.
>>>>>>>>>
>>>>>>>>> Signed-off-by: Zhao Ye <zhaoy@marvell.com>
>>>>>>>>> Signed-off-by: Vaibhav Hiremath <vaibhav.hiremath@linaro.org>
>>>>>>>>> ---
>>>>>>>>>   drivers/mfd/88pm800.c       | 15 ++++++++++-----
>>>>>>>>>   include/linux/mfd/88pm80x.h | 10 ++++++++--
>>>>>>>>>   2 files changed, 18 insertions(+), 7 deletions(-)
>>>>>>>>>

<snip>

>>>
>>> Yes certainly, this is another option (rather preferred one).
>>>
>>> But to be consistent with other's I proposed this, please refer to the
>>> fn device_800_init(), where all xxx_init() are taking 2 arguments, and
>>> second argument is pdata.
>>>
>>>
>>> There is room for cleanup, I agree.
>>> I can put this too in the next cleanup series.
>>>
>>
>> Note that this is init function, called from probe.
>>
>> So both approach looks ok to me.
>
> Please clean up the other.  Function and put it at the front of the
> set when you re-submit.
>

Sorry for dumb question here :)
I did not understand what do you mean by "in front of the set"?

You want to see all the patches into one single series?
Or
have separate series,
	1. existing DT addition series
	2. new clean-up series

Thanks,
Vaibhav
