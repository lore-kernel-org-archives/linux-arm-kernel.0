From: vladimir.murzin@arm.com (Vladimir Murzin)
Date: Tue, 30 Aug 2016 09:26:11 +0100
Subject: [PATCH v2 0/8] ARM: V7M: Support caches
In-Reply-To: <CAGhQ9Vxn3cC4RiYfiYJh9Buh+3i_n_gJ+3zeth150xF=ZLGAMw@mail.gmail.com>
References: <1471524360-31554-1-git-send-email-vladimir.murzin@arm.com>
 <20160818145300.GA1041@n2100.armlinux.org.uk> <57B5CCDE.10504@arm.com>
 <CAGhQ9Vxn3cC4RiYfiYJh9Buh+3i_n_gJ+3zeth150xF=ZLGAMw@mail.gmail.com>
Message-ID: <57C54323.7080007@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Joachim,

On 27/08/16 17:53, Joachim Eastwood wrote:
> Hi Vladimir,
> 
> On 18 August 2016 at 16:57, Vladimir Murzin <vladimir.murzin@arm.com> wrote:
>> On 18/08/16 15:53, Russell King - ARM Linux wrote:
>>> On Thu, Aug 18, 2016 at 01:45:52PM +0100, Vladimir Murzin wrote:
>>>> This patch set allows M-class cpus benefit of optional cache support.
>>>> It originally was written by Jonny, I've been keeping it locally mainly
>>>> rebasing over Linux versions.
>>>>
>>>> The original idea behind patches was to reuse existing cache handling
>>>> code from v7A/R with help of extra macros to factor out cache handling
>>>> logic (v7M cache operations are provided via memory mapped interface
>>>> rather than co-processor instructions).
>>>> However, that idea was rejected and starting form this (v2) version
>>>> V7M cache logic lives into file and macros to indirect memory-mapped
>>>> operations stay there locally since they make it easier to follow the
>>>> code.
>>>>
>>>> Along with the v7M cache support the first user (Cortex-M7) is
>>>> introduced.
>>>>
>>>> Patches were tested on MPS2 platform with Cortex-M3/M4/M7. The later
>>>> one showed significant boot speed-up.
>>>
>>> >From a quick read through, the approach looks sane, and I think I'm
>>> now happy with these.
>>>
>>
>> Thanks!
>>
>> Is it acceptable if patches hang on a list for awhile, so people (I'm
>> looking at Alex and  Szemz?) can test them?
> 
> These patches doesn't seem to break anything on the cache-less
> Cortex-M4 NXP LPC4357.
> 

Great!

> So FWIW:
> Tested-by: Joachim Eastwood <manabian@gmail.com>
> 

Thanks a lot for testing!

Cheers
Vladimir

> 
> regards,
> Joachim Eastwood
> 
> 
