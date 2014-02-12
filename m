From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 12 Feb 2014 15:25:11 +0800
Subject: [RFC PATCH 4/4] ARM: dts: imx6qdl: Add PU power-domain
 information to gpc node
In-Reply-To: <1392125231-28387-5-git-send-email-p.zabel@pengutronix.de>
References: <1392125231-28387-1-git-send-email-p.zabel@pengutronix.de>
 <1392125231-28387-5-git-send-email-p.zabel@pengutronix.de>
Message-ID: <20140212072510.GI31484@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 11, 2014 at 02:27:11PM +0100, Philipp Zabel wrote:
> The PGC that is part of GPC controls isolation and power sequencing of the
> PU power domain. The power domain will be handled by the generic pm domain
> framework and needs a phandle to the PU regulator to turn off power when
> the domain is disabled.
> 
> Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
> ---
>  arch/arm/boot/dts/imx6qdl.dtsi | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
> index 253d82c..595750d 100644
> --- a/arch/arm/boot/dts/imx6qdl.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl.dtsi
> @@ -598,9 +598,17 @@
>  			};
>  
>  			gpc: gpc at 020dc000 {
> +				#address-cells = <1>;
> +				#size-cells = <1>;
>  				compatible = "fsl,imx6q-gpc";
>  				reg = <0x020dc000 0x4000>;
>  				interrupts = <0 89 0x04 0 90 0x04>;
> +				pu-supply = <&reg_pu>;
> +
> +				pd_pu: power-domain at 020dc260 {
> +					compatible = "fsl,power-domain";
> +					reg = <0x020dc260 0x10>;
> +				};

It's time to have a binding doc for gpc/pgc?  And I'm not sure
"fsl,power-domain" is a good compatible as it's so generic.

Shawn

>  			};
>  
>  			gpr: iomuxc-gpr at 020e0000 {
> -- 
> 1.8.5.3
> 
