From: Dave.Martin@arm.com (Dave Martin)
Date: Thu, 10 Aug 2017 09:01:16 +0100
Subject: [arm64:for-next/kernel-mode-neon 5/8]
 arch/arm64/crypto/sha1-ce-glue.c:41:2: error: implicit declaration of
 function 'kernel_neon_begin_partial'
In-Reply-To: <201708101207.xeLMkhqW%fengguang.wu@intel.com>
References: <201708101207.xeLMkhqW%fengguang.wu@intel.com>
Message-ID: <20170810080112.GP6321@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 10, 2017 at 12:38:09PM +0800, kbuild test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-next/kernel-mode-neon
> head:   66c3ec5a712005625437474cf5a04148d7890350
> commit: cb84d11e1625aa3a081d898ca2640bf3a9ca0e96 [5/8] arm64: neon: Remove support for nested or hardirq kernel-mode NEON
> config: arm64-defconfig (attached as .config)
> compiler: aarch64-linux-gnu-gcc (Debian 6.1.1-9) 6.1.1 20160705
> reproduce:
>         wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         git checkout cb84d11e1625aa3a081d898ca2640bf3a9ca0e96
>         # save the attached .config to linux build tree
>         make.cross ARCH=arm64 
> 
> Note: the arm64/for-next/kernel-mode-neon HEAD 66c3ec5a712005625437474cf5a04148d7890350 builds fine.
>       It only hurts bisectibility.

[...]

> All errors (new ones prefixed by >>):
> 
>    arch/arm64/crypto/sha1-ce-glue.c: In function 'sha1_ce_update':
> >> arch/arm64/crypto/sha1-ce-glue.c:41:2: error: implicit declaration of function 'kernel_neon_begin_partial' [-Werror=implicit-function-declaration]
>      kernel_neon_begin_partial(16);
>      ^~~~~~~~~~~~~~~~~~~~~~~~~
>    cc1: some warnings being treated as errors

[...]

AFAIK, this is expected, and will be fixed by merging the
corresponding crypto patches first.  So I don't propose to do
anything about it.

Have I missed something?

Cheers
---Dave
