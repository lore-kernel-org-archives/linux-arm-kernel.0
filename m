From: sunil.kovvuri@gmail.com (Sunil Kovvuri)
Date: Tue, 7 Mar 2017 18:29:09 +0530
Subject: IOMMU in bypass mode by default on ARM64,
 instead of command line option
In-Reply-To: <CA+sq2CeAKE+fDJhTA_W=bG531b8f7q=NZmgCtEQbXgZsR2RbSA@mail.gmail.com>
References: <CA+sq2CdawVNqEjpuzkdmEDbvW69aXufHJAEoH_g55=sr2d1rOw@mail.gmail.com>
 <07f4a3d7-f41b-2459-65c6-729f3a692e7d@arm.com>
 <20170307113237.GB30058@arm.com>
 <CA+sq2CeAKE+fDJhTA_W=bG531b8f7q=NZmgCtEQbXgZsR2RbSA@mail.gmail.com>
Message-ID: <CA+sq2CcUnfb4UHiQAEF+-A_3z8a5trNsAJUCf_0-VPkm9qgoAQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>> locks which are
>> being used for IOVA maintenance and while updating translation tables inside
>> ARM SMMUv2/v3 drivers.

>Yes, we're well aware that there's a whole load of potential lock
>contention where there doesn't really need to be. The performance
>optimisation effort has mostly been waiting for sufficiently big
>systems/workloads to start appearing in order to measure and justify it.
>Consider yourself the winner :)

>> Intel and AMD IOMMU drivers does make use of per-cpu IOVA caches to
>> reduce the impact of 'iova_rbtree_lock' but ARM is yet to catchup.
>> http://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git/commit/drivers/iommu/iova.c?id=9257b4a206fc0229dd5f84b78e4d1ebf3f91d270
>>
>> And the other lock is 'pgtbl_lock' used in ARM SMMUv2/V3 drivers.

>Do you have any measurements to show how the contention on those two
>locks compares? That would be useful to start with.

Sure, I will capture a fresh and send you the perf data tomorrow.

Thanks,
Sunil.
