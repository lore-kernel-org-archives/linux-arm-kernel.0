From: robin.murphy@arm.com (Robin Murphy)
Date: Tue, 24 Jan 2017 17:02:38 +0000
Subject: Need information for iommu grouping support
In-Reply-To: <E6F4274F7BEC774AAA4E7A98618BCFAE144292@XAP-PVEXMBX01.xlnx.xilinx.com>
References: <E6F4274F7BEC774AAA4E7A98618BCFAE144292@XAP-PVEXMBX01.xlnx.xilinx.com>
Message-ID: <95445387-1fa4-7836-2f54-4be5d8f871e7@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 24/01/17 12:09, Bhargav Shah wrote:
> Hi,
> From the following link I see that some work is in progress regarding to iommu grouping.
> http://iommu.linux-foundation.narkive.com/RqAfNRwi/question-about-arm-smmu
> 
> Are there any code check-ins for this implementation ?

Yes, since 4.9, devices sharing the same Stream ID will automatically be
grouped together and work correctly. If you have devices with multiple
Stream IDs that can be matched unambiguously in a single SMR by masking,
you can now use that too.

Robin.

> 
> Thank you,
> Bhargav Shah 
> 
