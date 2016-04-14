From: Suzuki.Poulose@arm.com (Suzuki K Poulose)
Date: Thu, 14 Apr 2016 17:47:44 +0100
Subject: [PATCH v3 6/7] arm64: Add a wrapper for personality() syscall
In-Reply-To: <20160414164446.GI4584@arm.com>
References: <1459445255-15653-1-git-send-email-suzuki.poulose@arm.com>
 <1459445255-15653-7-git-send-email-suzuki.poulose@arm.com>
 <20160414164446.GI4584@arm.com>
Message-ID: <570FC9B0.50201@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14/04/16 17:44, Will Deacon wrote:
> On Thu, Mar 31, 2016 at 06:27:34PM +0100, Suzuki K Poulose wrote:
>> In order to prevent setting PER_LINUX32 on systems without
>> 32bit EL0 support, add a wrapper for personality() syscall.
>>

>>   /*
>>    * Wrappers to pass the pt_regs argument.
>>    */
>>   asmlinkage long sys_rt_sigreturn_wrapper(void);
>>   #define sys_rt_sigreturn	sys_rt_sigreturn_wrapper
>> +#define sys_personality		sys_arm64_personality
>
> You can merge this in with the subsequent patch, since it doesn't do
> anything on its own.
>

OK, I kept it separate because we were in effect modifying the syscall table
contents. I can merge it.

Suzuki
