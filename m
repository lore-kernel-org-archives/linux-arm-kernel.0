From: will.deacon@arm.com (Will Deacon)
Date: Mon, 12 Aug 2013 12:45:20 +0100
Subject: [PATCH 0/4] iommu: arm smmu: driver updates for 3.12
In-Reply-To: <1375294888-10826-1-git-send-email-will.deacon@arm.com>
References: <1375294888-10826-1-git-send-email-will.deacon@arm.com>
Message-ID: <20130812114520.GB25995@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Joerg,

On Wed, Jul 31, 2013 at 07:21:24PM +0100, Will Deacon wrote:
> Here's a set of small drivers updates to the ARM SMMU driver that went
> in during the merge window. The main changes are:
> 
>  - Removal of a broken big-endian special case when setting the pgd
>  - Better error reporting when running with a single, combined IRQ line
>  - Removing the dynamic use of VMIDs for stage-1 mappings. This is basically
>    to make life easier for hypervisors, who apparently have a hard life
>    if guest OSs allocate their own VMIDs
>  - Simplification of the VMID/ASID allocation scheme based on the fact
>    that we're just trying to assign one ID per context-bank.
> 
> I've tested these patches with an AArch32 MMU-500 model and not seen any
> problems running stage-1 DMA transactions through the SMMU.

Could you queue these for 3.12 please?

Thanks,

Will
