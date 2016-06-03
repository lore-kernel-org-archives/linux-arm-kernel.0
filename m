From: peter.griffin@linaro.org (Peter Griffin)
Date: Fri, 3 Jun 2016 13:56:42 +0100
Subject: [PATCH v4 16/18] ARM: STi: DT: STiH407: Add uniperif player dt
 nodes
In-Reply-To: <574D5608.3080800@st.com>
References: <1464192412-16386-1-git-send-email-peter.griffin@linaro.org>
 <1464192412-16386-18-git-send-email-peter.griffin@linaro.org>
 <574D5608.3080800@st.com>
Message-ID: <20160603125642.GD9912@griffinp-ThinkPad-X1-Carbon-2nd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnaud,

Thanks for reviewing.

On Tue, 31 May 2016, Arnaud Pouliquen wrote:

> 
> 
> On 05/25/2016 06:06 PM, Peter Griffin wrote:
> > This patch adds the DT nodes for the uniperif player
> > IP blocks found on STiH407 family silicon.
> > 
> > Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
> > ---
> >  arch/arm/boot/dts/stih407-family.dtsi | 76 +++++++++++++++++++++++++++++++++++
> >  1 file changed, 76 insertions(+)
> > 
> > diff --git a/arch/arm/boot/dts/stih407-family.dtsi b/arch/arm/boot/dts/stih407-family.dtsi
> > index 60f95b6..7ca149b 100644
> > --- a/arch/arm/boot/dts/stih407-family.dtsi
> > +++ b/arch/arm/boot/dts/stih407-family.dtsi
> > @@ -755,5 +755,81 @@
> >  			pinctrl-names = "default";
> >  			pinctrl-0 = <&pinctrl_spdif_out >;
> >  		};
> > +
> > +		sti_uni_player0: sti-uni-player at 0 {
> > +			compatible = "st,sti-uni-player";
> > +			status = "disabled";
> > +			#sound-dai-cells = <0>;
> > +			st,syscfg = <&syscfg_core>;
> > +			clocks = <&clk_s_d0_flexgen CLK_PCM_0>;
> > +			assigned-clocks = <&clk_s_d0_flexgen CLK_PCM_0>;
> > +			assigned-clock-parents = <&clk_s_d0_quadfs 0>;
> This does not work properly. You need to declare parent like this:
> assigned-clocks = <&clk_s_d0_quadfs 0>, <&clk_s_d0_flexgen CLK_PCM_0>;
> assigned-clock-parents = <0>, <&clk_s_d0_quadfs 0>;

Will fix in v5

> 
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
> > +			assigned-clocks = <&clk_s_d0_flexgen CLK_PCM_1>;
> > +			assigned-clock-parents = <&clk_s_d0_quadfs 1>;
> assigned-clocks = <&clk_s_d0_quadfs 1>, <&clk_s_d0_flexgen CLK_PCM_1>;
> assigned-clock-parents = <0>, <&clk_s_d0_quadfs 1>;

Will fix in v5

> 
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
> > +			assigned-clocks = <&clk_s_d0_flexgen CLK_PCM_2>;
> > +			assigned-clock-parents = <&clk_s_d0_quadfs 2>;
> assigned-clocks = <&clk_s_d0_quadfs 2>, <&clk_s_d0_flexgen CLK_PCM_2>;
> assigned-clock-parents = <0>, <&clk_s_d0_quadfs 2>;

Will fix in v5

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
> > +			assigned-clocks = <&clk_s_d0_flexgen CLK_SPDIFF>;
> > +			assigned-clock-parents = <&clk_s_d0_quadfs 3>;
> > +			assigned-clock-rates = <50000000>;
> assigned-clocks = <&clk_s_d0_quadfs 3>, <&clk_s_d0_flexgen CLK_SPDIFF>;
> assigned-clock-parents = <0>, <&clk_s_d0_quadfs 3>;

Will fix in v5

Regards,

Peter.
