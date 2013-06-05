From: ming.lei@canonical.com (Ming Lei)
Date: Wed, 5 Jun 2013 09:46:28 +0800
Subject: [PATCH v2] ARM: mm: lazy cache flushing on non-mapped pages
In-Reply-To: <20130604163012.GC25090@arm.com>
References: <1370270680-729-1-git-send-email-ming.lei@canonical.com>
 <20130604163012.GC25090@arm.com>
Message-ID: <CACVXFVMwWzWGCuXfMWhAtFa_45HA1H+hQK4TDChfnxit9T=DkA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 5, 2013 at 12:30 AM, Catalin Marinas
<catalin.marinas@arm.com> wrote:
> On Mon, Jun 03, 2013 at 03:44:39PM +0100, Ming Lei wrote:
>> diff --git a/arch/arm/mm/flush.c b/arch/arm/mm/flush.c
>> index 0d473cc..2ff66eb 100644
>> --- a/arch/arm/mm/flush.c
>> +++ b/arch/arm/mm/flush.c
>> @@ -287,7 +287,7 @@ void flush_dcache_page(struct page *page)
>>       mapping = page_mapping(page);
>>
>>       if (!cache_ops_need_broadcast() &&
>> -         mapping && !mapping_mapped(mapping))
>> +         mapping && !page_mapped(page))
>>               clear_bit(PG_dcache_clean, &page->flags);
>>       else {
>>               __flush_dcache_page(mapping, page);
>
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>

Thank Catalin and Will, and the patch has been submitted to patch
system as  patch 7746/1.


Thanks,
--
Ming Lei
