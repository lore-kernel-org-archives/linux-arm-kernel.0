From: Varun.Sethi@freescale.com (Varun Sethi)
Date: Thu, 20 Nov 2014 13:05:51 +0000
Subject: 48-bit VA support in the SMMU
In-Reply-To: <20141120100822.GA19126@arm.com>
References: <deb48cfb93d94515b6531be02f697e04@CY1PR0301MB0748.namprd03.prod.outlook.com>
 <decb25f05ca84d439e071f6ad8cf0086@BN3PR0301MB1219.namprd03.prod.outlook.com>
 <20141120100822.GA19126@arm.com>
Message-ID: <7a9f17b997db458b9f15893837df04eb@BN3PR0301MB1219.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thanks Will. But still, if things work for the stage 1 case why disable 48 bit support for the SMMU driver. Wouldn't stage-2 be relevant in case of virtual SMMU?

Regards
Varun

-----Original Message-----
From: Will Deacon [mailto:will.deacon at arm.com] 
Sent: Thursday, November 20, 2014 3:38 PM
To: Sethi Varun-B16395
Cc: Yoder Stuart-B08248; linux-arm-kernel at lists.infradead.org; Christoffer Dall
Subject: Re: 48-bit VA support in the SMMU

On Thu, Nov 20, 2014 at 01:25:18AM +0000, Varun Sethi wrote:
> What specific tweaks are required in the arm-smmu driver? I thought 
> that the upstream arm-smmu (3.18-rc3) driver does support 48 bit input 
> address (depended on the ARM64 kernel 48 bit support). Isn't this 
> dependent on the VA_BITS?

Yeah, but it won't work for stage-2 mappings. I'm currently rewriting the page table code to allow this (see my iommu/pgtbl branch).

Will
