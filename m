From: andy.shevchenko@gmail.com (Andy Shevchenko)
Date: Mon, 9 Nov 2015 11:26:21 +0200
Subject: [PATCH V3 3/4] dmaselftest: add memcpy selftest support functions
In-Reply-To: <56400DD4.5080506@codeaurora.org>
References: <1446958380-23298-1-git-send-email-okaya@codeaurora.org>
 <1446958380-23298-4-git-send-email-okaya@codeaurora.org>
 <CAHp75VfS6iCYcWeFmbK2PEUYLntQQRdsmN=7gttFpOn=CfrSZg@mail.gmail.com>
 <56400DD4.5080506@codeaurora.org>
Message-ID: <CAHp75Vddve-yv5DQ5UWhOsfUaY0JCb_rFjwGf2tvY-8++sJmng@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 9, 2015 at 5:07 AM, Sinan Kaya <okaya@codeaurora.org> wrote:
>
>
> On 11/8/2015 3:09 PM, Andy Shevchenko wrote:
>>
>> On Sun, Nov 8, 2015 at 6:52 AM, Sinan Kaya <okaya@codeaurora.org> wrote:
>>>
>>> This patch adds supporting utility functions
>>> for selftest. The intention is to share the self
>>> test code between different drivers.
>>>
>>> Supported test cases include:
>>> 1. dma_map_single
>>> 2. streaming DMA
>>> 3. coherent DMA
>>> 4. scatter-gather DMA
>>
>>

>>> +       u32 i, j = 0;
>>
>> unsigned int
>
> why?

Is i or j is going to be used for HW communication? No? What about
assignment to a values of type u32? No? Plain counters? Use plain
types.

It's actually comment about your all patches I saw last week.

>>> +       int err = 0;
>>> +       int ret;
>>
>>
>> Any reason to have two instead of one of similar meaning?
>>
>
> removed ret

Don't forget to check if it's redundant assignment (check in all your
patches as well).

-- 
With Best Regards,
Andy Shevchenko
