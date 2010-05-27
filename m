From: fachkar.datawind@gmail.com (f. achkar)
Date: Thu, 27 May 2010 10:53:41 -0400
Subject: defining ARM machine type properly
In-Reply-To: <AANLkTilhxt5hVjffJMRPzN477Czw2_Xtqo2joYvo1vM3@mail.gmail.com>
References: <4BFD8E7A.6050103@gmail.com>
	<AANLkTilhxt5hVjffJMRPzN477Czw2_Xtqo2joYvo1vM3@mail.gmail.com>
Message-ID: <4BFE8775.4000200@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/26/2010 11:14 PM, Wan ZongShun wrote:
> 2010/5/27 f. achkar <fachkar.datawind@gmail.com>:
>   
>> hi,
>> I'm trying to port smdk2450 arch to the a new kernel 2.6.32-9, I did the
>> initial work as per various googled documents, but somehow the current
>> initial Image is failing at arch/arm/kernel/head-common.S :
>> '__lookup_processor_type', and eventually goes to '__error_a' of the
>>     
> The '__lookup_processor_type' goes to '__error_a'  is not related to
> your machine_type,
> you should check whether there is a true definition of  select
> CPU_ARMxx in the arch/arm/kconfig.
>   
 Symbol: MACH_SMDK2450
[=y]                                                                                                    
? 
  ? Prompt:
SMDK2450                                                                                                              
? 
  ?   Defined at
arch/arm/mach-s3c2450/Kconfig:30                                                                                 
? 
  ?   Depends on:
ARCH_S3C2410                                                                                                    
? 
  ?  
Location:                                                                                                                   
? 
  ?     -> System
Type                                                                                                            
? 
  ?       -> S3C2450
Machines                                                                                                     
? 
  ?   Selects: CPU_S3C2450 && MACH_SMDK
> The issue maybe result from you get a wrong ARM processor type
> number,which is not equal to
> the R9 resigster value.
>   
most likely the case, what should be my check-list to verify correct doing?
thanks,
>   
>> same file! this seems to be related to the definition of machine_type as
>> defined in :
>> include/asm-arm/mach-types.h  and arch/arm/tools/mach-types*
>> I checked where the definition goes in  include/asm-arm/mach-types.h by
>> inserting
>> #error 2223XX
>> into various parts of that header and seems fine at the point.
>> nevertheless I'm not 100 sure
>> I wonder if the is a definitive reference to guide in this matter,
>> better yet a check-list like procedure??
>> thanks,
>> ferar
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel at lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>>
>>     
>
>
>   
