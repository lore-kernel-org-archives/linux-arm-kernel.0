From: tony@atomide.com (Tony Lindgren)
Date: Fri, 18 Apr 2014 15:33:24 -0700
Subject: [PATCH] ARM: DTS: dra7xx-clocks: Correct mcasp2_ahclkx_mux
 bit-shift
In-Reply-To: <533C1A6E.4030100@ti.com>
References: <1396446385-20258-1-git-send-email-peter.ujfalusi@ti.com>
 <533C1A6E.4030100@ti.com>
Message-ID: <20140418223323.GJ21823@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tero Kristo <t-kristo@ti.com> [140402 07:14]:
> On 04/02/2014 04:46 PM, Peter Ujfalusi wrote:
> >The correct bit is 24 for AHCLKX.
> >
> >Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> 
> Yes, thats a clear bug in the data.
> 
> Acked-by: Tero Kristo <t-kristo@ti.com>

Applying into omap-for-v3.15/fixes thanks.

Tony

> >  arch/arm/boot/dts/dra7xx-clocks.dtsi | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> >diff --git a/arch/arm/boot/dts/dra7xx-clocks.dtsi b/arch/arm/boot/dts/dra7xx-clocks.dtsi
> >index e96da9a898ad..cfb8fc753f50 100644
> >--- a/arch/arm/boot/dts/dra7xx-clocks.dtsi
> >+++ b/arch/arm/boot/dts/dra7xx-clocks.dtsi
> >@@ -1640,7 +1640,7 @@
> >  		#clock-cells = <0>;
> >  		compatible = "ti,mux-clock";
> >  		clocks = <&abe_24m_fclk>, <&abe_sys_clk_div>, <&func_24m_clk>, <&atlclkin3_ck>, <&atl_clkin2_ck>, <&atl_clkin1_ck>, <&atl_clkin0_ck>, <&sys_clkin2>, <&ref_clkin0_ck>, <&ref_clkin1_ck>, <&ref_clkin2_ck>, <&ref_clkin3_ck>, <&mlb_clk>, <&mlbp_clk>;
> >-		ti,bit-shift = <28>;
> >+		ti,bit-shift = <24>;
> >  		reg = <0x1860>;
> >  	};
> >
> >
> 
