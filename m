From: catalin.marinas@arm.com (Catalin Marinas)
Date: Sat, 17 Feb 2018 08:40:35 +0000
Subject: [arm64:fixes/core 4/5]
 arch/arm64/kernel/armv8_deprecated.c:404:31: warning: passing argument 1 of
 '__range_ok' makes pointer from integer without a cast
In-Reply-To: <201802171213.ppCdl9kU%fengguang.wu@intel.com>
References: <201802171213.ppCdl9kU%fengguang.wu@intel.com>
Message-ID: <20180217084035.4guuuvzoka4zdabo@armageddon.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Feb 17, 2018 at 12:38:16PM +0800, kbuild test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git fixes/core
> head:   8d77124b84783bc37517edc6223d501092ab8e53
> commit: 6e3941e8f8e106e25343f140b9d73a2bc64730a7 [4/5] arm64: uaccess: Clean up types for access_ok()
> config: arm64-allmodconfig (attached as .config)
> compiler: aarch64-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         git checkout 6e3941e8f8e106e25343f140b9d73a2bc64730a7
>         # save the attached .config to linux build tree
>         make.cross ARCH=arm64 
> 
> All warnings (new ones prefixed by >>):
> 
>    In file included from include/linux/uaccess.h:14:0,
>                     from arch/arm64/kernel/armv8_deprecated.c:23:
>    arch/arm64/kernel/armv8_deprecated.c: In function 'swp_handler':
> >> arch/arm64/kernel/armv8_deprecated.c:404:31: warning: passing argument 1 of '__range_ok' makes pointer from integer without a cast [-Wint-conversion]
>      if (!access_ok(VERIFY_WRITE, (address & ~3), 4)) {
>                                   ^
>    arch/arm64/include/asm/uaccess.h:107:48: note: in definition of macro 'access_ok'
>     #define access_ok(type, addr, size) __range_ok(addr, size)
>                                                    ^~~~
>    arch/arm64/include/asm/uaccess.h:75:29: note: expected 'const void *' but argument is of type 'u32 {aka unsigned int}'
>     static inline unsigned long __range_ok(const void __user *addr, unsigned long size)
>                                 ^~~~~~~~~~

Thanks for the report. It's an easy fix but I'm dropping this patch for
now and wait for Robin to update. I'll re-send this patch after -rc2.

-- 
Catalin
