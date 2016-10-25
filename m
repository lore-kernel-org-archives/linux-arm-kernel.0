From: shorne@gmail.com (Stafford Horne)
Date: Tue, 25 Oct 2016 21:51:09 +0900 (JST)
Subject: [PATCH] asm-generic: Drop getrlimit and setrlimit syscalls from
 default list
In-Reply-To: <CAFiDJ59PdOiqiF8wFVFrkB4k0B6S5cTGVQPUpdjZ=83iv7GQag@mail.gmail.com>
References: <1477138444-14993-1-git-send-email-ynorov@caviumnetworks.com>
 <20161024090931.GR7370@jhogan-linux.le.imgtec.org>
 <CAFiDJ59PdOiqiF8wFVFrkB4k0B6S5cTGVQPUpdjZ=83iv7GQag@mail.gmail.com>
Message-ID: <alpine.LFD.2.20.1610252150280.3778@lianli.shorne-pla.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Tue, 25 Oct 2016, Ley Foon Tan wrote:

> On Mon, Oct 24, 2016 at 5:09 PM, James Hogan <james.hogan@imgtec.com> wrote:
>> On Sat, Oct 22, 2016 at 03:14:04PM +0300, Yury Norov wrote:
>>> The newer prlimit64 syscall provides all the functionality provided by
>>> the getrlimit and setrlimit syscalls and adds the pid of target process,
>>> so future architectures won't need to include getrlimit and setrlimit.
>>>
>>> Therefore drop getrlimit and setrlimit syscalls from the generic syscall
>>> list unless __ARCH_WANT_SET_GET_RLIMIT is defined by the architecture's
>>> unistd.h prior to including asm-generic/unistd.h, and adjust all
>>> architectures using the generic syscall list to define it so that no
>>> in-tree architectures are affected.
>>>
>>> Cc: Vineet Gupta <vgupta@synopsys.com>
>>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>>> Cc: Will Deacon <will.deacon@arm.com>
>>> Cc: Mark Salter <msalter@redhat.com>
>>> Cc: Aurelien Jacquiot <a-jacquiot@ti.com>
>>> Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
>>> Cc: Richard Kuo <rkuo@codeaurora.org>
>>> Cc: James Hogan <james.hogan@imgtec.com>
>>> Cc: Ley Foon Tan <lftan@altera.com>
>>> Cc: Jonas Bonn <jonas@southpole.se>
>>> Cc: Chen Liqin <liqin.linux@gmail.com>
>>> Cc: Lennox Wu <lennox.wu@gmail.com>
>>> Cc: Chris Metcalf <cmetcalf@mellanox.com>
>>> Cc: Guan Xuetao <gxt@mprc.pku.edu.cn>
>>> Cc: Arnd Bergmann <arnd@arndb.de>
>>> Cc: Andrew Pinski <Andrew.Pinski@cavium.com>
>>> Cc: linux-snps-arc at lists.infradead.org
>>> Cc: linux-kernel at vger.kernel.org
>>> Cc: linux-arm-kernel at lists.infradead.org
>>> Cc: linux-c6x-dev at linux-c6x.org
>>> Cc: uclinux-h8-devel at lists.sourceforge.jp
>>> Cc: linux-hexagon at vger.kernel.org
>>> Cc: linux-metag at vger.kernel.org
>>> Cc: nios2-dev at lists.rocketboards.org
>>> Cc: linux-arch at vger.kernel.or
>>> Signed-off-by: Yury Norov <ynorov@caviumnetworks.com>
>>>
>>> ---
>>>  arch/arc/include/uapi/asm/unistd.h       | 1 +
>>>  arch/arm64/include/uapi/asm/unistd.h     | 1 +
>>>  arch/c6x/include/uapi/asm/unistd.h       | 1 +
>>>  arch/h8300/include/uapi/asm/unistd.h     | 1 +
>>>  arch/hexagon/include/uapi/asm/unistd.h   | 1 +
>>>  arch/metag/include/uapi/asm/unistd.h     | 1 +
>>
>> Acked-by: James Hogan <james.hogan@imgtec.com> [metag]
>>
>> Cheers
>> James
>>
>>>  arch/nios2/include/uapi/asm/unistd.h     | 1 +
> Acked-by: Ley Foon Tan <lftan@altera.com> [nios2]
>
>
>>>  arch/openrisc/include/uapi/asm/unistd.h  | 1 +

Acked-by: Stafford Horne <shorne@gmail.com> [openrisc]

