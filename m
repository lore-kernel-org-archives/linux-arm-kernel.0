From: sudeep.holla@arm.com (Sudeep Holla)
Date: Fri, 19 May 2017 18:42:56 +0100
Subject: [PATCH] arm64: dts: juno: Enable some SMMUs
In-Reply-To: <eeb81dbbd7ddfbbccb961c0f20c5cb90f120e89f.1495110010.git.robin.murphy@arm.com>
References: <eeb81dbbd7ddfbbccb961c0f20c5cb90f120e89f.1495110010.git.robin.murphy@arm.com>
Message-ID: <ef0cc8cd-9ddb-6e5d-0ca0-57e54c94b2c1@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 18/05/17 13:23, Robin Murphy wrote:
> The IOMMU-backed DMA API support has now been in place for a while and
> proven stable, so there's no real need to keep most of Juno's SMMUs
> disabled. The USB, HDLCDs, and CoreSight ETR all just need to map RAM
> buffers for DMA - enabling their SMMUs obviates CPU bounce buffering for
> USB's streaming DMA to the upper memory bank, and lets the other two
> allocate their relatively large coherent buffers without pressuring CMA.
> 
> Some more software work is still needed for the DMA-330 and PCIe before
> those can accommodate SMMU translation correctly in all cases, so we
> leave those alone for now.
> 

Queued for v4.13 [1]

IIUC, it's not a fix and can wait for v4.13. Let me know if that's not
the case.

-- 
Regards,
Sudeep

[1] https://git.kernel.org/sudeep.holla/linux/h/for-next/juno-updates
