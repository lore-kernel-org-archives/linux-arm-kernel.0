From: Suzuki.Poulose@arm.com (Suzuki K Poulose)
Date: Fri, 15 Apr 2016 17:08:08 +0100
Subject: [PATCH V2 04/15] coresight: tmc: introducing new header file
In-Reply-To: <CANLsYkzQuF=Y7O7T41HHHGHiFNtpj+cUd8W9paAYh=dqm0MJXg@mail.gmail.com>
References: <1460483692-25061-1-git-send-email-mathieu.poirier@linaro.org>
 <1460483692-25061-5-git-send-email-mathieu.poirier@linaro.org>
 <570FD473.9090007@arm.com>
 <CANLsYkzQuF=Y7O7T41HHHGHiFNtpj+cUd8W9paAYh=dqm0MJXg@mail.gmail.com>
Message-ID: <571111E8.2000804@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15/04/16 17:03, Mathieu Poirier wrote:
> On 14 April 2016 at 11:33, Suzuki K Poulose <Suzuki.Poulose@arm.com> wrote:
>> On 12/04/16 18:54, Mathieu Poirier wrote:
>>>
>>> The amount of #define, enumeration and structure definition
>>> is big enough to justify moving them to a new header file.
>>>
>>
>>
>>> +/* TMC_STS - 0x00C */
>>> +#define TMC_STS_TRIGGERED      BIT(1)
>>
>>
>> ...
>>
>>> +#define TMC_AXICTL_WR_BURST_LEN 0xF00
>>
>>
>> Nit: The value above signifies, 16 data transfers per burst.
>> So ideally it would be good to rename it to reflect that. say,
>>
>> TMC_AXICTL_WR_BURST_16
>
> Will do.  But I'll have to do this in a separate patch then the
> grouping of STS_ and FFCR_ defines you're referring to below since it
> will also require changes to the .c files.

Yes, I don't expect this change to be part of the patch. Separate patch
is fine.

>
>>
>>
>>
>>> +/* TMC_FFCR - 0x304 */
>>> +#define TMC_FFCR_EN_FMT                BIT(0)
>>> +#define TMC_FFCR_EN_TI         BIT(1)
>>> +#define TMC_FFCR_FON_FLIN      BIT(4)
>>> +#define TMC_FFCR_FON_TRIG_EVT  BIT(5)
>>> +#define TMC_FFCR_FLUSHMAN      BIT(6)
>>> +#define TMC_FFCR_TRIGON_TRIGIN BIT(8)
>>> +#define TMC_FFCR_STOP_ON_FLUSH BIT(12)
>>> +
>>> +#define TMC_STS_TMCREADY_BIT   2
>>
>>
>>> +#define TMC_FFCR_FLUSHMAN_BIT  6
>>
>>
>> nit: It would be nice to group the STS_ and FFCR_ bits together.
>> Also I see that the defintion for
>> TMC_STS_FULL is added in a completely unrelated patch (TMC-ETF AUX SPACE
>> patch ?). It would be good to add it either here or in a different patch.
>
> TMC_STS_FULL is not added here because at this point it is not used by
> the code - it is only added later when it is useful.

I agree. But the patch which introduces the definition doesn't deal with
TMC_STS_ at all either. Thats why I said, either here or in a different patch
than what is there. May be you could club the change above and the STS_FULL
into a new single patch. Its not mandatory though.

Suzuki
