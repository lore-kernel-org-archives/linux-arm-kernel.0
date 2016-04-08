From: Suzuki.Poulose@arm.com (Suzuki K Poulose)
Date: Fri, 8 Apr 2016 13:45:41 +0100
Subject: [PATCH 02/17] arm64: Cleanup VTCR_EL2 and VTTBR field values
In-Reply-To: <20160408124346.GN8961@cbox>
References: <1459787177-12767-1-git-send-email-suzuki.poulose@arm.com>
 <1459787177-12767-3-git-send-email-suzuki.poulose@arm.com>
 <20160408124346.GN8961@cbox>
Message-ID: <5707A7F5.1010104@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/04/16 13:43, Christoffer Dall wrote:
>> +#define VTCR_EL2_T0SZ_IPA	VTCR_EL2_T0SZ_40B
>> +#define VTCR_EL2_COMMON_BITS	(VTCR_EL2_SH0_INNER | VTCR_EL2_ORGN0_WBWA | \
>> +				 VTCR_EL2_IRGN0_WBWA | VTCR_EL2_SL0_LVL1 | \
>> +				 VTCR_EL2_RES1 | VTCR_EL2_T0SZ_IPA)
>>   #ifdef CONFIG_ARM64_64K_PAGES
>>   /*
>>    * Stage2 translation configuration:
>> - * 40bits input  (T0SZ = 24)
>>    * 64kB pages (TG0 = 1)
>>    * 2 level page tables (SL = 1)
>>    */
>> -#define VTCR_EL2_FLAGS		(VTCR_EL2_TG0_64K | VTCR_EL2_SH0_INNER | \
>> -				 VTCR_EL2_ORGN0_WBWA | VTCR_EL2_IRGN0_WBWA | \
>> -				 VTCR_EL2_SL0_LVL1 | VTCR_EL2_T0SZ_40B | \
>> -				 VTCR_EL2_RES1)
>> -#define VTTBR_X		(38 - VTCR_EL2_T0SZ_40B)
>> +#define VTCR_EL2_TGRAN_FLAGS	(VTCR_EL2_TG0_64K | VTCR_EL2_SL0_LVL1)
>> +#define VTTBR_X_TGRAN_MAGIC		38
>>   #else
>>   /*
>>    * Stage2 translation configuration:
>> - * 40bits input  (T0SZ = 24)
>>    * 4kB pages (TG0 = 0)
>>    * 3 level page tables (SL = 1)
>>    */
>> -#define VTCR_EL2_FLAGS		(VTCR_EL2_TG0_4K | VTCR_EL2_SH0_INNER | \
>> -				 VTCR_EL2_ORGN0_WBWA | VTCR_EL2_IRGN0_WBWA | \
>> -				 VTCR_EL2_SL0_LVL1 | VTCR_EL2_T0SZ_40B | \
>> -				 VTCR_EL2_RES1)
>> -#define VTTBR_X		(37 - VTCR_EL2_T0SZ_40B)
>> +#define VTCR_EL2_TGRAN_FLAGS		(VTCR_EL2_TG0_4K | VTCR_EL2_SL0_LVL1)
>> +#define VTTBR_X_TGRAN_MAGIC		37
>>   #endif
>
> why do we add VTCR_EL2_SL0_LVL1 in both the common bits and TGRAN_FLAGS
> define?

Oops! It should only be part of TGRAN_FLAGS. Thanks for spotting, will fix it.


> Otherwise:
>
> Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>


Thanks
Suzuki
