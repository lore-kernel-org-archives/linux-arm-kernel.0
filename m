From: okaya@codeaurora.org (Sinan Kaya)
Date: Tue, 10 Apr 2018 14:53:47 -0400
Subject: [PATCH 03/37] iommu/sva: Manage process address spaces
In-Reply-To: <20180212183352.22730-4-jean-philippe.brucker@arm.com>
References: <20180212183352.22730-1-jean-philippe.brucker@arm.com>
 <20180212183352.22730-4-jean-philippe.brucker@arm.com>
Message-ID: <04d4d161-ed72-f6b6-9b94-1d60bd79ef94@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2/12/2018 1:33 PM, Jean-Philippe Brucker wrote:
> +static void io_mm_detach_all_locked(struct iommu_bond *bond)
> +{
> +	while (!io_mm_detach_locked(bond));
> +}
> +

I don't remember if I mentioned this before or not but I think this loop
needs a little bit relaxation with yield and maybe an informational message
with might help if wait exceeds some time.

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
