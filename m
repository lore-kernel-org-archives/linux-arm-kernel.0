From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Fri, 06 Feb 2015 17:26:25 +0100
Subject: [PATCH 2/4] rtc: sa1100: convert to run-time register mapping
In-Reply-To: <CAL_JsqJ5Ju98adz5Y2Ow2JDnvFdKhCRvpH8Xg1OfMYOhJaUUFw@mail.gmail.com>
 (Rob Herring's message of "Thu, 5 Feb 2015 14:47:43 -0600")
References: <1423005775-26457-1-git-send-email-robh@kernel.org>
 <1423005775-26457-3-git-send-email-robh@kernel.org>
 <87h9v1a8k2.fsf@free.fr>
 <CAL_JsqLiiKvzxQqE=bEx7qoLSZXLZOegt87A=+pR3PJuSBK95w@mail.gmail.com>
 <20150205135037.GP8656@n2100.arm.linux.org.uk>
 <8761bg9ngy.fsf@free.fr>
 <CAL_JsqJ5Ju98adz5Y2Ow2JDnvFdKhCRvpH8Xg1OfMYOhJaUUFw@mail.gmail.com>
Message-ID: <87vbjf80r2.fsf@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rob Herring <robh@kernel.org> writes:

>>  - adding to rtc-pxa driver :
>>    - a new rtc device (ie. it will register 2 rtc devices, one of the sa1100
>>      kind, one of the pxa specific kind)
>
> I fail to see what the rtc-pxa gets us? Something to do with which
> counter has correct time at boot? It has a rollover longer than ~126
> years is all I see. Otherwise, it looks like over-engineered h/w to
> me.
Compatibility with other OSes, for multi-OS boots, which is the main reason
rtc-pxa was developped. Of course the other OS is using the other registers,
*and* resets RCNR to 0 on boot.

>> This has flaws :
>>  - a bit of code will be duplicated between rtc-pxa and rtc-sa1100
>
> That can probably be mitigated with a common file of shared functions.
Oh yeah, I like that. Would it mean that in the future you'd have time to help
with that task ?

>>  - the ordering in rtc-pxa between the 2 rtc devices will be important, as if I
>>  remember correctly /dev/rtc points to the first /dev/rtc0 registered
>>
>> But it opens up :
>>  - DT path to both drivers
>>  - isolation between sa1100 architecture changes and pxa architecture changes
>>  - Rob's current patches can remain almost the same
>>
>>> Also note that by including the resource in rtc-sa1100's platform
>>> device resource list, you'll have stacked resources between the two
>>> platform devices appearing in /proc/iomem (you did look at that
>>> before posting the patches, right?)
>> I must admit I don't know if there are nasty consequences, I think I need to
>> follow up the code to have a clear idea.
>
> I don't follow either. The resources don't appear unless requested and
> we only have 1 driver requesting it.
There's only one small test to do to understand, as soon as I'm finished with my
zylonite's ethernet interrupts, I will make the test to understand what Russell
said, I might learn something in the test :)

Cheers.

-- 
Robert
