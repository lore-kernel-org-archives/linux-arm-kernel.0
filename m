From: thunder.leizhen@huawei.com (leizhen)
Date: Fri, 6 Jun 2014 08:21:05 +0800
Subject: [PATCH RFC v1 0/2] Add support for Hisilicon SMMU architecture
In-Reply-To: <20140605152140.GA31564@leverpostej>
References: <1401975430-2648-1-git-send-email-thunder.leizhen@huawei.com>
 <20140605152140.GA31564@leverpostej>
Message-ID: <53910971.2010908@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

OK, thanks for your suggestion, I will adjust my code as soon as possible.


On 2014/6/5 23:21, Mark Rutland wrote:
> On Thu, Jun 05, 2014 at 02:37:08PM +0100, Zhen Lei wrote:
>> This driver is base on arm_smmu.c, beause of hisilicon smmu-v1 is similar to
>> arm-smmu, some code can be direct reused. for example: map and unmap, device
>> tree configuration, and the software framework. Somebody may doubted: why not
>> strip the share code in one file, and put hardware-dependent part into other
>> files? Yeah, it's right. But now, in order to make the code flow clearly, just
>> put all hisilicon smmu driver code in hisi_smmu.c.If this driver is acceptable,
>> I will update and submit a revised verion.
> 
> This does not make the code flow clearer. If anything this makes it
> harder to review the series, because it's not clear what the delta from
> the existing ARM SMMU driver is.
> 
> No-one is going to be happy merging a redundant copy of (portions of)
> the existing ARM SMMU driver. Whatever gets merged will look very
> different due to the refactoring required to remedy that, so there's
> almost no point reviewing this in any depth until that's sorted out.
> 
> Mark.
> 
>>
>> Zhen Lei (2):
>>   documentation/iommu: Add description of Hisilicon System MMU binding
>>   iommu/hisilicon: Add support for Hisilicon Ltd. System MMU
>>     architecture
>>
>>  .../devicetree/bindings/iommu/hisilicon,smmu.txt   |   70 +
>>  drivers/iommu/Kconfig                              |   11 +
>>  drivers/iommu/Makefile                             |    1 +
>>  drivers/iommu/hisi-smmu.c                          | 1686 ++++++++++++++++++++
>>  4 files changed, 1768 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/iommu/hisilicon,smmu.txt
>>  create mode 100644 drivers/iommu/hisi-smmu.c
>>
>> --
>> 1.8.0
>>
>>
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel at lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>>
> 
> .
> 
