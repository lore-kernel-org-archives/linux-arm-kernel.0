From: swarren@nvidia.com (Stephen Warren)
Date: Wed, 2 Nov 2011 09:34:40 -0700
Subject: [PATCH] arm/tegra: remove unused defines
In-Reply-To: <1320247524-22425-1-git-send-email-pdeschrijver@nvidia.com>
References: <1320247524-22425-1-git-send-email-pdeschrijver@nvidia.com>
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF173F9A46E0@HQMAIL01.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Peter De Schrijver wrote at Wednesday, November 02, 2011 9:25 AM:
> PPI_NR is never used in arch/arm/mach-tegra/irq.c. Remove it.
> 
> Signed-off-by: Peter De Schrijver <pdeschrijver@nvidia.com>

Acked-by: Stephen Warren <swarren@nvidia.com>

For reference, I investigated why the defines aren't used, and found:

Those defines were introduced by:

commit 460907bc26f5565aced3cf35a10e3579c671ef50
[ARM] tegra: add suspend and mirror irqs to legacy controller

3524b70ef3336a4f1351a489e83894b88106ab7c moved those defines
into legacy_irq.c (and appears to have added define NUM_ICTLRS to replace
them) and d1d8c666683cdbef18329ff8f3743ddaca8842ee moved them back.

> -#define INT_SYS_NR	(INT_GPIO_BASE - INT_PRI_BASE)
> -#define INT_SYS_SZ	(INT_SEC_BASE - INT_PRI_BASE)
> -#define PPI_NR		((INT_SYS_NR+INT_SYS_SZ-1)/INT_SYS_SZ)

-- 
nvpublic
