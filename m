From: anshuman.khandual@arm.com (Anshuman Khandual)
Date: Wed, 3 Oct 2018 16:40:27 +0530
Subject: [PATCH 1/4] mm/hugetlb: Enable PUD level huge page migration
In-Reply-To: <a6b96126-5571-2aa2-6deb-09a457afd781@arm.com>
References: <1538482531-26883-1-git-send-email-anshuman.khandual@arm.com>
 <1538482531-26883-2-git-send-email-anshuman.khandual@arm.com>
 <835085a2-79c2-4eb5-2c10-13bb2893f611@arm.com>
 <c0689b0c-4810-e0e8-354e-55c45d59b6d0@arm.com>
 <a6b96126-5571-2aa2-6deb-09a457afd781@arm.com>
Message-ID: <bad51030-5f02-4fc9-741c-0fffbd690aca@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 10/03/2018 03:52 PM, Suzuki K Poulose wrote:
> 
> 
> On 02/10/18 13:56, Anshuman Khandual wrote:
>>
>>
>> On 10/02/2018 06:08 PM, Suzuki K Poulose wrote:
>>> Hi Anshuman
>>>
>>> On 02/10/18 13:15, Anshuman Khandual wrote:
>>>> Architectures like arm64 have PUD level HugeTLB pages for certain configs
>>>> (1GB huge page is PUD based on ARM64_4K_PAGES base page size) that can be
>>>> enabled for migration. It can be achieved through checking for PUD_SHIFT
>>>> order based HugeTLB pages during migration.
>>>>
>>>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>>>> ---
>>>> ?? include/linux/hugetlb.h | 3 ++-
>>>> ?? 1 file changed, 2 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
>>>> index 6b68e34..9c1b77f 100644
>>>> --- a/include/linux/hugetlb.h
>>>> +++ b/include/linux/hugetlb.h
>>>> @@ -483,7 +483,8 @@ static inline bool hugepage_migration_supported(struct hstate *h)
>>>> ?? {
>>>> ?? #ifdef CONFIG_ARCH_ENABLE_HUGEPAGE_MIGRATION
>>>> ?????? if ((huge_page_shift(h) == PMD_SHIFT) ||
>>>> -??????? (huge_page_shift(h) == PGDIR_SHIFT))
>>>> +??????? (huge_page_shift(h) == PUD_SHIFT) ||
>>>
>>>
>>>> +??????????? (huge_page_shift(h) == PGDIR_SHIFT))
>>>
>>> nit: Extra Tab ^^.
>>
>> The tab is in there when you apply this patch and all three checks are tab separated
>> in a newline.
> 
> Well, with the patch applied, at least I can see 2 tabs for the
> PUD_SHIFT check and 3 tabs for PGDIR_SHIFT check. Which seems
> inconsistent. Is it just me (my mail client) ?

I am sorry, you are right. Did not understand your point earlier. Yeah there is
increasing number of tabs for each new line with a conditional check. Is there
a problem with this style of indentation ? Though I will be happy to change.
