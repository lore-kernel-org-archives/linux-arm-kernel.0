From: jean-philippe.brucker@arm.com (Jean-Philippe Brucker)
Date: Fri, 1 Jun 2018 11:46:07 +0100
Subject: [PATCH v2 21/40] iommu/arm-smmu-v3: Add support for Substream IDs
In-Reply-To: <BLUPR0201MB1505AA55707BE2E13392FFAFA5630@BLUPR0201MB1505.namprd02.prod.outlook.com>
References: <20180511190641.23008-1-jean-philippe.brucker@arm.com>
 <20180511190641.23008-22-jean-philippe.brucker@arm.com>
 <BLUPR0201MB1505AA55707BE2E13392FFAFA5630@BLUPR0201MB1505.namprd02.prod.outlook.com>
Message-ID: <be58739e-ed03-396f-c7ac-19a3195aef87@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 31/05/18 12:01, Bharat Kumar Gogada wrote:
>>  static void arm_smmu_sync_cd(void *cookie, int ssid, bool leaf)  {
>> +	struct arm_smmu_cmdq_ent cmd = {
>> +		.opcode	= CMDQ_OP_CFGI_CD_ALL,
> 
> Hi Jean, here CMDQ_OP_CFGI_CD opcode 0x5. 

Woops, nice catch!

I pushed fixes for all comments so far to branch sva/current

Thanks,
Jean
