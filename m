From: thierry.reding@gmail.com (Thierry Reding)
Date: Wed, 26 Jun 2013 12:18:17 +0200
Subject: [PATCH 03/23] ARM: dt: tegra30: iommu: Add "nvidia,memory-clients"
In-Reply-To: <1372238906-9346-4-git-send-email-hdoyu@nvidia.com>
References: <1372238906-9346-4-git-send-email-hdoyu@nvidia.com>
Message-ID: <20130626101816.GE27083@manwe>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 26, 2013 at 12:28:06PM +0300, Hiroshi Doyu wrote:
[...]
> diff --git a/Documentation/devicetree/bindings/iommu/nvidia,tegra30-smmu.txt b/Documentation/devicetree/bindings/iommu/nvidia,tegra30-smmu.txt
[...]
> @@ -23,3 +24,13 @@ Example:
>  		nvidia,swgroups = <0x00000000 0x000779ff>;
>  		nvidia,ahb = <&ahb>;
>  	};
> +
> +	host1x {
> +		compatible = "nvidia,tegra30-host1x", "simple-bus";
> +		nvidia,memory-clients = <SWGID_HC>;

And this could use the SWGID(HC) to match up with how GPIOs are
referenced in the DTS files. Though I see that the clocks don't use a
parameterized version either, so things are inconsistent anyway. But if
SWGID() isn't used then maybe it shouldn't be provided by the header
file in the first place.

Oh, one other thing: both GPIO and CAR use the TEGRA_ prefix, perhaps
this should use it as well?

> diff --git a/arch/arm/boot/dts/tegra30.dtsi b/arch/arm/boot/dts/tegra30.dtsi
[...]
> index 14ec3f9..3fcee3f 100644
> --- a/arch/arm/boot/dts/tegra30.dtsi
> +++ b/arch/arm/boot/dts/tegra30.dtsi
> @@ -1,5 +1,6 @@
>  #include <dt-bindings/clock/tegra30-car.h>
>  #include <dt-bindings/gpio/tegra-gpio.h>
> +#include <dt-bindings/iommu/tegra-swgid.h>
>  #include <dt-bindings/interrupt-controller/arm-gic.h>

Nit: these includes seem to be ordered alphabetically; if so then iommu
should go below interrupt-controller.

> @@ -286,6 +300,7 @@
>  		interrupts = <GIC_SPI 91 IRQ_TYPE_LEVEL_HIGH>;
>  		nvidia,dma-request-selector = <&apbdma 20>;
>  		clocks = <&tegra_car TEGRA30_CLK_UARTE>;
> +		nvidia,memory-clients = <14>;

SWGID_PPCS?

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130626/d449a65f/attachment-0001.sig>
