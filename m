From: ajeet.yadav.77@gmail.com (Ajeet Yadav)
Date: Wed, 22 Feb 2012 09:06:48 +0530
Subject: [PATCH 1/2] ARM: dma-mapping: its array of pointer
In-Reply-To: <1329580086.2448.12.camel@computer2.home>
References: <1329484170-26329-1-git-send-email-ajeet.yadav.77@gmail.com>
 <1329580086.2448.12.camel@computer2.home>
Message-ID: <CAB4K4y5p14kt2HXfrGTkO8Jezoj1S4ZOrJ+cmz5t3u53jMoSMA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

thanks, reposted with changes.

Ajeet

On Sat, Feb 18, 2012 at 9:18 PM, Tixy <tixy@yxit.co.uk> wrote:
> On Fri, 2012-02-17 at 18:39 +0530, Ajeet Yadav wrote:
>> To be consistant with declaration and usage of
> ? ? ? ?^^^^^^^^^^
> Spelling mistake, should be 'consistent'
>
>> consistent_pte it need to be an array of (pte *)
> ? ? ? ? ? ? ? ? ? ?^^^^
> Grammar mistake, should be 'needs'.
>
>>
>> Signed-off-by: Ajeet Yadav <ajeet.yadav.77@gmail.com>
>
> The title of this patch is a bit vague, perhaps something like:
> "ARM: dma-mapping: Fix the type used for consistent_pte size
> calculation"
>
> The actual patch looks correct.
>
> --
> Tixy
>
>> ---
>> ?arch/arm/mm/dma-mapping.c | ? ?2 +-
>> ?1 files changed, 1 insertions(+), 1 deletions(-)
>>
>> diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
>> index 1aa664a..04bfa76 100644
>> --- a/arch/arm/mm/dma-mapping.c
>> +++ b/arch/arm/mm/dma-mapping.c
>> @@ -170,7 +170,7 @@ static int __init consistent_init(void)
>> ? ? ? unsigned long base = consistent_base;
>> ? ? ? unsigned long num_ptes = (CONSISTENT_END - base) >> PMD_SHIFT;
>>
>> - ? ? consistent_pte = kmalloc(num_ptes * sizeof(pte_t), GFP_KERNEL);
>> + ? ? consistent_pte = kmalloc(num_ptes * sizeof(pte_t *), GFP_KERNEL);
>> ? ? ? if (!consistent_pte) {
>> ? ? ? ? ? ? ? pr_err("%s: no memory\n", __func__);
>> ? ? ? ? ? ? ? return -ENOMEM;
>
>
>
