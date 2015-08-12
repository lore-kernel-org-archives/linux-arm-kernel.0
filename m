From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Wed, 12 Aug 2015 07:45:36 +0200
Subject: [PATCH] ARM: config: Switch PXA27x platforms to use PXA RTC driver
In-Reply-To: <CAL_JsqKxUjg+zPJ=_Wvd+zTh7UuT=dkECEh=Hy7QdZsqn4B+8w@mail.gmail.com>
 (Rob Herring's message of "Tue, 11 Aug 2015 20:07:50 -0500")
References: <1437757375-9113-1-git-send-email-robh@kernel.org>
 <CAL_JsqKxUjg+zPJ=_Wvd+zTh7UuT=dkECEh=Hy7QdZsqn4B+8w@mail.gmail.com>
Message-ID: <8737zpjbzz.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rob Herring <robh@kernel.org> writes:

> On Fri, Jul 24, 2015 at 12:02 PM, Rob Herring <robh@kernel.org> wrote:
>> With the SA1100 and PXA RTC drivers be mutually exclusive and no
>> longer sharing hardware, PXA27x/PXA3xx platforms must use the PXA RTC
>> driver as the SA1100 platform device is no longer registered.
>>
>> This change should be almost transparent to userspace. Former users of
>> pxa-rtc should be aware that 2 RTCs will be available on their kernels,
>> rtc0 being sa1100-rtc and rtc1 being pxa-rtc. Any userspace relying on
>> the fact that rtc0 was pxa-rtc should be fixed.
>>
>> As a consequence:
>>  - the first reboot after the switch will have the wrong time,
>>  - on dual boot platform where the other OS programs some logic into the
>>    sa1100 rtc IP, a lack of fix in userspace, ie. a kernel changing
>>    sa1100-rtc thinking it is pxa-rtc could have dire consequence, such
>>    as wiping the other OS data partition.
>>
>> (Thanks to Robert Jarmik for help on the above commit text.)
>>
>> Signed-off-by: Rob Herring <robh@kernel.org>
>> Cc: Robert Jarzmik <robert.jarzmik@free.fr>
>> Cc: Daniel Mack <daniel@zonque.org>
>> Cc: Haojian Zhuang <haojian.zhuang@gmail.com>
>> Cc: Sergey Lapin <slapin@ossfans.org>
>> Cc: Russell King <linux@arm.linux.org.uk>
>> Cc: Mike Rapoport <mike@compulab.co.il>
>> Cc: Philipp Zabel <philipp.zabel@gmail.com>
>> ---
>> PXA Maintainers,
>>
>> This is dependent on my SA1100 RTC cleanup series[1]. Please comment on
>> this patch and that series. The full series is available from a git
>> branch here[2]. I've rebased it to 4.2-rc3, but otherwise there is no
>> change from v4.
>
> Any comments on this? If not, I plan to send Alexandre a pull request
> for this series this week.
Hi Rob,

I think you waited long enough, nobody can tell now they were not aware of the
situation. Please go ahead and request pull.

Acked-by: Robert Jarzmik <robert.jarzmik@free.fr>

Cheers.

--
Robert
