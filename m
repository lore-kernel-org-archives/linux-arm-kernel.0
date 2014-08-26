From: lauraa@codeaurora.org (Laura Abbott)
Date: Tue, 26 Aug 2014 13:15:40 -0700
Subject: [PATCHv4 1/2] arm64: Introduce {set,clear}_pte_bit
In-Reply-To: <20140826142707.GF16482@arm.com>
References: <1408477303-2640-1-git-send-email-lauraa@codeaurora.org>
 <1408477303-2640-2-git-send-email-lauraa@codeaurora.org>
 <20140826142707.GF16482@arm.com>
Message-ID: <53FCEAEC.2020203@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 8/26/2014 7:27 AM, Catalin Marinas wrote:
> On Tue, Aug 19, 2014 at 08:41:42PM +0100, Laura Abbott wrote:
>> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
>> index ffe1ba0..ca41449 100644
>> --- a/arch/arm64/include/asm/pgtable.h
>> +++ b/arch/arm64/include/asm/pgtable.h
>> @@ -149,46 +149,51 @@ extern struct page *empty_zero_page;
>>  #define pte_valid_not_user(pte) \
>>  	((pte_val(pte) & (PTE_VALID | PTE_USER)) == PTE_VALID)
>>  
>> -static inline pte_t pte_wrprotect(pte_t pte)
>> +static pte_t clear_pte_bit(pte_t pte, pgprot_t prot)
>>  {
>> -	pte_val(pte) &= ~PTE_WRITE;
>> +	pte_val(pte) &= ~pgprot_val(prot);
>>  	return pte;
>>  }
>>  
>> -static inline pte_t pte_mkwrite(pte_t pte)
>> +static pte_t set_pte_bit(pte_t pte, pgprot_t prot)
>>  {
>> -	pte_val(pte) |= PTE_WRITE;
>> +	pte_val(pte) |= pgprot_val(prot);
>>  	return pte;
>>  }
> 
> Why these two functions don't have an "inline"?
> 

That's an error on my part.

Will, you mentioned you applied these patches already, how
would you like to fix this up?

Laura

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
