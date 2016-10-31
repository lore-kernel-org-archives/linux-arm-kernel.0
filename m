From: tbaicar@codeaurora.org (Baicar, Tyler)
Date: Mon, 31 Oct 2016 16:36:33 -0600
Subject: [PATCH V4 10/10] arm64: KVM: add guest SEA support
In-Reply-To: <20161031100206.GX1041@n2100.armlinux.org.uk>
References: <1477071013-29563-1-git-send-email-tbaicar@codeaurora.org>
 <1477071013-29563-11-git-send-email-tbaicar@codeaurora.org>
 <20161031100206.GX1041@n2100.armlinux.org.uk>
Message-ID: <85443ee1-9981-c7e8-fe88-a3aac48c3e80@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Russell,

On 10/31/2016 4:02 AM, Russell King - ARM Linux wrote:
> The subject line on this patch is misleading - it's not only ARM64
> specific...
Thank you for the feedback!

I only put ARM64 in the subject line because this patch only really adds 
guest SEA support for the ARM64 KVM code. The ARM code had to be edited 
since both the ARM and ARM64 KVM code use arch/arm/kvm/mmu.c. I can 
change the subject line to "arm/arm64: KVM: add guest SEA support" if 
you think that is better.
> On Fri, Oct 21, 2016 at 11:30:13AM -0600, Tyler Baicar wrote:
>> diff --git a/arch/arm/include/asm/system_misc.h b/arch/arm/include/asm/system_misc.h
>> index a3d61ad..86e1faa 100644
>> --- a/arch/arm/include/asm/system_misc.h
>> +++ b/arch/arm/include/asm/system_misc.h
>> @@ -24,4 +24,9 @@ extern unsigned int user_debug;
>>   
>>   #endif /* !__ASSEMBLY__ */
>>   
>> +inline int handle_guest_sea(unsigned long addr, unsigned int esr)
> This needs to be static.
I'll make this static.

Thanks,
Tyler
>> +{
>> +	return -1;
>> +}
>> +
>>   #endif /* __ASM_ARM_SYSTEM_MISC_H */

-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project.
