From: lkp@intel.com (kbuild test robot)
Date: Wed, 24 Oct 2018 15:22:27 +0800
Subject: [PATCH 3/3] iommu/tegra194_smmu: Add Tegra194 SMMU driver
In-Reply-To: <1540334347-7178-4-git-send-email-vdumpa@nvidia.com>
References: <1540334347-7178-4-git-send-email-vdumpa@nvidia.com>
Message-ID: <201810241524.jCAbYVLi%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Krishna,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on iommu/next]
[also build test ERROR on next-20181019]
[cannot apply to v4.19]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Krishna-Reddy/Add-Tegra194-Dual-ARM-SMMU-driver/20181024-123501
base:   https://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git next
config: arm-multi_v7_defconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        GCC_VERSION=7.2.0 make.cross ARCH=arm 

All errors (new ones prefixed by >>):

   drivers/iommu/tegra194-smmu.o: In function `arm_smmu_attach_dev':
>> tegra194-smmu.c:(.text+0x1800): undefined reference to `alloc_io_pgtable_ops'
   drivers/iommu/tegra194-smmu.o: In function `arm_smmu_domain_free':
>> tegra194-smmu.c:(.text+0x1af8): undefined reference to `free_io_pgtable_ops'

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 44388 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181024/bbe4332a/attachment-0001.gz>
