From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 14 Aug 2013 15:15:17 -0700
Subject: [PATCH] ARM: LLVMLinux: Change "extern inline" to "gnu_inline"
 in ARM ftrace.h
In-Reply-To: <1376517370.1949.115.camel@joe-AO722>
References: <1376516261-2071-1-git-send-email-behanw@converseincode.com>
 <1376516261-2071-2-git-send-email-behanw@converseincode.com>
 <1376517370.1949.115.camel@joe-AO722>
Message-ID: <520C0175.4050003@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/14/13 14:56, Joe Perches wrote:
> On Wed, 2013-08-14 at 17:37 -0400, behanw at converseincode.com wrote:
>> From: Mark Charlebois <charlebm@gmail.com>
>>
>> With compilers which follow the C99 standard (like modern versions of gcc and
>> clang), "extern inline" does the wrong thing (emits code for an externally
>> linkable version of the inline function). In this case using the gnu_inline
>> attribute makes inline do the right thing on gcc and on clang.
> Why not convert these to static inline?

In this case we should probably just delete the entire thing and make it
unconditional in the header. It looks like it compiles with gcc still.

>
>> diff --git a/arch/arm/include/asm/ftrace.h b/arch/arm/include/asm/ftrace.h
> []
>> @@ -45,7 +45,8 @@ void *return_address(unsigned int);
>>  
>>  #else
>>  
>> -extern inline void *return_address(unsigned int level)
>> +extern inline __attribute__((gnu_inline))
>> +void *return_address(unsigned int level)
>>  {
>>  	return NULL;
>>  }
>
-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
