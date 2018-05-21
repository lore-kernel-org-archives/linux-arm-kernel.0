From: jean-philippe.brucker@arm.com (Jean-Philippe Brucker)
Date: Mon, 21 May 2018 15:52:39 +0100
Subject: [PATCH v2 35/40] iommu/arm-smmu-v3: Add support for PCI ATS
In-Reply-To: <922474e8-0aa5-e022-0502-f1e51b0d4859@codeaurora.org>
References: <20180511190641.23008-1-jean-philippe.brucker@arm.com>
 <20180511190641.23008-36-jean-philippe.brucker@arm.com>
 <922474e8-0aa5-e022-0502-f1e51b0d4859@codeaurora.org>
Message-ID: <08f53ea4-bd39-a567-9c79-f4381e5fb461@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sinan,

On 19/05/18 18:25, Sinan Kaya wrote:
> Nothing specific about this patch but just a general observation. Last time I
> looked at the code, it seemed to require both ATS and PRI support from a given
> hardware.
> 
> I think you can assume that for ATS 1.1 specification but ATS 1.0 specification
> allows a system to have ATS+PASID without PRI. 

As far as I know, the latest ATS spec also states that "device that
supports ATS need not support PRI". I'm referring to the version
integrated into PCIe v4.0r1.0, which I think corresponds to ATS 1.1.

> QDF2400 is ATS 1.0 compatible as an example. 
> 
> Is this an assumption / my misinterpretation?

In this series you can enable ATS and PASID without PRI. The SMMU
enables ATS and PASID in add_device() if supported. Then PRI is only
enabled if users request IOMMU_SVA_FEAT_IOPF in sva_init_device(). If
the device driver pins all DMA memory, it can use PASID without PRI.

Thanks,
Jean
