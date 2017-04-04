From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 4 Apr 2017 18:04:18 +0100
Subject: [GIT PULL] ACPI IORT changes for v4.12
In-Reply-To: <20170331100226.GA30762@red-moon>
References: <20170331100226.GA30762@red-moon>
Message-ID: <20170404170418.GF19969@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 31, 2017 at 11:02:26AM +0100, Lorenzo Pieralisi wrote:
> ----------------------------------------------------------------
> ACPI ARM64 specific changes for v4.12.
> 
> Patches contain:
> 
> - IORT kernel interface misc clean-ups
> - IORT id mapping interface refactoring in preparation for platform
>   MSI (IORT named components -> GIC ITS mappings) devid mapping code
> - IORT id mapping implementation for named components nodes to ITS nodes,
>   in order to provide the kernel with a firmware interface to map
>   platform devices devids to GIC ITS components
> 
> ----------------------------------------------------------------
> Hanjun Guo (7):
>       ACPI/IORT: Fix the indentation in iort_scan_node()
>       ACPI/IORT: Add missing comment for iort_dev_find_its_id()
>       ACPI/IORT: Rework iort_match_node_callback() return value handling
>       ACPI/IORT: Rename iort_node_map_rid() to make it generic
>       ACPI/IORT: Introduce iort_node_map_platform_id() to retrieve dev id
>       ACPI: platform-msi: retrieve devid from IORT
>       ACPI: platform: setup MSI domain for ACPI based platform device
> 
>  drivers/acpi/arm64/iort.c | 158 +++++++++++++++++++++++++++++++++++++---------
>  drivers/acpi/glue.c       |   6 ++
>  include/linux/acpi_iort.h |   3 +
>  3 files changed, 136 insertions(+), 31 deletions(-)

Pulled for 4.12. Thanks.

-- 
Catalin
