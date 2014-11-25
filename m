From: jaswinder.singh@linaro.org (Jassi Brar)
Date: Tue, 25 Nov 2014 18:48:35 +0530
Subject: [PATCH 0/4] mmc: sdhci: adding support for a new Fujitsu sdhci IP
In-Reply-To: <CAPDyKFqNK51vKNmGjQzFCrGyqa9XxHPeLBG-dX3UX=0G-v0j4w@mail.gmail.com>
References: <1416531100-26707-1-git-send-email-Vincent.Yang@tw.fujitsu.com>
 <CAPDyKFqZyUT+sARZQ2ncusttDWn31uQf_H2eTtHOSCs2c8yO4A@mail.gmail.com>
 <CAOEd-H2qbWgaauX=phfFk8HQqHk9gff3m_uoZqc+4Gbc6LZ-Lg@mail.gmail.com>
 <CAPDyKFruGDj5z5+i6FLT2YHhKPvY6wFE98dBQYsJroCNST_fyw@mail.gmail.com>
 <CAJe_ZhfvMCE4vxu76j2TBFZC90=tKm+yo+-Gf1WJq5oQT5_P+g@mail.gmail.com>
 <CAPDyKFqNK51vKNmGjQzFCrGyqa9XxHPeLBG-dX3UX=0G-v0j4w@mail.gmail.com>
Message-ID: <CAJe_Zhet8X0ocnxkEEg2bw=WW8t72Ha6UMSbAmh3ftkg8-EzUQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 25 November 2014 at 18:28, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> On 24 November 2014 at 13:29, Jassi Brar <jaswinder.singh@linaro.org> wrote:
>> On 24 November 2014 at 17:24, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>>> On 24 November 2014 at 11:45, Vincent Yang
>>> <vincent.yang.fujitsu@gmail.com> wrote:
>>>> 2014-11-24 17:54 GMT+08:00 Ulf Hansson <ulf.hansson@linaro.org>:
>>>>> On 21 November 2014 at 01:51, Vincent Yang
>>>>> <vincent.yang.fujitsu@gmail.com> wrote:
>>>>>> Hello,
>>>>>>
>>>>>>   Fujitsu have an sdhci IP which is implemented in a SoC we're
>>>>>> adding to mainline, the most recent series for that was sent
>>>>>> here:
>>>>>> http://lists.infradead.org/pipermail/linux-arm-kernel/2014-November/304522.html
>>>>>>
>>>>>>   These patches are against v3.18-rc5 mainline and tested on
>>>>>> v3.18-rc5 integration tree.
>>>>>>
>>>>>>   We welcome any comment and advice about how to make any
>>>>>> improvements or better align them with upstream.
>>>>>
>>>>> Apparently, there's a dependency between this patchset and the upper
>>>>> one you refereed to. That's a problem.
>>>>
>>>> This patchset does not require anything from the upper one I refereed to.
>>>
>>> No, but the upper depends on this patchset.
>>>
>>> Why can't you send the mmc patches separately in one patchset? That's
>>> would be easier to handle and review.
>>>
>> To be clear, the arch patchset introduces support for a new Fujitsu's
>> platform and has a sdhci controller driver named sdhci_f_sdh30.c which
>> will use 'general' improvements introduced by this patchset.
>>
>> I would think the controller driver has more dependency on ARCH than
>> this patchset. IOW, sdhci_f_sdh30.c can't get upstream without arch
>> patches but this patchset can without the sdhci_f_sdh30.c driver.  Is
>> that not so?
>
> Nope. I fail to see why there should be an ARCH dependency, there shouldn't!
>
> Well, I did note that to build the new driver it depended on
> ARCH_MB86S7X. Let's just remove that, because it's not needed.
>
I suspected build-bots might complain for non-arm configs. And do we
want to allow building Fujitsu controller driver even if ARCH_MB86S7X
is not enabled?

Vincent, lets remove ARCH_MB86S7X dependency and include the driver in
this patchset as Ulf wants.

Thanks,
Jassi
