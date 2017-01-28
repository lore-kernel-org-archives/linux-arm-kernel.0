From: helgaas@kernel.org (Bjorn Helgaas)
Date: Sat, 28 Jan 2017 15:29:12 -0600
Subject: [PATCH v2] PCI: exynos: refactor exynos pcie driver
In-Reply-To: <1483588418-2551-1-git-send-email-pankaj.dubey@samsung.com>
References: <CGME20170105035104epcas1p2de6c52e577dd78a4f3539fb32d1f0dfe@epcas1p2.samsung.com>
 <1483588418-2551-1-git-send-email-pankaj.dubey@samsung.com>
Message-ID: <20170128212912.GK20550@bhelgaas-glaptop.roam.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 05, 2017 at 09:23:38AM +0530, Pankaj Dubey wrote:
> From: Niyas Ahmed S T <niyas.ahmed@samsung.com>
> 
> Currently Exynos PCIe driver is only supported for Exynos5440 SoC.
> This patch does refactoring of Exynos PCIe driver to extend support
> for other Exynos SoC.
> 
> Following are the main changes done via this patch:
> 
> 1) It adds separate structs for memory, clock resources.
> 
> Reason behind this change is, moving ahead various Exynos SoC will
> have different hardware resources such as iomem, clocks, regmap handles
> etc. for PCIe controller, so keeping these resources in separate struct
> will help us in intiailizing them via per SoC ops, and will avoid too
> many of_machine_is_compatible in code, and help us simplifying
> exynos_pcie struct.
> 
> 2) It add exynos_pcie_ops struct which will allow us to support the
> differences in resources in different Exynos SoC.
> 
> No functional change intended.
> 
> Signed-off-by: Niyas Ahmed S T <niyas.ahmed@samsung.com>
> Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
> Acked-by: Krzysztof Kozlowski <krzk@kernel.org>
> Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> ---
> This patch set is prepared on top of Krzysztof's for-next and
> PCIe driver cleanup patch [1] by Jaehoon Chung.
> 
> [1]: https://lkml.org/lkml/2016/12/19/44

Jaehoon has posted an updated version since you posted this patch, so
I assume this will need to be rebased on that.  I'll drop this version and
wait for your rebased version.
