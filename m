From: okaya@codeaurora.org (Sinan Kaya)
Date: Tue, 24 Apr 2018 13:17:02 -0400
Subject: [PATCH 03/37] iommu/sva: Manage process address spaces
In-Reply-To: <66ec18ca-ea4e-d224-c9c5-8dbee5da8a72@arm.com>
References: <20180212183352.22730-1-jean-philippe.brucker@arm.com>
 <20180212183352.22730-4-jean-philippe.brucker@arm.com>
 <57d77955-caa7-ddac-df7d-7eef1f05dbb2@codeaurora.org>
 <66ec18ca-ea4e-d224-c9c5-8dbee5da8a72@arm.com>
Message-ID: <e7c4053a-20cc-d2db-16da-100b1157eca4@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4/24/2018 5:33 AM, Jean-Philippe Brucker wrote:
>> Please return pasid when you find an io_mm that is already bound. Something like
>> *pasid = io_mm->pasid should do the work here when bond is true.
> Right. I think we should also keep returning 0, not switch to -EEXIST or
> similar. So in next version a driver can call bind(devX, mmY) multiple
> times, but the first unbind() removes the bond.

If we are going to allow multiple binds, then the last unbind should
remove the bond rather than the first one via reference counting.

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
