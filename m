From: lkp@intel.com (kbuild test robot)
Date: Wed, 16 May 2018 12:13:37 +0800
Subject: [PATCH v7 12/14] cpufreq: Add Kryo CPU scaling driver
In-Reply-To: <1526375616-16904-13-git-send-email-ilialin@codeaurora.org>
References: <1526375616-16904-13-git-send-email-ilialin@codeaurora.org>
Message-ID: <201805161233.KgANSDKh%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ilia,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on robh/for-next]
[also build test ERROR on v4.17-rc5]
[cannot apply to clk/clk-next next-20180515]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Ilia-Lin/CPU-scaling-support-for-msm8996/20180516-064721
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
config: arm64-allmodconfig (attached as .config)
compiler: aarch64-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm64 

All errors (new ones prefixed by >>):

   aarch64-linux-gnu-ld: arch/arm64/kernel/head.o: relocation R_AARCH64_ABS32 against `_kernel_offset_le_lo32' can not be used when making a shared object
   arch/arm64/kernel/head.o: In function `kimage_vaddr':
   (.idmap.text+0x0): dangerous relocation: unsupported relocation
   arch/arm64/kernel/head.o: In function `__primary_switch':
   (.idmap.text+0x350): dangerous relocation: unsupported relocation
   (.idmap.text+0x358): dangerous relocation: unsupported relocation
   drivers/cpufreq/qcom-cpufreq-kryo.o: In function `qcom_cpufreq_kryo_driver_init':
>> qcom-cpufreq-kryo.c:(.init.text+0xd8): undefined reference to `qcom_smem_get'

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 59061 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180516/2b801114/attachment-0001.gz>
