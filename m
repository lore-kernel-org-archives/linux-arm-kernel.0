From: gang.chen@asianux.com (Chen Gang)
Date: Thu, 10 Oct 2013 15:34:29 +0800
Subject: [PATCH 1/3] s390: include: asm: atomic.h: use 'unsigned int'
 instead of 'unsigned long' for atomic_*_mask()
In-Reply-To: <20131010072508.GA4383@osiris>
References: <52561137.3070608@asianux.com> <5256117A.4000009@asianux.com>
 <20131010072508.GA4383@osiris>
Message-ID: <52565885.5030902@asianux.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/10/2013 03:25 PM, Heiko Carstens wrote:
> On Thu, Oct 10, 2013 at 10:31:22AM +0800, Chen Gang wrote:
>> The type of 'v->counter' is always 'int', and related inline assembly
>> code also process 'int', so use 'unsigned int' instead of 'unsigned
>> long' for the 'mask'.
>>
>>
>> Signed-off-by: Chen Gang <gang.chen@asianux.com>
>> ---
>>  arch/s390/include/asm/atomic.h |    4 ++--
>>  1 files changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/s390/include/asm/atomic.h b/arch/s390/include/asm/atomic.h
>> index a62ed2d..12c5ec1 100644
>> --- a/arch/s390/include/asm/atomic.h
>> +++ b/arch/s390/include/asm/atomic.h
>> @@ -113,12 +113,12 @@ static inline void atomic_add(int i, atomic_t *v)
>>  #define atomic_dec_return(_v)		atomic_sub_return(1, _v)
>>  #define atomic_dec_and_test(_v)		(atomic_sub_return(1, _v) == 0)
>>
>> -static inline void atomic_clear_mask(unsigned long mask, atomic_t *v)
>> +static inline void atomic_clear_mask(unsigned int mask, atomic_t *v)
>>  {
> 
> Applied. Thanks!
> 
> 
> 

Thank you very much!!

-- 
Chen Gang
