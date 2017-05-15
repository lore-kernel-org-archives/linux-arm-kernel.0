From: robh@kernel.org (Rob Herring)
Date: Mon, 15 May 2017 10:23:51 -0500
Subject: [RFC v1 3/7] iommu/arm-smmu-v3: Replace the device tree binding
 for hisilicon broken prefetch cmd with erratum id
In-Reply-To: <20170513094731.3676-4-shameerali.kolothum.thodi@huawei.com>
References: <20170513094731.3676-1-shameerali.kolothum.thodi@huawei.com>
 <20170513094731.3676-4-shameerali.kolothum.thodi@huawei.com>
Message-ID: <CAL_JsqLH7iT7O2U3g6J26YGBUmt53PDymLJ5VCLByW_97L_M4w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, May 13, 2017 at 4:47 AM, shameer
<shameerali.kolothum.thodi@huawei.com> wrote:
> Signed-off-by: shameer <shameerali.kolothum.thodi@huawei.com>
> ---
>  Documentation/devicetree/bindings/iommu/arm,smmu-v3.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu-v3.txt b/Documentation/devicetree/bindings/iommu/arm,smmu-v3.txt
> index be57550..bf48e92 100644
> --- a/Documentation/devicetree/bindings/iommu/arm,smmu-v3.txt
> +++ b/Documentation/devicetree/bindings/iommu/arm,smmu-v3.txt
> @@ -46,7 +46,7 @@ the PCIe specification.
>                          devicetree/bindings/interrupt-controller/msi.txt
>                        for a description of the msi-parent property.
>
> -- hisilicon,broken-prefetch-cmd
> +- hisilicon,erratum-161010701

Why? Your missing commit msg should answer that. This breaks
compatibility, so you are stuck with the old string.

I'd prefer that you start using the compatible string rather than
every vendor adding a property for every errata.

Rob
