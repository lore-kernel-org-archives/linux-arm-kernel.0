From: bill4carson@gmail.com (bill4carson)
Date: Wed, 01 Feb 2012 09:56:50 +0800
Subject: [RFC] ARM hugetlb support
In-Reply-To: <CAHkRjk6xZy3Nsy=R05664RM0Sw071rkXmV2g9ySwqiS_BrBLrw@mail.gmail.com>
References: <1327910238-18704-1-git-send-email-bill4carson@gmail.com>
 <CAHkRjk6xZy3Nsy=R05664RM0Sw071rkXmV2g9ySwqiS_BrBLrw@mail.gmail.com>
Message-ID: <4F289BE2.9020404@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 2012?01?31? 17:29, Catalin Marinas wrote:
> Hi,
>
> On 30 January 2012 07:57,<bill4carson@gmail.com>  wrote:
>> This patch aims to support huge page for ARM. For now, 2MB(two 1MB page)/16MB
>> huge page are supported, Versatile Express Cortex-A9x4 tile is used as test
>> board. Verifications are running with libhugetlbfs and ltp.
> I haven't reviewed your patches yet but just a few thoughts. Do you
> have a clear case where 16MB super-sections is needed? Do you have
> memory beyond 4G that can only be accessed with super-sections? This
> is an optional feature and not all processors have it.
The initial support only focus on ARMv7 based processor like cortex A9, 
basically that's
what I got in my hand, one Versatile Express Cortex-A9x4 tile board.

> It also doesn't
> help much with the TLB hit rate since the micro-TLB most likely only
> support 1MB sections.
>
I am afraid I can't agree with you on this.
Truly there is no specific statement about whether micro-TLB support 
16MB super-sections,
but main-TLB actually helps the hit rate, and main-TLB support all page 
size mapping.


> BTW, I have a (simpler) implementation of hugetlbfs with 2MB sections
> but for LPAE only:
>
> http://git.kernel.org/?p=linux/kernel/git/cmarinas/linux-arm-arch.git;a=shortlog;h=refs/heads/hugetlb
>
Thanks for your information, I will study your code carefully :)



-- 
I am a slow learner
but I will keep trying to fight for my dreams!

--bill
