From: tn@semihalf.com (Tomasz Nowicki)
Date: Wed, 25 Jan 2017 18:28:18 +0100
Subject: [PATCH V7 10/11] iommu/arm-smmu: Clean up early-probing
 workarounds
In-Reply-To: <1485188293-20263-11-git-send-email-sricharan@codeaurora.org>
References: <1485188293-20263-1-git-send-email-sricharan@codeaurora.org>
 <1485188293-20263-11-git-send-email-sricharan@codeaurora.org>
Message-ID: <eb2ceedf-b061-f9ea-eb2a-529bda56298c@semihalf.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 23.01.2017 17:18, Sricharan R wrote:
> From: Robin Murphy <robin.murphy@arm.com>
>
> Now that the appropriate ordering is enforced via profe-deferral of
> masters in core code, rip it all out and bask in the simplicity.
>
> Acked-by: Will Deacon <will.deacon@arm.com>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> [Sricharan: Rebased on top of ACPI IORT SMMU series]
> Signed-off-by: Sricharan R <sricharan@codeaurora.org>

[...]

> -
> -#ifdef CONFIG_ACPI
> -static int __init acpi_smmu_v3_init(struct acpi_table_header *table)
> -{
> -	if (iort_node_match(ACPI_IORT_NODE_SMMU_V3))
> -		return arm_smmu_init();

Since we clean the code we can remove iort_node_match() from iort.c. 
There is no user for it any more. Unless Lorenzo has some plans for it.

Thanks,
Tomasz
