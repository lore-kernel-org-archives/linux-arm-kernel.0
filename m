From: puck.chen@hisilicon.com (chenfeng)
Date: Fri, 23 Oct 2015 17:10:31 +0800
Subject: [PATCH V2 2/3] Add iommu driver for hi6220 SoC platform
In-Reply-To: <56265783.5040406@arm.com>
References: <1445330724-129401-1-git-send-email-puck.chen@hisilicon.com>
 <1445330724-129401-2-git-send-email-puck.chen@hisilicon.com>
 <56265783.5040406@arm.com>
Message-ID: <5629F987.3060701@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Robin,

On 2015/10/20 23:02, Robin Murphy wrote:
> On 20/10/15 09:45, Chen Feng wrote:
>> iommu/hisilicon: Add hi6220-SoC smmu driver
> 

>> +
>> +static int hi6220_smmu_attach_dev(struct iommu_domain *domain,
>> +                  struct device *dev)
>> +{
>> +    dev->archdata.iommu = &iova_allocator;
> 
> If the hardware doesn't offer any kind of device isolation (i.e. multiple translation contexts), then you should probably have more logic here to ensure only a single domain can ever be active at once.
> 
>> +    return 0;
>> +}
>> +
I feel confused about your above comments. Could you help explain "ensure only a single domain can ever be active at once"?


> Robin.
> 
> 
> .
> 
