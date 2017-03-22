From: gengdongjiu@huawei.com (gengdongjiu)
Date: Wed, 22 Mar 2017 11:20:43 +0800
Subject: [PATCH] kvm: pass the virtual SEI syndrome to guest OS
In-Reply-To: <201703212147.SBN9HPTf%fengguang.wu@intel.com>
References: <201703212147.SBN9HPTf%fengguang.wu@intel.com>
Message-ID: <0ae42f9d-23eb-0cd5-72a4-db0d6fbf3796@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi kbuild test robot,

  Thank you.
  The build error is due to "vsesr_el2" is armv8.2 register, I will change "vsesr_el2" to sysreg usage


On 2017/3/21 21:51, kbuild test robot wrote:
> Hi Dongjiu,
> 
> [auto build test ERROR on arm64/for-next/core]
> [also build test ERROR on v4.11-rc3 next-20170321]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
> 
> url:    https://github.com/0day-ci/linux/commits/Dongjiu-Geng/kvm-pass-the-virtual-SEI-syndrome-to-guest-OS/20170321-152433
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-next/core
> config: arm64-allmodconfig (attached as .config)
> compiler: aarch64-linux-gnu-gcc (Debian 6.1.1-9) 6.1.1 20160705
> reproduce:
>         wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         make.cross ARCH=arm64 
> 
> All errors (new ones prefixed by >>):
> 
>    /tmp/ccWmLqCE.s: Assembler messages:
>>> /tmp/ccWmLqCE.s:677: Error: selected processor does not support system register name 'vsesr_el2'
> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
> 
