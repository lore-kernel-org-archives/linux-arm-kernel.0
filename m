From: lkp@intel.com (kbuild test robot)
Date: Fri, 28 Sep 2018 17:04:09 +0800
Subject: [PATCH v15 06/16] of/fdt: add helper functions for handling
 properties
In-Reply-To: <20180928064841.14117-7-takahiro.akashi@linaro.org>
References: <20180928064841.14117-7-takahiro.akashi@linaro.org>
Message-ID: <201809281734.qf6xwniP%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi AKASHI,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on arm64/for-next/core]
[also build test ERROR on v4.19-rc5 next-20180928]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/AKASHI-Takahiro/arm64-kexec-add-kexec_file_load-support/20180928-151042
base:   https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-next/core
config: i386-randconfig-s0-201838 (attached as .config)
compiler: gcc-6 (Debian 6.4.0-9) 6.4.0 20171026
reproduce:
        # save the attached .config to linux build tree
        make ARCH=i386 

All errors (new ones prefixed by >>):

   drivers/of/fdt.o: In function `fdt_setprop_reg':
>> drivers/of/fdt.c:1358: undefined reference to `fdt_address_cells'
>> drivers/of/fdt.c:1361: undefined reference to `fdt_size_cells'

vim +1358 drivers/of/fdt.c

  1348	
  1349	int fdt_setprop_reg(void *fdt, int nodeoffset, const char *name,
  1350							u64 addr, u64 size)
  1351	{
  1352		int addr_cells, size_cells;
  1353		char buf[sizeof(__be32) * 2 * 2];
  1354			/* assume dt_root_[addr|size]_cells <= 2 */
  1355		void *prop;
  1356		size_t buf_size;
  1357	
> 1358		addr_cells = fdt_address_cells(fdt, 0);
  1359		if (addr_cells < 0)
  1360			return addr_cells;
> 1361		size_cells = fdt_size_cells(fdt, 0);

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 31880 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180928/10804e57/attachment-0001.gz>
