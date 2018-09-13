From: jcm@redhat.com (Jon Masters)
Date: Thu, 13 Sep 2018 12:53:30 -0400 (EDT)
Subject: [RFC PATCH 00/11] Avoid synchronous TLB invalidation for
 intermediate page-table entries on arm64
In-Reply-To: <20180913155301.GA20290@arm.com>
References: <1535125966-7666-1-git-send-email-will.deacon@arm.com>
 <3dd55e21-7424-071a-0f7e-d24fc2396f2a@redhat.com>
 <20180905122828.GF20186@arm.com>
 <f8ba271b-87c0-29ef-1216-77d5d391d5c8@redhat.com>
 <20180913155301.GA20290@arm.com>
Message-ID: <0D8B76BD-C09D-4B51-97DD-3DB57EB85DB6@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tnx

-- 
Computer Architect


> On Sep 13, 2018, at 11:52, Will Deacon <will.deacon@arm.com> wrote:
> 
>> On Fri, Sep 07, 2018 at 02:36:08AM -0400, Jon Masters wrote:
>>> On 09/05/2018 08:28 AM, Will Deacon wrote:
>>>> On Tue, Sep 04, 2018 at 02:38:02PM -0400, Jon Masters wrote:
>>>>> On 08/24/2018 11:52 AM, Will Deacon wrote:
>>>>> 
>>>>> I hacked up this RFC on the back of the recent changes to the mmu_gather
>>>>> stuff in mainline. It's had a bit of testing and it looks pretty good so
>>>>> far.
>>>> 
>>>> I will request the server folks go and test this. You'll probably
>>>> remember a couple of parts we've seen where aggressive walker caches
>>>> ended up (correctly) seeing stale page table entries and we had all
>>>> manner of horrifically hard to debug problems. We have some fairly nice
>>>> reproducers that were able to find this last time that we can test.
>>> 
>>> Cheers, Jon, that would be very helpful. You're probably best off using
>>> my (rebasing) tlb branch rather than picking the RFC:
>>> 
>>>  git://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git tlb
>>> 
>>> Let me know if you'd prefer something stable (I can tag it with a date).
>> 
>> That would be useful. I've prodded each of the Arm server SoC vendors I
>> work with via our weekly call to have them each specifically check this.
>> A tag would be helpful to that effort I expect. They all claim to be
>> watching this thread now, so we'll see if they see cabbages here.
> 
> This is now all queued up in the (stable) arm64 for-next/core branch:
> 
>  https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git/log/?h=for-next/core
> 
> so that's the best place to grab the patches.
> 
> Will
