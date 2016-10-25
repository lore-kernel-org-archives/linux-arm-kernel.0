From: rth@twiddle.net (Richard Henderson)
Date: Tue, 25 Oct 2016 10:03:43 -0700
Subject: [PATCH 2/3] ARM: convert to generated system call tables
In-Reply-To: <4146248.jXuviLlvH5@wuerfel>
References: <E1bwa6s-0004ZY-4k@rmk-PC.armlinux.org.uk>
 <3851270.xZRcP9hae0@wuerfel> <20161025091210.rjfhvq4mqtuquei5@tower>
 <4146248.jXuviLlvH5@wuerfel>
Message-ID: <d113bb21-cf52-6531-10b4-f73fc0b9e809@twiddle.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/25/2016 03:28 AM, Arnd Bergmann wrote:
> On Tuesday, October 25, 2016 10:12:10 PM CEST Michael Cree wrote:
>> On Fri, Oct 21, 2016 at 03:06:45PM +0200, Arnd Bergmann wrote:
>>> I see your point, but I think there are serious issues with the current
>>> approach as well:
>>>
>>> - a lot of the less common architectures just don't get updated
>>>   in time, out of 22 architectures that don't use asm-generic/unistd.h,
>>>   only 12 have pwritev2 in linux-next, and only three have pkey_mprotect
>>>
>>> - some architectures that add all syscalls sometimes make a mistake
>>>   and forget one, e.g. alpha apparently never added __NR_bpf, but it
>>>   did add the later __NR_execveat.
>>
>> __NR_bpf was not forgotten on Alpha.  It was not wired up because
>> extra architecture support is needed which has not been implemented.
>>
>> But maybe we should just wire it up to sys_ni_syscall in the meantime
>> so a syscall number is reserved for it, and user space can call it to
>> get -ENOSYS returned.
> 
> Ah, I must have misinterpreted the code then. I assumed that the
> bpf syscall always works on all architectures, but that only the
> jit compiler for it required architecture specific code to make it
> more efficient.

That was my interpretation as well.  What's the problem, Michael?


r~
