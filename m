From: amwang@redhat.com (Cong Wang)
Date: Wed, 07 Dec 2011 17:26:56 +0800
Subject: [PATCH] highmem: Fix ARM build break due to __kmap_atomic rename
In-Reply-To: <74CDBE0F657A3D45AFBB94109FB122FF1750B774A6@HQMAIL01.nvidia.com>
References: <1323197426-10815-1-git-send-email-swarren@nvidia.com>
 <alpine.LFD.2.02.1112061440050.2357@xanadu.home>
 <74CDBE0F657A3D45AFBB94109FB122FF1750B774A6@HQMAIL01.nvidia.com>
Message-ID: <4EDF3160.7070800@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

? 2011?12?07? 03:52, Stephen Warren ??:
> Nicolas Pitre wrote at Tuesday, December 06, 2011 12:42 PM:
>> On Tue, 6 Dec 2011, Stephen Warren wrote:
>>> Git commit 37bfbb9 "highmem: kill all __kmap_atomic()" renamed
>>> __kmap_atomic to kmap_atomic. However, arch/arm/include/asm/highmem.h
>>> wasn't updated for that change. This change does so, and fixes the
>>> ARM build break.
>>>
>>> Signed-off-by: Stephen Warren<swarren@nvidia.com>
>>> ---
>>> This shows up in next-20111206 at least.
>>
>> Commit 37bfbb9 doesn't show up in anything which is stable yet.  Would
>> be best to ask the original author to fix his branch.
>
> Yes, I assumed that Cong would squash this into his/her tree that's in
> linux-next.
>

Thanks for your patch, Stephen!

I have squashed your patch into that commit,

commit 5bf31c9a5de45a6ea6628fe84c043ac38babf393
Author: Cong Wang <amwang@redhat.com>
Date:   Sat Nov 26 10:53:39 2011 +0800

     highmem: kill all __kmap_atomic()
     [swarren at nvidia.com: highmem: Fix ARM build break due to __kmap_atomic rename]

     Signed-off-by: Stephen Warren <swarren@nvidia.com>
     Signed-off-by: Cong Wang <amwang@redhat.com>
