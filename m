From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Thu, 19 Oct 2017 13:36:14 +0900
Subject: [PATCH v5 03/10] kexec_file: factor out arch_kexec_kernel_*()
 from x86, powerpc
In-Reply-To: <201710141902.VMF5VddZ%fengguang.wu@intel.com>
References: <20171010063619.6303-4-takahiro.akashi@linaro.org>
 <201710141902.VMF5VddZ%fengguang.wu@intel.com>
Message-ID: <20171019043613.GF8215@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Oct 14, 2017 at 07:37:04PM +0800, kbuild test robot wrote:
> Hi AKASHI,
> 
> [auto build test WARNING on arm64/for-next/core]
> [also build test WARNING on v4.14-rc4 next-20171013]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
> 
> url:    https://github.com/0day-ci/linux/commits/AKASHI-Takahiro/arm64-kexec-add-kexec_file_load-support/20171012-003448
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-next/core
> config: x86_64-randconfig-in0-10141752 (attached as .config)
> compiler: gcc-4.6 (Debian 4.6.4-7) 4.6.4
> reproduce:
>         # save the attached .config to linux build tree
>         make ARCH=x86_64 
> 
> All warnings (new ones prefixed by >>):
> 
> >> kernel/kexec_file.o: warning: objtool: _kexec_kernel_image_load()+0x31: unsupported stack register modification

I talked to Josh (objtool maintainer) and confirmed this is an issue
of objtool, not a bug in my patch.

-Takahiro AKASHI

> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
