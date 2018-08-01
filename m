From: pn@denx.de (Parthiban Nallathambi)
Date: Wed, 1 Aug 2018 10:39:58 +0200
Subject: [PATCH v4 5/5] arm64: dts: actions: Add pinctrl node for Actions
 Semi S700
In-Reply-To: <201808010805.DWcXxX04%fengguang.wu@intel.com>
References: <20180731194743.13678-6-sravanhome@gmail.com>
 <201808010805.DWcXxX04%fengguang.wu@intel.com>
Message-ID: <2e0c0f5b-40a0-4f62-756f-1377f587d9a0@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi All,

On 08/01/2018 02:45 AM, kbuild test robot wrote:
> Hi Saravanan,
> 
> Thank you for the patch! Yet something to improve:
> 
> [auto build test ERROR on pinctrl/devel]
> [also build test ERROR on next-20180731]
> [cannot apply to v4.18-rc7]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
> 
> url:    https://github.com/0day-ci/linux/commits/Saravanan-Sekar/pinctrl-actions-define-constructor-generic-to-Actions-Semi-SoC-s/20180801-042834
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git devel
> config: arm64-defconfig (attached as .config)
> compiler: aarch64-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
> reproduce:
>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>          chmod +x ~/bin/make.cross
>          # save the attached .config to linux build tree
>          GCC_VERSION=7.2.0 make.cross ARCH=arm64
> 
> All errors (new ones prefixed by >>):
> 
>>> Error: arch/arm64/boot/dts/actions/s700.dtsi:172.19-20 syntax error
>>> FATAL ERROR: Unable to parse input tree

Device tree entry in this patch depends on actions clock patch [1],
and it is not yet merged. The above build error is because of the
dependency.

[1] https://patchwork.kernel.org/patch/10533959/

> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
> 

-- 
Thanks,
Parthiban Nallathambi

DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd at denx.de
