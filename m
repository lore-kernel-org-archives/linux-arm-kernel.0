From: behanw@converseincode.com (Behan Webster)
Date: Thu, 31 Jul 2014 09:04:25 -0700
Subject: [PATCH 3/4] arm64: LLVMLinux: Calculate current_thread_info from
 current_stack_pointer
In-Reply-To: <53D9D4B2.8070008@suse.de>
References: <1406764649-20326-1-git-send-email-behanw@converseincode.com>
 <1406764649-20326-4-git-send-email-behanw@converseincode.com>
 <53D9D4B2.8070008@suse.de>
Message-ID: <53DA6909.1050007@converseincode.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/30/14 22:31, Andreas F?rber wrote:
> Hi,
>
> Am 31.07.2014 01:57, schrieb behanw at converseincode.com:
>> From: Behan Webster <behanw@converseincode.com>
>>
>> Use the global current_stack_pointer to get the value of the stack pointer.
>> This change supports being able to compile the kernel with both gcc and clang.
>>
>> Signed-off-by: Behan Webster <behanw@converseincode.com>
>> Signed-off-by: Mark Charlebois <charlebm@gmail.com>
>> Reviewed-by: Jan-Simon M??ller <dl9pf@gmx.de>
> Something went wrong with ? encoding here and in 2/4.
Yeah. That keeps happening. :(

Thanks.

>> ---
>>   arch/arm64/include/asm/thread_info.h | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/arm64/include/asm/thread_info.h b/arch/arm64/include/asm/thread_info.h
>> index e6b6094..c2432d2 100644
>> --- a/arch/arm64/include/asm/thread_info.h
>> +++ b/arch/arm64/include/asm/thread_info.h
>> @@ -80,8 +80,8 @@ static inline struct thread_info *current_thread_info(void) __attribute_const__;
>>   
>>   static inline struct thread_info *current_thread_info(void)
>>   {
>> -	register unsigned long sp asm ("sp");
>> -	return (struct thread_info *)(sp & ~(THREAD_SIZE - 1));
>> +	return (struct thread_info *) \
> This is not a macro, so \ seems superfluous.
Doh. Indeed. Will fix.

Behan

-- 
Behan Webster
behanw at converseincode.com
