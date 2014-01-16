From: robherring2@gmail.com (Rob Herring)
Date: Thu, 16 Jan 2014 08:31:25 -0600
Subject: [PATCH 06/11] documentation/iommu: Update description of ARM
 System MMU binding
In-Reply-To: <1389876263-25759-7-git-send-email-andreas.herrmann@calxeda.com>
References: <1389876263-25759-1-git-send-email-andreas.herrmann@calxeda.com>
 <1389876263-25759-7-git-send-email-andreas.herrmann@calxeda.com>
Message-ID: <CAL_JsqLY6eSbTfjMX-Et1U6Ah=XG+7ZGphvXwNyE1bmMj4aLhA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 16, 2014 at 6:44 AM, Andreas Herrmann
<andreas.herrmann@calxeda.com> wrote:
> This patch adds descriptions fore new properties of device tree
> binding for the ARM SMMU architecture. These properties control
> arm-smmu driver options.
>
> Cc: Rob Herring <robherring2@gmail.com>
> Cc: Grant Likely <grant.likely@linaro.org>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Andreas Herrmann <herrmann.der.user@googlemail.com>
> Signed-off-by: Andreas Herrmann <andreas.herrmann@calxeda.com>

Acked-by: Rob Herring <robh@kernel.org>

> ---
>  .../devicetree/bindings/iommu/arm,smmu.txt         |   11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.txt b/Documentation/devicetree/bindings/iommu/arm,smmu.txt
> index e34c6cd..7ad8ff0 100644
> --- a/Documentation/devicetree/bindings/iommu/arm,smmu.txt
> +++ b/Documentation/devicetree/bindings/iommu/arm,smmu.txt
> @@ -48,6 +48,16 @@ conditions.
>                    from the mmu-masters towards memory) node for this
>                    SMMU.
>
> +- arm,smmu-isolate-devices : Enable device isolation for all masters
> +                   of this SMMU. Ie. each master will be attached to
> +                   its own iommu domain.
> +
> +- calxeda,smmu-secure-config-access : Enable proper handling of buggy
> +                   implementations that always use secure access to
> +                   SMMU configuration registers. In this case
> +                   non-secure aliases of secure registers have to be
> +                   used during SMMU configuration.
> +
>  Example:
>
>          smmu {
> @@ -67,4 +77,5 @@ Example:
>                   */
>                  mmu-masters = <&dma0 0xd01d 0xd01e>,
>                                <&dma1 0xd11c>;
> +                arm,smmu-isolate-devices;
>          };
> --
> 1.7.9.5
>
