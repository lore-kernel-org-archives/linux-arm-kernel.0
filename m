From: jaswinder.singh@linaro.org (Jassi Brar)
Date: Wed, 16 May 2012 22:54:57 +0530
Subject: [PATCH V3 1/2] of: Add generic device tree DMA helpers
In-Reply-To: <4FB3E00B.4030207@ti.com>
References: <1335820679-28721-1-git-send-email-jon-hunter@ti.com>
 <CAJe_Zhe-SqDMDGOhrYZtBBJnCYqLR0H07cPKzG4SyUxiLrgFnQ@mail.gmail.com>
 <4FA3F308.6030900@ti.com>
 <CAJe_ZhfFhZVG4gyaaVUgeQedJiSE=zj9nE28XCNH9DkPVgqj=A@mail.gmail.com>
 <4FB2FEBA.1030404@ti.com>
 <CAJe_ZhcrMycgOWf6EiGEjz25C1ZTkB1W=33Qqp4rFpcq-5QsDg@mail.gmail.com>
 <4FB3A87C.1000000@ti.com> <4FB3CF44.4040603@ti.com>
 <CAJe_ZhcQAABe9xF6HEvUq8OT8RoWXTHAsrzyZiGO9bM-GHNiTg@mail.gmail.com>
 <4FB3E00B.4030207@ti.com>
Message-ID: <CAJe_Zhe_edZ32K50i8AH+wagUkYWRxJpWpZpZ-ddk83LF5vKRg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16 May 2012 22:42, Jon Hunter <jon-hunter@ti.com> wrote:

>>> What is still unclear to me, is if you use this token approach how
>>> readable is the device-tree? For example, if you have a client that can
>>> use one of two dmac and for each dmac the request/channel number is
>>> different, then by using a global token how can I determine what the
>>> options available for this client are?
>>>
>> Simple - you/client need not know about any option at all :)
>>
>> Client driver would simply request some channel and if it
>> doesn't get it, it bails out.
>>
>> It would be the DMACs' DT node that would contain that info.
>
> Yes, but what if I am doing some custom application and want to modify
> the mapping that is being used? So I just wanted to make sure it is easy
> to understand assuming that you understand what your h/w is capable of.
>
Any scenario when a client would want to choose which dma controller
it runs on?

Because when we say a client could be provided a channel on any of the
two given dmacs, it implies that the client wouldn't feel any difference.
