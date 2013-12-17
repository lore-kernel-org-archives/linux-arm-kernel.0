From: paul@pwsan.com (Paul Walmsley)
Date: Tue, 17 Dec 2013 09:52:14 +0000 (UTC)
Subject: [PATCHv10 30/41] ARM: dts: am43xx clock data
In-Reply-To: <1385453182-24421-31-git-send-email-t-kristo@ti.com>
References: <1385453182-24421-1-git-send-email-t-kristo@ti.com>
 <1385453182-24421-31-git-send-email-t-kristo@ti.com>
Message-ID: <alpine.DEB.2.02.1312170951360.14039@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 26 Nov 2013, Tero Kristo wrote:

> This patch creates a unique node for each clock in the AM43xx power,
> reset and clock manager (PRCM).
> 
> Signed-off-by: Tero Kristo <t-kristo@ti.com>

...

> diff --git a/arch/arm/boot/dts/am4372.dtsi b/arch/arm/boot/dts/am4372.dtsi
> index 974d103..18f2401 100644
> --- a/arch/arm/boot/dts/am4372.dtsi
> +++ b/arch/arm/boot/dts/am4372.dtsi
> @@ -67,6 +67,20 @@
>  		ranges;
>  		ti,hwmods = "l3_main";
>  
> +		prcm: prcm at 44df0000 {
> +			compatible = "ti,clock-master";
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			reg = <0x44df0000 0x11000>;
> +		};
> +
> +		scrm: scrm at 44e10000 {
> +			compatible = "ti,clock-master";
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			reg = <0x44e10000 0x2000>;
> +		};

Same issues here with the compatible strings and
separating out the clocks and clockdomain data into separate DT
nodes, as discussed with the OMAP4 data patch.


- Paul
