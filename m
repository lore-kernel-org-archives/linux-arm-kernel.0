From: paul@pwsan.com (Paul Walmsley)
Date: Tue, 17 Dec 2013 09:48:17 +0000 (UTC)
Subject: [PATCHv10 27/41] ARM: dts: am33xx clock data
In-Reply-To: <1385453182-24421-28-git-send-email-t-kristo@ti.com>
References: <1385453182-24421-1-git-send-email-t-kristo@ti.com>
 <1385453182-24421-28-git-send-email-t-kristo@ti.com>
Message-ID: <alpine.DEB.2.02.1312170947160.14039@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 26 Nov 2013, Tero Kristo wrote:

> This patch creates a unique node for each clock in the AM33xx power,
> reset and clock manager (PRCM).
> 
> Signed-off-by: Tero Kristo <t-kristo@ti.com>

...

> ---
>  arch/arm/boot/dts/am33xx-clocks.dtsi |  662 ++++++++++++++++++++++++++++++++++
>  arch/arm/boot/dts/am33xx.dtsi        |   16 +
>  2 files changed, 678 insertions(+)
>  create mode 100644 arch/arm/boot/dts/am33xx-clocks.dtsi
> 

...

> diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
> index f6d8ffe..52c46e1 100644
> --- a/arch/arm/boot/dts/am33xx.dtsi
> +++ b/arch/arm/boot/dts/am33xx.dtsi
> @@ -102,6 +102,20 @@
>  		ranges;
>  		ti,hwmods = "l3_main";
>  
> +		prcm: prcm at 44e00000 {
> +			compatible = "ti,clock-master";

Same issues here with the compatible strings and separating out the
clocks and clockdomain data into separate DT nodes, as discussed with
the OMAP4 data patch.


- Paul
