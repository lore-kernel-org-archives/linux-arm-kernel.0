From: labbott@redhat.com (Laura Abbott)
Date: Fri, 3 Mar 2017 10:50:20 -0800
Subject: [RFC PATCH 10/12] staging: android: ion: Use CMA APIs directly
In-Reply-To: <2140021.hmlAgxcLbU@avalon>
References: <1488491084-17252-1-git-send-email-labbott@redhat.com>
 <1488491084-17252-11-git-send-email-labbott@redhat.com>
 <2140021.hmlAgxcLbU@avalon>
Message-ID: <0541f57b-4060-ea10-7173-26ae77777518@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/03/2017 08:41 AM, Laurent Pinchart wrote:
> Hi Laura,
> 
> Thank you for the patch.
> 
> On Thursday 02 Mar 2017 13:44:42 Laura Abbott wrote:
>> When CMA was first introduced, its primary use was for DMA allocation
>> and the only way to get CMA memory was to call dma_alloc_coherent. This
>> put Ion in an awkward position since there was no device structure
>> readily available and setting one up messed up the coherency model.
>> These days, CMA can be allocated directly from the APIs. Switch to using
>> this model to avoid needing a dummy device. This also avoids awkward
>> caching questions.
> 
> If the DMA mapping API isn't suitable for today's requirements anymore, I 
> believe that's what needs to be fixed, instead of working around the problem 
> by introducing another use-case-specific API.
> 

I don't think this is a usecase specific API. CMA has been decoupled from
DMA already because it's used in other places. The trying to go through
DMA was just another layer of abstraction, especially since there isn't
a device available for allocation.

Thanks,
Laura
