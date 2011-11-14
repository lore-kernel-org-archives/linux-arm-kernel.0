From: eric.y.miao@gmail.com (Eric Miao)
Date: Mon, 14 Nov 2011 13:25:21 +0800
Subject: [PATCH] ARM: pxa168/gplugd: add the correct SSP device
In-Reply-To: <4EC0A458.7030206@einfochips.com>
References: <1321013994-6443-1-git-send-email-eric.y.miao@gmail.com>
 <4EBD4733.4010801@einfochips.com>
 <CAMPhdO_X0n9L6HF1TSChzWt34=atJrr4=FR8h7PJ0hh0beJ6Pw@mail.gmail.com>
 <4EC0A1B0.4050302@einfochips.com>
 <CAMPhdO9+FFbmRs5pK7eTwwYnVQ1Sh6cfKDbYmnLUH4MtEQ0LVQ@mail.gmail.com>
 <4EC0A458.7030206@einfochips.com>
Message-ID: <CAMPhdO_mB6Wp-jv=LgWuV4HvkUK_yH3Q3MdXYWLkGnH0TmU5eQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 14, 2011 at 1:17 PM, Tanmay Upadhyay
<tanmay.upadhyay@einfochips.com> wrote:
>
>
> On Monday 14 November 2011 10:37 AM, Eric Miao wrote:
>>
>> On Mon, Nov 14, 2011 at 1:05 PM, Tanmay Upadhyay
>> <tanmay.upadhyay@einfochips.com> ?wrote:
>>>
>>> On Monday 14 November 2011 09:51 AM, Eric Miao wrote:
>>>>
>>>> On Sat, Nov 12, 2011 at 12:02 AM, Tanmay Upadhyay
>>>> <tanmay.upadhyay@einfochips.com> ? ?wrote:
>>>>>
>>>>> On Friday 11 November 2011 05:49 PM, Eric Miao wrote:
>>>>>>
>>>>>> There is no SSP0, but SSP2 is used on gplugd.
>>>>>>
>>>>>> Cc: Tanmay Upadhyay<tanmay.upadhyay@einfochips.com>
>>>>>> Signed-off-by: Eric Miao<eric.y.miao@gmail.com>
>>>>>> ---
>>>>>> ?arch/arm/mach-mmp/gplugd.c | ? ?2 +-
>>>>>> ?1 files changed, 1 insertions(+), 1 deletions(-)
>>>>>>
>>>>>> diff --git a/arch/arm/mach-mmp/gplugd.c b/arch/arm/mach-mmp/gplugd.c
>>>>>> index 6915656..0469c74 100644
>>>>>> --- a/arch/arm/mach-mmp/gplugd.c
>>>>>> +++ b/arch/arm/mach-mmp/gplugd.c
>>>>>> @@ -182,7 +182,7 @@ static void __init gplugd_init(void)
>>>>>>
>>>>>> ? ? ? ?/* on-chip devices */
>>>>>> ? ? ? ?pxa168_add_uart(3);
>>>>>> - ? ? ? pxa168_add_ssp(0);
>>>>>> + ? ? ? pxa168_add_ssp(2);
>>>>>> ? ? ? ?pxa168_add_twsi(0, NULL,
>>>>>> ARRAY_AND_SIZE(gplugd_i2c_board_info));
>>>>>>
>>>>>> ? ? ? ?pxa168_add_eth(&gplugd_eth_platform_data);
>>>>>
>>>>> Hi Eric,
>>>>>
>>>>> HDMI chip (TDA9981A) on gplugD gets audio data from SSP0 - used as I2S.
>>>>> Page
>>>>> # 7 of [1]& ? ?page # 1& ? ?3 of [2] indicates this.
>>>>
>>>> Shouldn't this be SSP1 instead, if following the public PXA168 software
>>>> manual (there is no SSP0, and the existing code doesn't suppport it)
>>>
>>> Ah! My bad! You are right. Current code doesn't support SSP0. It just
>>> starts
>>> from 1! Sorry I just missed it. :(
>>>
>>>>> SSP2 is also used on gplugD
>>>>> as SPI to talk to the NOR flash.
>>>>
>>>> If ignoring this port at this moment, how about the patch below?
>>>
>>> It looks good. We should go with it.
>>
>> Can I take your Acked-by?
>>
>
> Yes. Thanks for taking care! Could you please also provide your feedback for
> a pending patch for gplugD USB [1]?

Thanks. I will.

>
> Thanks,
>
> Tanmay
>
> [1]
> http://lists.arm.linux.org.uk/lurker/message/20110718.065211.c3b28958.en.html
>
