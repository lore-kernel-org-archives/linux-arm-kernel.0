From: will.deacon@arm.com (Will Deacon)
Date: Fri, 18 Nov 2016 16:00:06 +0000
Subject: [PATCH v8 12/16] drivers: iommu: arm-smmu: split probe functions
 into DT/generic portions
In-Reply-To: <20161116152936.22955-13-lorenzo.pieralisi@arm.com>
References: <20161116152936.22955-1-lorenzo.pieralisi@arm.com>
 <20161116152936.22955-13-lorenzo.pieralisi@arm.com>
Message-ID: <20161118160006.GW13470@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 16, 2016 at 03:29:32PM +0000, Lorenzo Pieralisi wrote:
> Current ARM SMMU probe functions intermingle HW and DT probing
> in the initialization functions to detect and programme the ARM SMMU
> driver features. In order to allow probing the ARM SMMU with other
> firmwares than DT, this patch splits the ARM SMMU init functions into
> DT and HW specific portions so that other FW interfaces (ie ACPI) can
> reuse the HW probing functions and skip the DT portion accordingly.
> 
> This patch implements no functional change, only code reshuffling.
> 
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Reviewed-by: Tomasz Nowicki <tn@semihalf.com>
> Tested-by: Hanjun Guo <hanjun.guo@linaro.org>
> Tested-by: Tomasz Nowicki <tn@semihalf.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Hanjun Guo <hanjun.guo@linaro.org>
> Cc: Robin Murphy <robin.murphy@arm.com>
> ---
>  drivers/iommu/arm-smmu.c | 62 +++++++++++++++++++++++++++++-------------------
>  1 file changed, 37 insertions(+), 25 deletions(-)

Reviewed-by: Will Deacon <will.deacon@arm.com>

Although I'd also like Robin to have a look at this.

Will
