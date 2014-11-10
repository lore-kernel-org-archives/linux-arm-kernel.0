From: acourbot@nvidia.com (Alexandre Courbot)
Date: Mon, 10 Nov 2014 18:53:30 +0900
Subject: [PATCH v6 00/12] NVIDIA Tegra memory controller and IOMMU support
In-Reply-To: <1415376063-17205-1-git-send-email-thierry.reding@gmail.com>
References: <1415376063-17205-1-git-send-email-thierry.reding@gmail.com>
Message-ID: <54608B1A.3010001@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/08/2014 01:00 AM, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
>
> This is the sixth installment in the Tegra IOMMU and memory controller
> support series. This version addresses the final outstanding comments from
> Olof about using proper Kconfig symbols to track the dependencies. It also
> splits up the driver into one part that implements the memory controller
> only and a second part that implements the SMMU. This plays nicely with
> the new Kconfig options introduced.
>
> Patch 1 is a preparatory patch that exposes the memory controller clock.
>
> Patches 2 and 3 is a pair of precursory patches needed to make this all
> work on 64-bit ARM in the future.
>
> The device tree binding for the Tegra memory controller is added in patch
> 4 and patch 5 is the bulk of the series that move the existing memory
> controller and IOMMU drivers into the new unified driver that supports
> Tegra30, Tegra114 and Tegra124.
>
> Patches 6, 7 and 8 add the DT nodes for the memory controller/IOMMU on
> Tegra30, Tegra114 and Tegra124.
>
> IOMMU support is enabled for the display controllers in patches 9, 10 and
> 11. This will allow the display controllers to have their memory accesses
> translated by the SMMU, which will enable non-contiguous buffers to be
> used for scan-out.
>
> Finally patch 12 also adds support for Tegra132. It is kept separate because
> none of the other Tegra132 patches have been merged yet, but I've included
> it here for completeness.
>
> Because the patches are rather intertwined, I'd like to merge them all via
> the Tegra tree. For that I'll need Acked-bys from Mike, Russell and Joerg
> on patches 1, 2 and 3, and 5, respectively.

FWIW,

Tested-by: Alexandre Courbot <acourbot@nvidia.com>

Works nicely with both the display and GPU clients, which allows us to 
remove the need for CMA on Tegra.

Thanks,
Alex.