>>>  arch/score/include/uapi/asm/unistd.h     | 1 +
>>>  arch/tile/include/uapi/asm/unistd.h      | 1 +
>>>  arch/unicore32/include/uapi/asm/unistd.h | 1 +
>>>  include/uapi/asm-generic/unistd.h        | 5 +++++
>>>  12 files changed, 16 insertions(+)
>>>
>>> diff --git a/arch/arc/include/uapi/asm/unistd.h b/arch/arc/include/uapi/asm/unistd.h
>>> index 41fa2ec..928546d 100644
>>> --- a/arch/arc/include/uapi/asm/unistd.h
>>> +++ b/arch/arc/include/uapi/asm/unistd.h
>>> @@ -16,6 +16,7 @@
>>>  #define _UAPI_ASM_ARC_UNISTD_H
>>>
>>>  #define __ARCH_WANT_RENAMEAT
>>> +#define __ARCH_WANT_SET_GET_RLIMIT
>>>  #define __ARCH_WANT_SYS_EXECVE
>>>  #define __ARCH_WANT_SYS_CLONE
>>>  #define __ARCH_WANT_SYS_VFORK
>>> diff --git a/arch/arm64/include/uapi/asm/unistd.h b/arch/arm64/include/uapi/asm/unistd.h
>>> index 043d17a..48355a6 100644
>>> --- a/arch/arm64/include/uapi/asm/unistd.h
>>> +++ b/arch/arm64/include/uapi/asm/unistd.h
>>> @@ -15,5 +15,6 @@
>>>   */
>>>
>>>  #define __ARCH_WANT_RENAMEAT
>>> +#define __ARCH_WANT_SET_GET_RLIMIT
>>>
>>>  #include <asm-generic/unistd.h>
>>> diff --git a/arch/c6x/include/uapi/asm/unistd.h b/arch/c6x/include/uapi/asm/unistd.h
>>> index 12d73d9..f676231 100644
>>> --- a/arch/c6x/include/uapi/asm/unistd.h
>>> +++ b/arch/c6x/include/uapi/asm/unistd.h
>>> @@ -15,6 +15,7 @@
>>>   */
>>>
>>>  #define __ARCH_WANT_RENAMEAT
>>> +#define __ARCH_WANT_SET_GET_RLIMIT
>>>  #define __ARCH_WANT_SYS_CLONE
>>>
>>>  /* Use the standard ABI for syscalls. */
>>> diff --git a/arch/h8300/include/uapi/asm/unistd.h b/arch/h8300/include/uapi/asm/unistd.h
>>> index 7dd20ef..2f98394 100644
>>> --- a/arch/h8300/include/uapi/asm/unistd.h
>>> +++ b/arch/h8300/include/uapi/asm/unistd.h
>>> @@ -1,5 +1,6 @@
>>>  #define __ARCH_NOMMU
>>>
>>>  #define __ARCH_WANT_RENAMEAT
>>> +#define __ARCH_WANT_SET_GET_RLIMIT
>>>
>>>  #include <asm-generic/unistd.h>
>>> diff --git a/arch/hexagon/include/uapi/asm/unistd.h b/arch/hexagon/include/uapi/asm/unistd.h
>>> index 2151760..52d585c 100644
>>> --- a/arch/hexagon/include/uapi/asm/unistd.h
>>> +++ b/arch/hexagon/include/uapi/asm/unistd.h
>>> @@ -28,6 +28,7 @@
>>>
>>>  #define sys_mmap2 sys_mmap_pgoff
>>>  #define __ARCH_WANT_RENAMEAT
>>> +#define __ARCH_WANT_SET_GET_RLIMIT
>>>  #define __ARCH_WANT_SYS_EXECVE
>>>  #define __ARCH_WANT_SYS_CLONE
>>>  #define __ARCH_WANT_SYS_VFORK
>>> diff --git a/arch/metag/include/uapi/asm/unistd.h b/arch/metag/include/uapi/asm/unistd.h
>>> index 459b6ec..16b5cb3 100644
>>> --- a/arch/metag/include/uapi/asm/unistd.h
>>> +++ b/arch/metag/include/uapi/asm/unistd.h
>>> @@ -8,6 +8,7 @@
>>>   */
>>>
>>>  #define __ARCH_WANT_RENAMEAT
>>> +#define __ARCH_WANT_SET_GET_RLIMIT
>>>
>>>  /* Use the standard ABI for syscalls. */
>>>  #include <asm-generic/unistd.h>
>>> diff --git a/arch/nios2/include/uapi/asm/unistd.h b/arch/nios2/include/uapi/asm/unistd.h
>>> index 51a32c7..b0dda4d 100644
>>> --- a/arch/nios2/include/uapi/asm/unistd.h
>>> +++ b/arch/nios2/include/uapi/asm/unistd.h
>>> @@ -18,6 +18,7 @@
>>>   #define sys_mmap2 sys_mmap_pgoff
>>>
>>>  #define __ARCH_WANT_RENAMEAT
>>> +#define __ARCH_WANT_SET_GET_RLIMIT
>>>
>>>  /* Use the standard ABI for syscalls */
>>>  #include <asm-generic/unistd.h>
>>> diff --git a/arch/openrisc/include/uapi/asm/unistd.h b/arch/openrisc/include/uapi/asm/unistd.h
>>> index 471905b..6812d81 100644
>>> --- a/arch/openrisc/include/uapi/asm/unistd.h
>>> +++ b/arch/openrisc/include/uapi/asm/unistd.h
>>> @@ -21,6 +21,7 @@
>>>  #define sys_mmap2 sys_mmap_pgoff
>>>
>>>  #define __ARCH_WANT_RENAMEAT
>>> +#define __ARCH_WANT_SET_GET_RLIMIT
>>>  #define __ARCH_WANT_SYS_FORK
>>>  #define __ARCH_WANT_SYS_CLONE
>>>
>>> diff --git a/arch/score/include/uapi/asm/unistd.h b/arch/score/include/uapi/asm/unistd.h
>>> index d4008c3..7ad1bdc 100644
>>> --- a/arch/score/include/uapi/asm/unistd.h
>>> +++ b/arch/score/include/uapi/asm/unistd.h
>>> @@ -1,6 +1,7 @@
>>>  #define __ARCH_HAVE_MMU
>>>
>>>  #define __ARCH_WANT_RENAMEAT
>>> +#define __ARCH_WANT_SET_GET_RLIMIT
>>>  #define __ARCH_WANT_SYSCALL_NO_AT
>>>  #define __ARCH_WANT_SYSCALL_NO_FLAGS
>>>  #define __ARCH_WANT_SYSCALL_OFF_T
>>> diff --git a/arch/tile/include/uapi/asm/unistd.h b/arch/tile/include/uapi/asm/unistd.h
>>> index 24e9187..cf0505f 100644
>>> --- a/arch/tile/include/uapi/asm/unistd.h
>>> +++ b/arch/tile/include/uapi/asm/unistd.h
>>> @@ -13,6 +13,7 @@
>>>   */
>>>
>>>  #define __ARCH_WANT_RENAMEAT
>>> +#define __ARCH_WANT_SET_GET_RLIMIT
>>>  #if !defined(__LP64__) || defined(__SYSCALL_COMPAT)
>>>  /* Use the flavor of this syscall that matches the 32-bit API better. */
>>>  #define __ARCH_WANT_SYNC_FILE_RANGE2
>>> diff --git a/arch/unicore32/include/uapi/asm/unistd.h b/arch/unicore32/include/uapi/asm/unistd.h
>>> index 1f63c47..ef25aec 100644
>>> --- a/arch/unicore32/include/uapi/asm/unistd.h
>>> +++ b/arch/unicore32/include/uapi/asm/unistd.h
>>> @@ -11,6 +11,7 @@
>>>   */
>>>
>>>  #define __ARCH_WANT_RENAMEAT
>>> +#define __ARCH_WANT_SET_GET_RLIMIT
>>>
>>>  /* Use the standard ABI for syscalls. */
>>>  #include <asm-generic/unistd.h>
>>> diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
>>> index 9b1462e..bbaeac0 100644
>>> --- a/include/uapi/asm-generic/unistd.h
>>> +++ b/include/uapi/asm-generic/unistd.h
>>> @@ -465,10 +465,15 @@ __SYSCALL(__NR_uname, sys_newuname)
>>>  __SYSCALL(__NR_sethostname, sys_sethostname)
>>>  #define __NR_setdomainname 162
>>>  __SYSCALL(__NR_setdomainname, sys_setdomainname)
>>> +
>>> +#ifdef __ARCH_WANT_SET_GET_RLIMIT
>>> +/* getrlimit and setrlimit are superseded with prlimit64 */
>>>  #define __NR_getrlimit 163
>>>  __SC_COMP(__NR_getrlimit, sys_getrlimit, compat_sys_getrlimit)
>>>  #define __NR_setrlimit 164
>>>  __SC_COMP(__NR_setrlimit, sys_setrlimit, compat_sys_setrlimit)
>>> +#endif
>>> +
>>>  #define __NR_getrusage 165
>>>  __SC_COMP(__NR_getrusage, sys_getrusage, compat_sys_getrusage)
>>>  #define __NR_umask 166
>>> --
>>> 2.7.4
>>>
>
