From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Fri, 13 Jan 2017 11:27:48 +0000
Subject: [PATCH] arm64/mm: use phys_addr_t
In-Reply-To: <20170113112205.GA26804@leverpostej>
References: <1484287175-14342-1-git-send-email-miles.chen@mediatek.com>
 <20170113112205.GA26804@leverpostej>
Message-ID: <CAKv+Gu__4S+0B39SXn46sqxsH0OXeusotZOBmvzZmw-yRRzdjA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13 January 2017 at 11:22, Mark Rutland <mark.rutland@arm.com> wrote:
> On Fri, Jan 13, 2017 at 01:59:35PM +0800, miles.chen at mediatek.com wrote:
>> From: Miles Chen <miles.chen@mediatek.com>
>>
>> Use phys_addr_t instead of unsigned long for the
>> return value of __pa(), make code easy to understand.
>>
>> Signed-off-by: Miles Chen <miles.chen@mediatek.com>
>
> This looks sensible to me. It's consistent with the types these
> variables are compared against, and with the types of function
> parameters these are passed as.
>

Indeed. But doesn't it clash with Laura's series?

> Acked-by: Mark Rutland <mark.rutland@arm.com>
>
> Thanks,
> Mark.
>
>> ---
>>  arch/arm64/mm/mmu.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
>> index 17243e4..7eb7c21 100644
>> --- a/arch/arm64/mm/mmu.c
>> +++ b/arch/arm64/mm/mmu.c
>> @@ -359,8 +359,8 @@ static void create_mapping_late(phys_addr_t phys, unsigned long virt,
>>
>>  static void __init __map_memblock(pgd_t *pgd, phys_addr_t start, phys_addr_t end)
>>  {
>> -     unsigned long kernel_start = __pa(_text);
>> -     unsigned long kernel_end = __pa(__init_begin);
>> +     phys_addr_t kernel_start = __pa(_text);
>> +     phys_addr_t kernel_end = __pa(__init_begin);
>>
>>       /*
>>        * Take care not to create a writable alias for the
>> --
>> 1.9.1
>>
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel at lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
