From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Tue, 29 Nov 2016 20:29:16 +0800
Subject: [PATCH v9 14/16] drivers: acpi: iort: replace rid map type with
 type mask
In-Reply-To: <20161121100148.24769-15-lorenzo.pieralisi@arm.com>
References: <20161121100148.24769-1-lorenzo.pieralisi@arm.com>
 <20161121100148.24769-15-lorenzo.pieralisi@arm.com>
Message-ID: <300db741-2ad9-3a44-13b3-03980ce3713c@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2016/11/21 18:01, Lorenzo Pieralisi wrote:
> IORT tables provide data that allow the kernel to carry out
> device ID mappings between endpoints and system components
> (eg interrupt controllers, IOMMUs). When the mapping for a
> given device ID is carried out, the translation mechanism
> is done on a per-subsystem basis rather than a component
> subtype (ie the IOMMU kernel layer will look for mappings
> from a device to all IORT node types corresponding to IOMMU
> components), therefore the corresponding mapping API should
> work on a range (ie mask) of IORT node types corresponding
> to a common set of components (eg IOMMUs) rather than a
> specific node type.
>
> Upgrade the IORT iort_node_map_rid() API to work with a
> type mask instead of a single node type so that it can
> be used for mappings that span multiple components types
> (ie IOMMUs).
>
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Reviewed-by: Tomasz Nowicki <tn@semihalf.com>
> Tested-by: Hanjun Guo <hanjun.guo@linaro.org>
> Tested-by: Tomasz Nowicki <tn@semihalf.com>
> Cc: Hanjun Guo <hanjun.guo@linaro.org>
> Cc: Tomasz Nowicki <tn@semihalf.com>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> ---
>  drivers/acpi/arm64/iort.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)

Acked-by: Hanjun Guo <hanjun.guo@linaro.org>

Thanks
Hanjun
