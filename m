From: valmikibow@gmail.com (valmiki)
Date: Sat, 25 Mar 2017 10:46:34 +0530
Subject: [RFC PATCH 21/30] iommu/arm-smmu-v3: Handle device faults from PRI
In-Reply-To: <8520D5D51A55D047800579B0941471982640F43C@XAP-PVEXMBX02.xlnx.xilinx.com>
References: <20170227195441.5170-1-jean-philippe.brucker@arm.com>
 <20170227195441.5170-22-jean-philippe.brucker@arm.com>
 <8520D5D51A55D047800579B0941471982640F43C@XAP-PVEXMBX02.xlnx.xilinx.com>
Message-ID: <0b3e3ddd-acc3-5ba7-639f-5c9192da57c3@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> When we receive a PRI Page Request (PPR) from the SMMU, it contains a context identifier SID:SSID, an IOVA and the requested access flags.
>
> Search the domain corresponding to SID:SSID, and call handle_mm_fault on its mm. If memory management is able to fix the fault, we ask the device to retry the access with a PRI_SUCCESS message. Otherwise send PRI_FAIL.
>
Hi Jean,

I need some clarification. Page fault handling is already part of MMU. 
When PRI requested page results in page fault, smmu is going to invoke 
handle_mm_fault which is part of memory management unit ?

If so this functionality is yet to be added in SMMU driver ?

Because i haven't seen this API being called in your patches.

Regards,
Valmiki
