From: eric.auger@redhat.com (Auger Eric)
Date: Fri, 6 Jan 2017 14:03:26 +0100
Subject: [PATCH v6 08/18] iommu/vt-d: Implement reserved region get/put
 callbacks
In-Reply-To: <20170106124631.GP17255@8bytes.org>
References: <1483643086-2883-1-git-send-email-eric.auger@redhat.com>
 <1483643086-2883-9-git-send-email-eric.auger@redhat.com>
 <20170106110131.GM17255@8bytes.org>
 <36bac0a9-89a6-ff7b-1870-a795a4f57700@redhat.com>
 <20170106124631.GP17255@8bytes.org>
Message-ID: <bbad2117-a4ac-056c-9c3a-a7e11e4b5630@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Joerg,

On 06/01/2017 13:46, Joerg Roedel wrote:
> On Fri, Jan 06, 2017 at 12:45:54PM +0100, Auger Eric wrote:
>> On 06/01/2017 12:01, Joerg Roedel wrote:
>>> On Thu, Jan 05, 2017 at 07:04:36PM +0000, Eric Auger wrote:
> 
>>> That is different from what AMD does, can you also report the RMRR
>>> regions for the device here (as direct-map regions)?
>>
>> if I return RMRR regions as direct mapped regions,
>> iommu_group_create_direct_mappings will perform the 1-1 mapping.
> 
> No, this will not happen until the Intel IOMMU driver returns valid
> IOMMU_DOMAIN_DMA type domains.
Hum OK thanks!

Best Regards

Eric

> 
>> I am not familiar with the intel-iommu code but I guess this job
>> currently is done in the intel driver:
>> iommu_prepare_rmrr_dev -> iommu_prepare_identity_map
>> ->domain_prepare_identity_map -> iommu_domain_identity_map?
> 
> Right, this is done in the Intel driver atm.
> 
> 
> 
> 	Joerg
> 
