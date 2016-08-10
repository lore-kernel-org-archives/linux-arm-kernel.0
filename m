From: f.fainelli@gmail.com (Florian Fainelli)
Date: Tue, 9 Aug 2016 17:20:17 -0700
Subject: [RFCv2][PATCH 2/5] arm: Implement ARCH_HAS_FORCE_CACHE
In-Reply-To: <dd9519ce-cd4f-4007-a88a-f184407ca565@redhat.com>
References: <1470678577-14010-1-git-send-email-labbott@redhat.com>
 <1470678577-14010-3-git-send-email-labbott@redhat.com>
 <afd22029-c60c-1c15-3293-4011b085e07e@gmail.com>
 <dd9519ce-cd4f-4007-a88a-f184407ca565@redhat.com>
Message-ID: <905897d4-7528-80a6-980d-18520069f321@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/09/2016 05:13 PM, Laura Abbott wrote:
> On 08/09/2016 02:56 PM, Florian Fainelli wrote:
>> On 08/08/2016 10:49 AM, Laura Abbott wrote:
>>> arm may need the kernel_force_cache APIs to guarantee data consistency.
>>> Implement versions of these APIs based on the DMA APIs.
>>>
>>> Signed-off-by: Laura Abbott <labbott@redhat.com>
>>> ---
>>>  arch/arm/include/asm/cacheflush.h |   4 ++
>>>  arch/arm/mm/dma-mapping.c         | 119
>>> --------------------------------------
>>>  arch/arm/mm/flush.c               | 115
>>> ++++++++++++++++++++++++++++++++++++
>>
>> Why is the code moved between dma-mapping.c and flush.c? It was not
>> obvious while looking at these patches why this is needed.
>>
> 
> I wanted to use the cache flushing routines from dma-mapping.c and
> it seemed better to pull them out vs. trying to put more generic
> cache flushing code in dma-mapping.c. flush.c seemed like an
> appropriate place although I forgot about the dependency on CONFIG_MMU.
> It can certainly remain in dma-mapping.c if deemed appropriate.

My concern is that this is an area of the kernel where you might be
looking for stable backports, so avoiding churn in there is desireable
and if the new cache APIs become accepted and standard, since they are
building directly on top of the DMA-API, keeping them in dma-mapping.c
seems consistent.

My 2 cents.
-- 
Florian
