From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Tue, 29 Nov 2016 20:17:58 +0800
Subject: [PATCH v9 09/16] drivers: acpi: iort: add support for ARM SMMU
 platform devices creation
In-Reply-To: <20161121100148.24769-10-lorenzo.pieralisi@arm.com>
References: <20161121100148.24769-1-lorenzo.pieralisi@arm.com>
 <20161121100148.24769-10-lorenzo.pieralisi@arm.com>
Message-ID: <11ea77fa-688f-d31d-bd3c-35ca52e0a18b@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2016/11/21 18:01, Lorenzo Pieralisi wrote:
> In ARM ACPI systems, IOMMU components are specified through static
> IORT table entries. In order to create platform devices for the
> corresponding ARM SMMU components, IORT kernel code should be made
> able to parse IORT table entries and create platform devices
> dynamically.
>
> This patch adds the generic IORT infrastructure required to create
> platform devices for ARM SMMUs.
>
> ARM SMMU versions have different resources requirement therefore this
> patch also introduces an IORT specific structure (ie iort_iommu_config)
> that contains hooks (to be defined when the corresponding ARM SMMU
> driver support is added to the kernel) to be used to define the
> platform devices names, init the IOMMUs, count their resources and
> finally initialize them.
>
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Reviewed-by: Tomasz Nowicki <tn@semihalf.com>
> Tested-by: Hanjun Guo <hanjun.guo@linaro.org>
> Tested-by: Tomasz Nowicki <tn@semihalf.com>
> Cc: Hanjun Guo <hanjun.guo@linaro.org>
> Cc: Tomasz Nowicki <tn@semihalf.com>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> ---
>  drivers/acpi/arm64/iort.c | 151 ++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 151 insertions(+)

Acked-by: Hanjun Guo <hanjun.guo@linaro.org>

Thanks
Hanjun
