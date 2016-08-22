From: xieyisheng1@huawei.com (Yisheng Xie)
Date: Mon, 22 Aug 2016 19:33:46 +0800
Subject: [RFC PATCH v2 2/2] arm64 Kconfig: Select gigantic page
In-Reply-To: <20160822100045.GA26494@e104818-lin.cambridge.arm.com>
References: <1471834603-27053-1-git-send-email-xieyisheng1@huawei.com>
 <1471834603-27053-3-git-send-email-xieyisheng1@huawei.com>
 <20160822080358.GF13596@dhcp22.suse.cz>
 <20160822100045.GA26494@e104818-lin.cambridge.arm.com>
Message-ID: <b5f1f756-4698-4c32-1c30-97b1ccf2b4a6@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 2016/8/22 18:00, Catalin Marinas wrote:
> On Mon, Aug 22, 2016 at 10:03:58AM +0200, Michal Hocko wrote:
>> On Mon 22-08-16 10:56:43, Xie Yisheng wrote:
>>> Arm64 supports gigantic page after
>>> commit 084bd29810a5 ("ARM64: mm: HugeTLB support.")
>>> however, it got broken by 
>>> commit 944d9fec8d7a ("hugetlb: add support for gigantic page
>>> allocation at runtime")
>>>
>>> This patch selects ARCH_HAS_GIGANTIC_PAGE to make this
>>> function can be used again.
>>
>> I haven't double checked that the above commit really broke it but if
>> that is the case then
>>  
>> Fixes: 944d9fec8d7a ("hugetlb: add support for gigantic page allocation at runtime")
>>
>> would be nice as well I guess. I do not think that marking it for stable
>> is really necessary considering how long it's been broken and nobody has
>> noticed...
> 
> I'm not sure that commit broke it. The gigantic functionality introduced
> by the above commit was under an #ifdef CONFIG_X86_64. Prior
> to that we had a VM_BUG_ON(hstate_is_gigantic(h)).
> 
Hi Catalin and Michal ,
Thank you for your reply.
Before that commit gigantic pages can only be allocated at boottime and
can't be freed. That why we had VM_BUG_ON(hstate_is_gigantic(h)) in
function update_and_free_page() Prior to that.

Anyway, it should not just add #ifdef CONFIG_X86_64 for arm64 already
supported 1G hugepage before that commit. Right?

Please let me know if I miss something.

Thanks
Xie Yisheng.
