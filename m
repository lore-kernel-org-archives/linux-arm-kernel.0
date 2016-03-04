From: will.deacon@arm.com (Will Deacon)
Date: Fri, 4 Mar 2016 20:59:46 +0000
Subject: [PATCH V4] iommu/arm-smmu-v2: Workaround for ThunderX errata#27704
In-Reply-To: <1457116784-13287-1-git-send-email-tchalamarla@caviumnetworks.com>
References: <1457116784-13287-1-git-send-email-tchalamarla@caviumnetworks.com>
Message-ID: <20160304205945.GG7886@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 04, 2016 at 10:39:44AM -0800, Tirumalesh Chalamarla wrote:
> Due to Errata#27704 CN88xx SMMUv2,supports  only shared ASID and VMID
> namespaces; specifically within a given node SMMU0 and SMMU1 share,
> as does SMMU2 and SMMU3.
> 
> This patch make sure ASID and VMID space is unique across cavium SMMUv2.
> 
> changes from V3:
> 	- Removed redundent variable.
> 	- Used atomic_t for maintaining running total
> 
> changes from V2:
> 	- removed *_base from DT, and replaced with compatible string
> 
> changes from V1:
> 	- rebased on top of 16 bit VMID patch
> 	- removed redundent options from DT
> 	- insted of transform, DT now supplies starting ASID/VMID
> 
> Signed-off-by: Tirumalesh Chalamarla <tchalamarla@caviumnetworks.com>
> Signed-off-by: Akula Geethasowjanya <Geethasowjanya.Akula@caviumnetworks.com>
> ---
>  Documentation/arm64/silicon-errata.txt             |  1 +
>  .../devicetree/bindings/iommu/arm,smmu.txt         |  1 +
>  drivers/iommu/arm-smmu.c                           | 42 ++++++++++++++++------
>  3 files changed, 33 insertions(+), 11 deletions(-)

Hmm, this doesn't seem to apply to my iommu/devel branch. Am I missing
some dependency?

Will
