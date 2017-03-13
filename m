From: robin.murphy@arm.com (Robin Murphy)
Date: Mon, 13 Mar 2017 12:15:36 +0000
Subject: [PATCH] iommu/arm-smmu: Print message when Cavium erratum 27704
 was detected
In-Reply-To: <20170313103902.17423-1-rrichter@cavium.com>
References: <20170313103902.17423-1-rrichter@cavium.com>
Message-ID: <0522dbbc-99e6-6cc5-788f-c498f7244ca1@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13/03/17 10:39, Robert Richter wrote:
> Firmware is responsible for properly enabling smmu workarounds. Print
> a message for better diagnostics when Cavium erratum 27704 was
> detected.

The wording there could possibly be misinterpreted as the firmware
actively having to do something to the hardware prior to handing it off
to Linux, as opposed to merely supplying a correct FDT or IORT table,
but I'm not sure it matters all that much, and the patch itself is fine:

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

Thanks,
Robin.

> Signed-off-by: Robert Richter <rrichter@cavium.com>
> ---
>  drivers/iommu/arm-smmu.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> index abf6496843a6..c88bf8deb958 100644
> --- a/drivers/iommu/arm-smmu.c
> +++ b/drivers/iommu/arm-smmu.c
> @@ -1887,6 +1887,7 @@ static int arm_smmu_device_cfg_probe(struct arm_smmu_device *smmu)
>  			atomic_add_return(smmu->num_context_banks,
>  					  &cavium_smmu_context_count);
>  		smmu->cavium_id_base -= smmu->num_context_banks;
> +		dev_notice(smmu->dev, "\tenabling workaround for Cavium erratum 27704\n");
>  	}
>  
>  	/* ID2 */
> 
