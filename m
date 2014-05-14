From: rogerq@ti.com (Roger Quadros)
Date: Wed, 14 May 2014 16:23:19 +0300
Subject: [PATCH 11/17] ARM: dts: dra7xx-clocks: Add missing 32khz clocks
 used for PHY
In-Reply-To: <1399383244-14556-12-git-send-email-kishon@ti.com>
References: <1399383244-14556-1-git-send-email-kishon@ti.com>
 <1399383244-14556-12-git-send-email-kishon@ti.com>
Message-ID: <53736E47.4070402@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kishon,


On 05/06/2014 04:33 PM, Kishon Vijay Abraham I wrote:
> Added missing 32khz clock used by PCIe PHY.
> The documention for this node can be found @ ../bindings/clock/ti/gate.txt.

Typo in $subject
s/clocks/clock

--
cheers,
-roger

> 
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Rajendra Nayak <rnayak@ti.com>
> Cc: Tero Kristo <t-kristo@ti.com>
> Cc: Paul Walmsley <paul@pwsan.com>
> Cc: Rob Herring <robh+dt@kernel.org>
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  arch/arm/boot/dts/dra7xx-clocks.dtsi |    8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/dra7xx-clocks.dtsi b/arch/arm/boot/dts/dra7xx-clocks.dtsi
> index 44993ec..e1bd052 100644
> --- a/arch/arm/boot/dts/dra7xx-clocks.dtsi
> +++ b/arch/arm/boot/dts/dra7xx-clocks.dtsi
> @@ -1165,6 +1165,14 @@
>  		reg = <0x021c>, <0x0220>;
>  	};
>  
> +	optfclk_pciephy_32khz: optfclk_pciephy_32khz at 4a0093b0 {
> +		compatible = "ti,gate-clock";
> +		clocks = <&sys_32k_ck>;
> +		#clock-cells = <0>;
> +		reg = <0x13b0>;
> +		ti,bit-shift = <8>;
> +	};
> +
>  	optfclk_pciephy_div: optfclk_pciephy_div at 4a00821c {
>  		compatible = "ti,divider-clock";
>  		clocks = <&apll_pcie_ck>;
> 
