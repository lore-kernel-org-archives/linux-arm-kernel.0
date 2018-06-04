From: lkp@intel.com (kbuild test robot)
Date: Tue, 5 Jun 2018 07:13:23 +0800
Subject: [PATCH 7/7] regulator: core: Enable voltage balancing
In-Reply-To: <1528120764-14316-8-git-send-email-m.purski@samsung.com>
References: <1528120764-14316-8-git-send-email-m.purski@samsung.com>
Message-ID: <201806050737.uIMHUHzq%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Maciej,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on regulator/for-next]
[also build test ERROR on next-20180604]
[cannot apply to v4.17]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Maciej-Purski/regulator-core-Add-debug-messages/20180605-052333
base:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next
config: x86_64-randconfig-x011-201822 (attached as .config)
compiler: gcc-7 (Debian 7.3.0-16) 7.3.0
reproduce:
        # save the attached .config to linux build tree
        make ARCH=x86_64 

All errors (new ones prefixed by >>):

   drivers//regulator/core.c: In function 'regulator_set_voltage_unlocked':
>> drivers//regulator/core.c:3046:1: error: version control conflict marker in file
    <<<<<<< HEAD
    ^~~~~~~
   drivers//regulator/core.c:3048:1: error: version control conflict marker in file
    =======
    ^~~~~~~

vim +3046 drivers//regulator/core.c

  3035	
  3036	static int regulator_set_voltage_unlocked(struct regulator *regulator,
  3037						  int min_uV, int max_uV,
  3038						  suspend_state_t state)
  3039	{
  3040		struct regulator_dev *rdev = regulator->rdev;
  3041		struct regulator_voltage *voltage = &regulator->voltage[state];
  3042		int ret = 0;
  3043		int old_min_uV, old_max_uV;
  3044		int current_uV;
  3045	
> 3046	<<<<<<< HEAD
  3047		pr_err("%s: %d\n", __func__, __LINE__);
  3048	=======
  3049		if (rdev->coupling_desc.n_resolved != rdev->coupling_desc.n_coupled) {
  3050			rdev_err(rdev, "not all coupled regulators registered\n");
  3051			ret = -EPERM;
  3052			goto out;
  3053		}
  3054	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 34005 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180605/c5e61c9a/attachment-0001.gz>
