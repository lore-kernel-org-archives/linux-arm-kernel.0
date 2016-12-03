From: marc.zyngier@arm.com (Marc Zyngier)
Date: Sat, 03 Dec 2016 10:38:26 +0000
Subject: [arm64:for-next/core 52/52]
 arch/arm64/include/asm/probes.h:18:25: fatal error: asm/opcodes.h: No such
 file or directory
In-Reply-To: <201612030617.rGmhD67h%fengguang.wu@intel.com> (kbuild test
 robot's message of "Sat, 3 Dec 2016 06:05:27 +0800")
References: <201612030617.rGmhD67h%fengguang.wu@intel.com>
Message-ID: <86h96lmh5p.fsf@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 02 2016 at 10:05:27 PM, kbuild test robot <fengguang.wu@intel.com> wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-next/core
> head:   bca8f17f57bd76ddf2bbd2527eb890d6f588853e
> commit: bca8f17f57bd76ddf2bbd2527eb890d6f588853e [52/52] arm64: Get rid of asm/opcodes.h
> config: arm64-allmodconfig (attached as .config)
> compiler: aarch64-linux-gnu-gcc (Debian 6.1.1-9) 6.1.1 20160705
> reproduce:
>         wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         git checkout bca8f17f57bd76ddf2bbd2527eb890d6f588853e
>         # save the attached .config to linux build tree
>         make.cross ARCH=arm64 
>
> All errors (new ones prefixed by >>):
>
>    In file included from arch/arm64/include/asm/uprobes.h:14:0,
>                     from include/linux/uprobes.h:61,
>                     from include/linux/mm_types.h:13,
>                     from include/linux/sched.h:27,
>                     from arch/arm64/kernel/asm-offsets.c:21:
>>> arch/arm64/include/asm/probes.h:18:25: fatal error: asm/opcodes.h: No such file or directory
>     #include <asm/opcodes.h>
>                             ^
>    compilation terminated.
>    make[2]: *** [arch/arm64/kernel/asm-offsets.s] Error 1
>    make[2]: Target '__build' not remade because of errors.
>    make[1]: *** [prepare0] Error 2
>    make[1]: Target 'prepare' not remade because of errors.
>    make: *** [sub-make] Error 2

Blah. Bloody uprobes. Just deleting this line should be enough, as I
can't see anything that actually depends on what is in the 32bit
asm/opcodes.h.

I can submit a patch if needed.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny.
