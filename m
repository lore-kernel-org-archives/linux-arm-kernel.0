From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Tue, 12 Sep 2017 13:43:52 +0900
Subject: [PATCH 8/9] arm64: enable KEXEC_FILE config
In-Reply-To: <201709102315.3pEUMBHR%fengguang.wu@intel.com>
References: <20170908031616.17916-9-takahiro.akashi@linaro.org>
 <201709102315.3pEUMBHR%fengguang.wu@intel.com>
Message-ID: <20170912044350.GG17186@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Sep 10, 2017 at 11:41:47PM +0800, kbuild test robot wrote:
> Hi AKASHI,
> 
> [auto build test ERROR on arm64/for-next/core]
> [also build test ERROR on v4.13 next-20170908]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
> 
> url:    https://github.com/0day-ci/linux/commits/AKASHI-Takahiro/kexec-add-kexec_file_load-support/20170910-143930
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-next/core
> config: arm64-allmodconfig (attached as .config)
> compiler: aarch64-linux-gnu-gcc (Debian 6.1.1-9) 6.1.1 20160705
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         make.cross ARCH=arm64 
> 
> Note: the linux-review/AKASHI-Takahiro/kexec-add-kexec_file_load-support/20170910-143930 HEAD caf976acefa5a78ad88489581c66b98cbc8f91fa builds fine.
>       It only hurts bisectibility.
> 
> All errors (new ones prefixed by >>):
> 
> >> arch/arm64/kernel/machine_kexec_file.c:22:28: fatal error: asm/kexec_file.h: No such file or directory
>     #include <asm/kexec_file.h>
>                                ^

Will fix it in the next version, v3.

-Takahiro AKASHI

>    compilation terminated.
> 
> vim +22 arch/arm64/kernel/machine_kexec_file.c
> 
> 423cf6dc9f AKASHI Takahiro 2017-09-08  15  
> 423cf6dc9f AKASHI Takahiro 2017-09-08  16  #include <linux/errno.h>
> 423cf6dc9f AKASHI Takahiro 2017-09-08  17  #include <linux/kernel.h>
> 423cf6dc9f AKASHI Takahiro 2017-09-08  18  #include <linux/kexec.h>
> 423cf6dc9f AKASHI Takahiro 2017-09-08  19  #include <linux/libfdt.h>
> 423cf6dc9f AKASHI Takahiro 2017-09-08  20  #include <linux/memblock.h>
> 423cf6dc9f AKASHI Takahiro 2017-09-08  21  #include <linux/of_fdt.h>
> 423cf6dc9f AKASHI Takahiro 2017-09-08 @22  #include <asm/kexec_file.h>
> 423cf6dc9f AKASHI Takahiro 2017-09-08  23  
> 
> :::::: The code at line 22 was first introduced by commit
> :::::: 423cf6dc9f06d95907902b2b7f84161bdc98f752 arm64: kexec_file: load initrd, device-tree and purgatory segments
> 
> :::::: TO: AKASHI Takahiro <takahiro.akashi@linaro.org>
> :::::: CC: 0day robot <fengguang.wu@intel.com>
> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
