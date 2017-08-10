From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 10 Aug 2017 18:16:31 +0100
Subject: [PATCH] ACPI/IORT: Fix build regression without IOMMU
In-Reply-To: <20170810164522.25555-1-lorenzo.pieralisi@arm.com>
References: <20170810164522.25555-1-lorenzo.pieralisi@arm.com>
Message-ID: <20170810171631.iqj5k674ltjpj5va@armageddon.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 10, 2017 at 05:45:22PM +0100, Lorenzo Pieralisi wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> A recent change reintroduced a bug that had previously been
> fixed by commit d49f2dedf33b ("ACPI/IORT: Fix CONFIG_IOMMU_API
> dependency"):
> 
> drivers/acpi/arm64/iort.c: In function 'iort_iommu_configure':
> drivers/acpi/arm64/iort.c:829:26: error: 'struct iommu_fwspec' has no member named 'ops'
> 
> Replace a direct reference to iommu_fwspec->ops with a helper function
> call to fix the issue.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Robin Murphy <robin.murphy@arm.com>
> ---
> Catalin, Will,
> 
> unfortunately it slipped our kconfig checks (and the kbuild bot) but
> not Arnd's.
> 
> It applies to arm64 for-next/core on top of v4.14 queue. Please apply.

Applied. Thanks.

-- 
Catalin
