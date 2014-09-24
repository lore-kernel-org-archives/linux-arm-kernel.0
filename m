From: behanw@converseincode.com (Behan Webster)
Date: Wed, 24 Sep 2014 11:11:43 -0700
Subject: [PATCH] arm, vt8500, LLVMLlinux: Use mcr instead of mcr% for
 mach-vt8500
In-Reply-To: <7810937.UX61PvX9nB@wuerfel>
References: <1411530284-28807-1-git-send-email-behanw@converseincode.com>
 <7810937.UX61PvX9nB@wuerfel>
Message-ID: <5423095F.9030802@converseincode.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/24/14 02:16, Arnd Bergmann wrote:
> On Tuesday 23 September 2014 20:44:44 Behan Webster wrote:
>> The ASM below does not compile with clang and is not the way that the mcr
>> command is used in other parts of the kernel.
>>
>> arch/arm/mach-vt8500/vt8500.c:72:11: error: invalid % escape in inline assembly string
>>          asm("mcr%? p15, 0, %0, c7, c0, 4" : : "r" (0));
>>              ~~~~~^~~~~~~~~~~~~~~~~~~~~~~~
>> 1 error generated.
>>
>> There are other forms that are supported on different ARM instruction sets but
>> generally the kernel just uses mcr as it is supported in all ARM instruction
>> sets.
> Just for confirm: both forms are actually correct and we don't need this
> backported for stable, right?
My understanding is that the %? carries a condition code to the next 
instruction (which in this case is then ignored). So essentially in this 
situation both are equivalent.

>> Signed-off-by: Behan Webster <behanw@converseincode.com>
>> Reviewed-by: Mark Charlebois <charlebm@gmail.com>
>> Acked-by: Will Deacon <will.deacon@arm.com>
> Acked-by: Arnd Bergmann <arnd@arndb.de>
>
> Tony, would you like to pick this one up and send it in a pull request
> to arm-soc, or should we apply it to fixes-non-critical directly?
Thanks,

Behan

-- 
Behan Webster
behanw at converseincode.com
