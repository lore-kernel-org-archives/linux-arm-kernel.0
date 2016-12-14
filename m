From: panand@redhat.com (Pratyush Anand)
Date: Wed, 14 Dec 2016 15:42:22 +0530
Subject: [PATCH 1/2] arm64: Add enable/disable d-cache support for
 purgatory
In-Reply-To: <d8f354da-1e61-feaf-f76a-18e90361e98b@redhat.com>
References: <cover.1479788404.git.panand@redhat.com>
 <7a4866b928c0905ec1074dce1bfc7984c968a58a.1479788404.git.panand@redhat.com>
 <5838834D.90205@arm.com> <d8f354da-1e61-feaf-f76a-18e90361e98b@redhat.com>
Message-ID: <9a79b666-7990-2a23-2d74-52b3317ce272@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Wednesday 14 December 2016 03:08 PM, Pratyush Anand wrote:
>
>>
>> I would go as far as to generate the page tables at 'kexec -l' time,
>> and only if
>
> Ok..So you mean that I create a new section which will have page table
> entries mapping physicalmemory represented by remaining section, and
> then purgatory can just enable mmu with page table from that section,
> right? Seems doable. can do that.

I see a problem here. If we create  page table as a new segment then, 
how can we verify in purgatory that sha for page table is correct? We 
need page table before sha verification start,and we can not rely the 
page table created by first kernel until it's sha is verified. So a 
chicken-egg problem.

I think, creating page table will just take fraction of second and 
should be good even in purgatory, What do you say?

~Pratyush
