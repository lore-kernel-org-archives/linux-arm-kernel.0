From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 26 Feb 2014 22:01:06 +0800
Subject: [PATCH v2 1/2] ARM: dts: imx6: adjust the interrupt list in
 order to support MSI
In-Reply-To: <1393410438-28205-1-git-send-email-l.stach@pengutronix.de>
References: <1393410438-28205-1-git-send-email-l.stach@pengutronix.de>
Message-ID: <20140226140104.GC23892@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 26, 2014 at 11:27:17AM +0100, Lucas Stach wrote:
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

What about replacing the comment with an 'interrupt-names' property?

Shawn

> +			interrupts = <0 123 0x04>, <0 122 0x04>, <0 121 0x04>, <0 120 0x04>;
>  			clocks = <&clks 189>, <&clks 187>, <&clks 206>, <&clks 144>;
>  			clock-names = "pcie_ref_125m", "sata_ref_100m", "lvds_gate", "pcie_axi";
>  			status = "disabled";
> -- 
> 1.8.5.3
> 
