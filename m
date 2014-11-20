From: will.deacon@arm.com (Will Deacon)
Date: Thu, 20 Nov 2014 10:08:22 +0000
Subject: 48-bit VA support in the SMMU
In-Reply-To: <decb25f05ca84d439e071f6ad8cf0086@BN3PR0301MB1219.namprd03.prod.outlook.com>
References: <deb48cfb93d94515b6531be02f697e04@CY1PR0301MB0748.namprd03.prod.outlook.com>
 <decb25f05ca84d439e071f6ad8cf0086@BN3PR0301MB1219.namprd03.prod.outlook.com>
Message-ID: <20141120100822.GA19126@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 20, 2014 at 01:25:18AM +0000, Varun Sethi wrote:
> What specific tweaks are required in the arm-smmu driver? I thought that
> the upstream arm-smmu (3.18-rc3) driver does support 48 bit input address
> (depended on the ARM64 kernel 48 bit support). Isn't this dependent on the
> VA_BITS?  

Yeah, but it won't work for stage-2 mappings. I'm currently rewriting the
page table code to allow this (see my iommu/pgtbl branch).

Will
