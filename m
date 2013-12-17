From: paul@pwsan.com (Paul Walmsley)
Date: Tue, 17 Dec 2013 09:50:51 +0000 (UTC)
Subject: [PATCHv10 28/41] ARM: dts: omap3 clock data
In-Reply-To: <1385453182-24421-29-git-send-email-t-kristo@ti.com>
References: <1385453182-24421-1-git-send-email-t-kristo@ti.com>
 <1385453182-24421-29-git-send-email-t-kristo@ti.com>
Message-ID: <alpine.DEB.2.02.1312170950150.14039@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 26 Nov 2013, Tero Kristo wrote:

> This patch creates a unique node for each clock in the OMAP3 power,
> reset and clock manager (PRCM).
> 
> Signed-off-by: Tero Kristo <t-kristo@ti.com>


> diff --git a/arch/arm/boot/dts/omap3.dtsi b/arch/arm/boot/dts/omap3.dtsi
> index f3a0c26..9e6ea02 100644
> --- a/arch/arm/boot/dts/omap3.dtsi
> +++ b/arch/arm/boot/dts/omap3.dtsi
> @@ -82,6 +82,27 @@
>  		ranges;
>  		ti,hwmods = "l3_main";
>  
> +		prm: prm at 48306000 {
> +			compatible = "ti,clock-master";

Likewise, same issues here with the compatible strings and
separating out the clocks and clockdomain data into separate DT
nodes, as discussed with the OMAP4 data patch.



- Paul
