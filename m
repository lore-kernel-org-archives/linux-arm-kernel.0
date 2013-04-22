From: gang.chen@asianux.com (Chen Gang)
Date: Mon, 22 Apr 2013 13:08:22 +0800
Subject: [Suggestion] ARM64: kernel: compiling issue,
 need implement cmpxchg64 with assembler language.
In-Reply-To: <2182812.ymprEm6XBb@wuerfel>
References: <51712E5E.2020809@asianux.com> <201304191412.54601.arnd@arndb.de>
 <5171FD67.2080104@asianux.com> <2182812.ymprEm6XBb@wuerfel>
Message-ID: <5174C5C6.5010206@asianux.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2013?04?20? 15:32, Arnd Bergmann wrote:
> On Saturday 20 April 2013 10:28:55 Chen Gang wrote:
>>
>> -------------------------------patch begin--------------------------------------
>>
>> diff --git a/arch/arm64/include/asm/cmpxchg.h b/arch/arm64/include/asm/cmpxchg.h
>> index 968b5cb..b572d2b 100644
>> --- a/arch/arm64/include/asm/cmpxchg.h
>> +++ b/arch/arm64/include/asm/cmpxchg.h
>> @@ -170,4 +170,6 @@ static inline unsigned long __cmpxchg_mb(volatile void *ptr, unsigned long old,
>>                                        (unsigned long)(n),              \
>>                                        sizeof(*(ptr))))
>>  
>> +#define cmpxchg64(ptr,o,n)     cmpxchg((ptr),(o),(n))
>> +
>>  #endif /* __ASM_CMPXCHG_H */
> 
> Yes, this looks good. Please provide the same for cmpxchg64_local.
> 

  ok, thanks, I will send related patch.


gchen.
