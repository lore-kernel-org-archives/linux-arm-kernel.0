From: robh+dt@kernel.org (Rob Herring)
Date: Wed, 7 Mar 2018 10:30:09 -0600
Subject: [PATCH 1/1] iommu/arm-smmu: Add support for qcom, smmu-500 variant
In-Reply-To: <20180307063219.14409-1-vivek.gautam@codeaurora.org>
References: <20180307063219.14409-1-vivek.gautam@codeaurora.org>
Message-ID: <CAL_Jsq+WWR5r-RcuE2KGpswdRgwzOV_BZjEOzHj5bAULFD6_Xg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 7, 2018 at 12:32 AM, Vivek Gautam
<vivek.gautam@codeaurora.org> wrote:
> Qualcomm's arm-smmu 500 implementation supports runtime pm
> so enable the same.

That's a driver detail unrelated to the binding.

>
> Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
> ---
>
>  Based on iommu/arm-smmu pm runtime support series [1]:
>  [PATCH v8 0/5] iommu/arm-smmu: Add runtime pm/sleep support
>
>  Tested on sdm845 with necessary support to enable the smmu
>  and with necessary user.
>
>  [1] https://lkml.org/lkml/2018/3/2/325
>
>  Documentation/devicetree/bindings/iommu/arm,smmu.txt | 14 ++++++++++++++

Please split bindings to separate patches.

>  drivers/iommu/arm-smmu.c                             |  8 ++++++++
>  2 files changed, 22 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.txt b/Documentation/devicetree/bindings/iommu/arm,smmu.txt
> index 6ea27bd4f785..0b5c6d2a9865 100644
> --- a/Documentation/devicetree/bindings/iommu/arm,smmu.txt
> +++ b/Documentation/devicetree/bindings/iommu/arm,smmu.txt
> @@ -18,6 +18,7 @@ conditions.
>                          "arm,mmu-500"
>                          "cavium,smmu-v2"
>                          "qcom,<soc>-smmu-v2", "qcom,smmu-v2"

I don't even see this one in the tree yet...

> +                        "qcom,<soc>-smmu-500", "qcom,smmu-500"

IIRC, the mmu-500 is SMMU v2 implementation, right? Having
qcom,smmu-500 seems kind of pointless.

Given that we're there's only 1 SoC for "qcom,<soc>-smmu-v2" and
you're already on to a new genericish compatible, just do SoC specific
compatible strings.

Rob
