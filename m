From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 30 Aug 2016 11:03:17 +0100
Subject: [PATCH v8 14/18] ARM: STi: DT: STiH407: Add uniperif player dt
 nodes
In-Reply-To: <20160830100258.GP1661@dell>
References: <1472223413-7254-1-git-send-email-peter.griffin@linaro.org>
 <1472223413-7254-15-git-send-email-peter.griffin@linaro.org>
 <20160830100258.GP1661@dell>
Message-ID: <20160830100317.GQ1661@dell>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 30 Aug 2016, Lee Jones wrote:

> On Fri, 26 Aug 2016, Peter Griffin wrote:
> 
> > This patch adds the DT nodes for the uniperif player
> > IP blocks found on STiH407 family silicon.
> > 
> > Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
> > Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
> > ---
> >  arch/arm/boot/dts/stih407-family.dtsi | 76 +++++++++++++++++++++++++++++++++++
> >  1 file changed, 76 insertions(+)
> 
> Same comments as in patch 14.

s/14/15/

> > diff --git a/arch/arm/boot/dts/stih407-family.dtsi b/arch/arm/boot/dts/stih407-family.dtsi
> > index d1258d5..d263c96 100644
> > --- a/arch/arm/boot/dts/stih407-family.dtsi
> > +++ b/arch/arm/boot/dts/stih407-family.dtsi
> > @@ -880,5 +880,81 @@
> >  			status = "disabled";
> >  			st,syscfg = <&syscfg_core>;
> >  		};
> > +
> > +		sti_uni_player0: sti-uni-player at 0 {
> > +			compatible = "st,sti-uni-player";
> > +			status = "disabled";
> > +			#sound-dai-cells = <0>;
> > +			st,syscfg = <&syscfg_core>;
> > +			clocks = <&clk_s_d0_flexgen CLK_PCM_0>;
> > +			assigned-clocks = <&clk_s_d0_quadfs 0>, <&clk_s_d0_flexgen CLK_PCM_0>;
> > +			assigned-clock-parents = <0>, <&clk_s_d0_quadfs 0>;
> > +			assigned-clock-rates = <50000000>;
> > +			reg = <0x8D80000 0x158>;
> > +			interrupts = <GIC_SPI 84 IRQ_TYPE_NONE>;
> > +			dmas = <&fdma0 2 0 1>;
> > +			dai-name = "Uni Player #0 (HDMI)";
> > +			dma-names = "tx";
> > +			st,uniperiph-id = <0>;
> > +			st,version = <5>;
> > +			st,mode = "HDMI";
> > +		};
> > +
> > +		sti_uni_player1: sti-uni-player at 1 {
> > +			compatible = "st,sti-uni-player";
> > +			status = "disabled";
> > +			#sound-dai-cells = <0>;
> > +			st,syscfg = <&syscfg_core>;
> > +			clocks = <&clk_s_d0_flexgen CLK_PCM_1>;
> > +			assigned-clocks = <&clk_s_d0_quadfs 1>, <&clk_s_d0_flexgen CLK_PCM_1>;
> > +			assigned-clock-parents = <0>, <&clk_s_d0_quadfs 1>;
> > +			assigned-clock-rates = <50000000>;
> > +			reg = <0x8D81000 0x158>;
> > +			interrupts = <GIC_SPI 85 IRQ_TYPE_NONE>;
> > +			dmas = <&fdma0 3 0 1>;
> > +			dai-name = "Uni Player #1 (PIO)";
> > +			dma-names = "tx";
> > +			st,uniperiph-id = <1>;
> > +			st,version = <5>;
> > +			st,mode = "PCM";
> > +		};
> > +
> > +		sti_uni_player2: sti-uni-player at 2 {
> > +			compatible = "st,sti-uni-player";
> > +			status = "disabled";
> > +			#sound-dai-cells = <0>;
> > +			st,syscfg = <&syscfg_core>;
> > +			clocks = <&clk_s_d0_flexgen CLK_PCM_2>;
> > +			assigned-clocks = <&clk_s_d0_quadfs 2>, <&clk_s_d0_flexgen CLK_PCM_2>;
> > +			assigned-clock-parents = <0>, <&clk_s_d0_quadfs 2>;
> > +			assigned-clock-rates = <50000000>;
> > +			reg = <0x8D82000 0x158>;
> > +			interrupts = <GIC_SPI 86 IRQ_TYPE_NONE>;
> > +			dmas = <&fdma0 4 0 1>;
> > +			dai-name = "Uni Player #1 (DAC)";
> > +			dma-names = "tx";
> > +			st,uniperiph-id = <2>;
> > +			st,version = <5>;
> > +			st,mode = "PCM";
> > +		};
> > +
> > +		sti_uni_player3: sti-uni-player at 3 {
> > +			compatible = "st,sti-uni-player";
> > +			status = "disabled";
> > +			#sound-dai-cells = <0>;
> > +			st,syscfg = <&syscfg_core>;
> > +			clocks = <&clk_s_d0_flexgen CLK_SPDIFF>;
> > +			assigned-clocks = <&clk_s_d0_quadfs 3>, <&clk_s_d0_flexgen CLK_SPDIFF>;
> > +			assigned-clock-parents = <0>, <&clk_s_d0_quadfs 3>;
> > +			assigned-clock-rates = <50000000>;
> > +			reg = <0x8D85000 0x158>;
> > +			interrupts = <GIC_SPI 89 IRQ_TYPE_NONE>;
> > +			dmas = <&fdma0 7 0 1>;
> > +			dma-names = "tx";
> > +			dai-name = "Uni Player #1 (PIO)";
> > +			st,uniperiph-id = <3>;
> > +			st,version = <5>;
> > +			st,mode = "SPDIF";
> > +		};
> >  	};
> >  };
> 

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
