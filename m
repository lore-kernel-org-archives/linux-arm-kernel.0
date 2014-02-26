From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 26 Feb 2014 16:34:03 +0000
Subject: [PATCH v2 1/2] ARM: dts: imx6: adjust the interrupt list in
 order to support MSI
In-Reply-To: <1393410438-28205-1-git-send-email-l.stach@pengutronix.de>
References: <1393410438-28205-1-git-send-email-l.stach@pengutronix.de>
Message-ID: <20140226163402.GF29659@e106331-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 26, 2014 at 10:27:17AM +0000, Lucas Stach wrote:
> From: Juergen Beisert <jbe@pengutronix.de>
> 
> Signed-off-by: Juergen Beisert <jbe@pengutronix.de>
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> ---
>  arch/arm/boot/dts/imx6qdl.dtsi | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
> index fb28b2ecb1db..aeccbb114fc5 100644
> --- a/arch/arm/boot/dts/imx6qdl.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl.dtsi
> @@ -126,7 +126,8 @@
>  				  0x81000000 0 0          0x01f80000 0 0x00010000 /* downstream I/O */
>  				  0x82000000 0 0x01000000 0x01000000 0 0x00f00000>; /* non-prefetchable memory */
>  			num-lanes = <1>;
> -			interrupts = <0 123 0x04>;
> +			/*               inta          intb         intc         intd/msi */
> +			interrupts = <0 123 0x04>, <0 122 0x04>, <0 121 0x04>, <0 120 0x04>;

This seems to be a "fsl,imx6q-pcie", "snps,dw-pcie" device.

In Documentation/devicetree/bindings/pci/designware-pcie.txt I only see 3
interrupts listed.

The fourth interrupt must be documented.

Do the first three correspond to those in the documentation?

Cheers,
Mark.
