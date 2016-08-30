From: vladimir.murzin@arm.com (Vladimir Murzin)
Date: Tue, 30 Aug 2016 17:40:38 +0100
Subject: [PATCH v2 0/8] ARM: V7M: Support caches
In-Reply-To: <20160818151113.GB1041@n2100.armlinux.org.uk>
References: <1471524360-31554-1-git-send-email-vladimir.murzin@arm.com>
 <20160818145300.GA1041@n2100.armlinux.org.uk> <57B5CCDE.10504@arm.com>
 <20160818151113.GB1041@n2100.armlinux.org.uk>
Message-ID: <57C5B706.2060500@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18/08/16 16:11, Russell King - ARM Linux wrote:
> On Thu, Aug 18, 2016 at 03:57:34PM +0100, Vladimir Murzin wrote:
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
> Of course.
> 

Russell, given that it was tested on platforms with and without cache
support, I've just dropped this set into patch system. Please, let me
know if you see issues with that.

Thanks
Vladimir
