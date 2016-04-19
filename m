From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Tue, 19 Apr 2016 11:51:00 +0200
Subject: [PATCH 1/2] mmc: core: Improve marking broken HPI through
 devicetree
In-Reply-To: <5715FD6B.5000809@schinagl.nl>
References: <1461049934-12848-1-git-send-email-oliver@schinagl.nl>
 <1461049934-12848-2-git-send-email-oliver@schinagl.nl>
 <CAPDyKFqftYtrHvcQB7te1fuWxjWtrhOGY=5DnRTnrRxHm2cQ-A@mail.gmail.com>
 <5715FD6B.5000809@schinagl.nl>
Message-ID: <CAPDyKFrhyqHYmSjrC23bHOkkz2F0QJGwbDKyryfEmoJhwkgMtg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19 April 2016 at 11:42, Olliver Schinagl <oliver@schinagl.nl> wrote:
> Hi Ulf,
>
> On 19-04-16 11:29, Ulf Hansson wrote:
>>
>> On 19 April 2016 at 09:12, Olliver Schinagl <oliver@schinagl.nl> wrote:
>>>
>>> In patch 81f8a7be66 Hans de Goede added a patch to allow marking an mmc
>>> device as to having an broken HPI implementation. After talking some
>>> with Hans, we now think it is actually the mmc controller that can be
>>> broken and not support broken HPI's.
>>
>> I don't want us to invent a DT binding for something you *think* is a
>> HW controller issue.
>>
>> Have you really excluded that this isn't a software issue? Me
>> personally haven't been using HPI that much so I can't really tell
>> about the code robustness from the mmc core (mmc protocol point of
>> view).
>
> Well this patch goes hand in hand so to speak with the broken-hpi patch
> introduced by him, he did most of the investigation. We just discussed how
> to handle it and asked me to cook up the patch.

Well, my point is that it's more understandable about having a broken
HPI implementation for eMMC cards, but for host controllers I am not
so sure.

I don't think there is an electrical change required by the host
controller to support HPI, is just like any other command, right?
Unless I am missing something, of course.

Kind regards
Uffe
