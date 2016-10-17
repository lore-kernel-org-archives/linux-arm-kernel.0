From: ray.jui@broadcom.com (Ray Jui)
Date: Mon, 17 Oct 2016 14:50:24 -0700
Subject: [PATCH 3/3] arm64: dts: Update Broadcom NS2 to generic IOMMU
 binding
In-Reply-To: <f2de1b15adb2f57529734a4769ef04d9cde3cc5d.1476706244.git.robin.murphy@arm.com>
References: <acf4f770eab43fec8c5b6e9cddb6dd0defc52138.1476706244.git.robin.murphy@arm.com>
 <f2de1b15adb2f57529734a4769ef04d9cde3cc5d.1476706244.git.robin.murphy@arm.com>
Message-ID: <6f96a6cc-7e12-6827-ce88-65e2accda576@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Robin,

On 10/17/2016 5:13 AM, Robin Murphy wrote:
> With the "mmu-masters" property now deprecated and optional, the
> generic binding offers a more efficient way to specify no masters.
>
> CC: Ray Jui <rjui@broadcom.com>
> CC: Scott Branden <sbranden@broadcom.com>
> CC: Jon Mason <jonmason@broadcom.com>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>  arch/arm64/boot/dts/broadcom/ns2.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm64/boot/dts/broadcom/ns2.dtsi b/arch/arm64/boot/dts/broadcom/ns2.dtsi
> index d95dc408629a..65530e193e8a 100644
> --- a/arch/arm64/boot/dts/broadcom/ns2.dtsi
> +++ b/arch/arm64/boot/dts/broadcom/ns2.dtsi
> @@ -248,7 +248,7 @@
>  				     <GIC_SPI 260 IRQ_TYPE_LEVEL_HIGH>,
>  				     <GIC_SPI 261 IRQ_TYPE_LEVEL_HIGH>,
>  				     <GIC_SPI 262 IRQ_TYPE_LEVEL_HIGH>;
> -			mmu-masters;
> +			#iommu-cells = <1>;
>  		};
>
>  		pinctrl: pinctrl at 6501d130 {
>

Thanks!

Acked-by: Ray Jui <ray.jui@broadcom.com>
