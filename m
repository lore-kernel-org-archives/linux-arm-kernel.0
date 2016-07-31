From: lkp@intel.com (kbuild test robot)
Date: Sun, 31 Jul 2016 09:45:17 +0800
Subject: [PATCH 1/2] Support SD UHS for hikey-mainline-rebase
In-Reply-To: <1468914713-63347-1-git-send-email-kid.jin@hisilicon.com>
Message-ID: <201607310944.V1louHVl%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

[auto build test ERROR on robh/for-next]
[also build test ERROR on v4.7 next-20160729]
[cannot apply to ulf.hansson-mmc/next]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Jin-Guojun/Support-SD-UHS-for-hikey-mainline-rebase/20160725-102555
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
config: i386-allmodconfig (attached as .config)
compiler: gcc-6 (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        # save the attached .config to linux build tree
        make ARCH=i386 

All errors (new ones prefixed by >>):

>> drivers/mmc/host/dw_mmc-k3.c:137:2: error: unknown field 'prepare_command' specified in initializer
     .prepare_command        = dw_mci_hi6220_prepare_command,
     ^
>> drivers/mmc/host/dw_mmc-k3.c:137:28: error: initialization from incompatible pointer type [-Werror=incompatible-pointer-types]
     .prepare_command        = dw_mci_hi6220_prepare_command,
                               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/mmc/host/dw_mmc-k3.c:137:28: note: (near initialization for 'hi6220_data.execute_tuning')
   cc1: some warnings being treated as errors

vim +/prepare_command +137 drivers/mmc/host/dw_mmc-k3.c

   131	}
   132	
   133	static const struct dw_mci_drv_data hi6220_data = {
   134		.switch_voltage		= dw_mci_hi6220_switch_voltage,
   135		.set_ios		= dw_mci_hi6220_set_ios,
   136		.parse_dt		= dw_mci_hi6220_parse_dt,
 > 137		.prepare_command        = dw_mci_hi6220_prepare_command,
   138	};
   139	
   140	static const struct of_device_id dw_mci_k3_match[] = {

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 55034 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160731/60fdfa7a/attachment-0001.obj>
