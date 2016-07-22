From: lkp@intel.com (kbuild test robot)
Date: Sat, 23 Jul 2016 05:32:42 +0800
Subject: [PATCH v3 1/7] firmware: rockchip: sip: Add rockchip SIP runtime
 service
In-Reply-To: <1469178440-4668-2-git-send-email-hl@rock-chips.com>
Message-ID: <201607230542.z1P2eELa%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

[auto build test ERROR on next-20160722]
[also build test ERROR on v4.7-rc7]
[cannot apply to rockchip/for-next stable/master linux/master v4.7-rc7 v4.7-rc6 v4.7-rc5]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Lin-Huang/rk3399-support-ddr-frequency-scaling/20160722-173343
config: arm64-allmodconfig (attached as .config)
compiler: aarch64-linux-gnu-gcc (Debian 5.4.0-6) 5.4.0 20160609
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm64 

All errors (new ones prefixed by >>):

   drivers/built-in.o: In function `sip_smc_ddr_init':
>> binder.c:(.text+0x279074): undefined reference to `__invoke_psci_fn_smc'
   drivers/built-in.o: In function `sip_smc_set_ddr_param':
   binder.c:(.text+0x2790ac): undefined reference to `__invoke_psci_fn_smc'
   drivers/built-in.o: In function `sip_smc_set_ddr_rate':
   binder.c:(.text+0x2790ec): undefined reference to `__invoke_psci_fn_smc'
   drivers/built-in.o: In function `sip_smc_get_ddr_rate':
   binder.c:(.text+0x279124): undefined reference to `__invoke_psci_fn_smc'
   drivers/built-in.o: In function `sip_smc_clr_ddr_irq':
   binder.c:(.text+0x279154): undefined reference to `__invoke_psci_fn_smc'
   drivers/built-in.o:binder.c:(.text+0x279184): more undefined references to `__invoke_psci_fn_smc' follow

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 51332 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160723/7c7845a2/attachment-0001.obj>
