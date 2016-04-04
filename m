From: jroedel@suse.de (Joerg Roedel)
Date: Mon, 4 Apr 2016 16:25:14 +0200
Subject: [PATCH v2] iommu/arm-smmu: Make use of phandle iterators in
 device-tree device-tree parsing
In-Reply-To: <201603232325.ah8fLwoH%fengguang.wu@intel.com>
References: <20160323114707.GA17838@8bytes.org>
 <201603232325.ah8fLwoH%fengguang.wu@intel.com>
Message-ID: <20160404142514.GH24141@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 23, 2016 at 11:18:25PM +0800, kbuild test robot wrote:
>    drivers/iommu/arm-smmu.c: In function 'arm_smmu_device_dt_probe':
>    drivers/iommu/arm-smmu.c:1746:29: error: storage size of 'it' isn't known
>      struct of_phandle_iterator it;
>                                 ^
> >> drivers/iommu/arm-smmu.c:1815:2: error: implicit declaration of function 'of_for_each_phandle' [-Werror=implicit-function-declaration]
>      of_for_each_phandle(&it, err, dev->of_node,
>      ^
> >> drivers/iommu/arm-smmu.c:1816:46: error: expected ';' before '{' token
>            "mmu-masters", "#stream-id-cells", 0) {
>                                                  ^
>    drivers/iommu/arm-smmu.c:1746:29: warning: unused variable 'it' [-Wunused-variable]
>      struct of_phandle_iterator it;
>                                 ^
>    drivers/iommu/arm-smmu.c: At top level:
>    drivers/iommu/arm-smmu.c:473:12: warning: 'register_smmu_master' defined but not used [-Wunused-function]
>     static int register_smmu_master(struct arm_smmu_device *smmu,
>                ^
>    cc1: some warnings being treated as errors

Looks like this patch got compiled without the other patch in this set,
right? Because the config builds perfectly fine here for me.


	Joerg
