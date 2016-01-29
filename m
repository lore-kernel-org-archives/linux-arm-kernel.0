From: dianders@chromium.org (Doug Anderson)
Date: Fri, 29 Jan 2016 13:58:56 -0800
Subject: [PATCH v6 0/5] dma-mapping: Patches for speeding up allocation
In-Reply-To: <CAOesGMg=7mzZ6wKgjB1Po3706FGYu+D06YWWBBTya6KOE7531g@mail.gmail.com>
References: <1452533428-12762-1-git-send-email-dianders@chromium.org>
 <20160126155937.6a4e4165d1cf4e513d62e942@linux-foundation.org>
 <CAD=FV=V9ZJrmD=F8363mhg8+JQiTRg=g6DuZR2KJRbfU=K455w@mail.gmail.com>
 <CAOesGMg=7mzZ6wKgjB1Po3706FGYu+D06YWWBBTya6KOE7531g@mail.gmail.com>
Message-ID: <CAD=FV=XEML4UqV-oVR4doZNSq6bNxDvpc-4745JTBZgf4d9UYA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Jan 29, 2016 at 1:52 PM, Olof Johansson <olof@lixom.net> wrote:
> On Tue, Jan 26, 2016 at 4:39 PM, Doug Anderson <dianders@chromium.org> wrote:
>> Hi,
>>
>> On Tue, Jan 26, 2016 at 3:59 PM, Andrew Morton
>> <akpm@linux-foundation.org> wrote:
>>> On Mon, 11 Jan 2016 09:30:22 -0800 Douglas Anderson <dianders@chromium.org> wrote:
>>>
>>>> This series of patches will speed up memory allocation in dma-mapping
>>>> quite a bit.
>>>
>>> This is pretty much all ARM and driver stuff so I think I'll duck it.
>>> But I can merge it if nobody else feels a need to.
>>
>> I was going to ask what the next steps were for this series.
>> Presumably I could post the patch to Russell's patch tracker if folks
>> want me to do that.  Alternatively it could go through the ARM-SOC
>> tree?
>>
>>
>>> I saw a few acked-by/tested-by/etc from the v5 posting which weren't
>>> carried over into v6 (might have been a timing race), so please fix
>>> that up if there's an opportunity.
>>
>> Right.  Both Robin and Tomasz gave their Reviewed-by to Patch #1 in v5
>> even after v6 was posted.
>>
>>
>>> Regarding the new DMA_ATTR_ALLOC_SINGLE_PAGES hint: I suggest adding
>>> "DMA_ATTR_ALLOC_SINGLE_PAGES is presently implemented only on ARM" to
>>> the docs.  Or perhaps have a shot at implementing it elsewhere.
>>
>> Warning sounds good.
>>
>>
>>> Typo in 4/5 changelog: "reqiurements"
>>
>> Thanks for catching!
>>
>>
>> I'm happy to post up a v6 with these things fixed or I'm happy for
>> whoever is applying it to make these small fixes themselves.  Any
>> volunteers?  Olof, Arnd, or Russell: any of you want these patches?
>
> I think it makes sense to send these through Russell's tracker for him
> to merge, especially since I don't think there are any dependencies on
> them for SoC-specific patches coming up.

Sounds good.  I'll make the nitfixes and I'll post a v7 directly to
Russell's tracker.  I'll follow up here with a link to those patches.

-Doug
