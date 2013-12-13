From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 13 Dec 2013 17:27:10 +0000
Subject: [PATCH] arm/arm64: KVM: relax the requirements of VMA alignment
 for THP
In-Reply-To: <20131213172018.GT2871@cbox>
References: <1386953766-1568-1-git-send-email-marc.zyngier@arm.com>
 <20131213172018.GT2871@cbox>
Message-ID: <52AB436E.1030709@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13/12/13 17:20, Christoffer Dall wrote:
> On Fri, Dec 13, 2013 at 04:56:06PM +0000, Marc Zyngier wrote:
>> The THP code in KVM/ARM is a bit restrictive in not allowing a THP
>> to be used if the VMA is not 2MB aligned. Actually, it is not so much
>> the VMA that matters, but the associated memslot:
>>
>> A process can perfectly mmap a region with no particular alignment
>> restriction, and then pass a 2MB aligned address to KVM. In this
>> case, KVM will only use this 2MB aligned region, and will ignore
>> the range between vma->vm_start and memslot->userspace_addr.
>>
>> It can also choose to place this memslot at whatever alignment it
>> wants in the IPA space. In the end, what matters is the relative
>> alignment of the user space and IPA mappings with respect to a
>> 2M page. They absolutely must be the same if you want to use THP.
> 
> Looks good to me:
> 
> Acked-by: Christoffer Dall <christoffer.dall@linaro.org>

Thanks for the review!

	M.
-- 
Jazz is not dead. It just smells funny...
