From: jean-philippe.brucker@arm.com (Jean-Philippe Brucker)
Date: Mon, 21 May 2018 15:49:51 +0100
Subject: [PATCH v2 17/40] iommu/arm-smmu-v3: Link domains and devices
In-Reply-To: <20180517170748.00004927@huawei.com>
References: <20180511190641.23008-1-jean-philippe.brucker@arm.com>
 <20180511190641.23008-18-jean-philippe.brucker@arm.com>
 <20180517170748.00004927@huawei.com>
Message-ID: <652e5b8c-fa51-0fec-01fe-0fccc999ecf6@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17/05/18 17:07, Jonathan Cameron wrote:
>> +++ b/drivers/iommu/arm-smmu-v3.c
>> @@ -595,6 +595,11 @@ struct arm_smmu_device {
>>  struct arm_smmu_master_data {
>>  	struct arm_smmu_device		*smmu;
>>  	struct arm_smmu_strtab_ent	ste;
>> +
>> +	struct arm_smmu_domain		*domain;
>> +	struct list_head		list; /* domain->devices */
> 
> More meaningful name perhaps to avoid the need for the comment?

Sure

Thanks,
Jean
