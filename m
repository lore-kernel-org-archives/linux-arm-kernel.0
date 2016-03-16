From: Suzuki.Poulose@arm.com (Suzuki K. Poulose)
Date: Wed, 16 Mar 2016 15:37:18 +0000
Subject: [RFC PATCH 03/12] arm64: kvm: Cleanup VTCR_EL2/VTTBR computation
In-Reply-To: <56E9755C.9090701@arm.com>
References: <1457974391-28456-1-git-send-email-suzuki.poulose@arm.com>
 <1457974391-28456-4-git-send-email-suzuki.poulose@arm.com>
 <56E9755C.9090701@arm.com>
Message-ID: <56E97DAE.2030704@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16/03/16 15:01, Marc Zyngier wrote:
> On 14/03/16 16:53, Suzuki K Poulose wrote:
>> No functional changes. Group the common bits for VCTR_EL2
>> initialisation for better readability. The granule size
>> and the entry level are controlled by the page size.

>>
>> diff --git a/arch/arm64/include/asm/kvm_arm.h b/arch/arm64/include/asm/kvm_arm.h
>> index b7d61e4..d49dd50 100644
>> --- a/arch/arm64/include/asm/kvm_arm.h
>> +++ b/arch/arm64/include/asm/kvm_arm.h
>> @@ -139,32 +139,30 @@
>>    * The magic numbers used for VTTBR_X in this patch can be found in Tables
>>    * D4-23 and D4-25 in ARM DDI 0487A.b.
>>    */

...

>>
>> +#define VTCR_EL2_FLAGS		(VTCR_EL2_TGRAN_FLAGS | VTCR_EL2_COMMON_BITS)
>> +#define VTTBR_X			((VTTBR_X_TGRAN_MAGIC) - VTCR_EL2_T0SZ_40B)
>
> Nit: spurious brackets.
  
Will remove them.

> It would be nice to add an ARMv8 ARM reference to where the "magic"
> value is coming from.

That reference already exists in the code, see above.

>
>> +
>>   #define VTTBR_BADDR_SHIFT (VTTBR_X - 1)
>>   #define VTTBR_BADDR_MASK  (((UL(1) << (PHYS_MASK_SHIFT - VTTBR_X)) - 1) << VTTBR_BADDR_SHIFT)
>>   #define VTTBR_VMID_SHIFT  (UL(48))
>>
>
> Otherwise:
>
> Acked-by: Marc Zyngier <marc.zyngier@arm.com>

Thanks
Suzuki
