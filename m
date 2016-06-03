From: peter.griffin@linaro.org (Peter Griffin)
Date: Fri, 3 Jun 2016 13:50:23 +0100
Subject: [PATCH v4 17/18] ARM: STi: DT: STiH407: Add uniperif reader dt
 nodes
In-Reply-To: <574D56CE.5020802@st.com>
References: <1464192412-16386-1-git-send-email-peter.griffin@linaro.org>
 <1464192412-16386-19-git-send-email-peter.griffin@linaro.org>
 <574D56CE.5020802@st.com>
Message-ID: <20160603125023.GC9912@griffinp-ThinkPad-X1-Carbon-2nd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnaud,

On Tue, 31 May 2016, Arnaud Pouliquen wrote:

> 
> 
> On 05/25/2016 06:06 PM, Peter Griffin wrote:
> > This patch adds the DT node for the uniperif reader
> > IP block found on STiH407 family silicon.
> > 
> > Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
> > ---
> >  arch/arm/boot/dts/stih407-family.dtsi | 28 ++++++++++++++++++++++++++++
> >  1 file changed, 28 insertions(+)
> > 
> > diff --git a/arch/arm/boot/dts/stih407-family.dtsi b/arch/arm/boot/dts/stih407-family.dtsi
> > index 7ca149b..fb6363e1 100644
> > --- a/arch/arm/boot/dts/stih407-family.dtsi
> > +++ b/arch/arm/boot/dts/stih407-family.dtsi
> > @@ -831,5 +831,33 @@
> >  			st,version = <5>;
> >  			st,mode = "SPDIF";
> >  		};
> > +
> > +		sti_uni_reader0: sti-uni-reader at 0 {
> > +			compatible = "st,sti-uni-reader";
> > +			status = "disabled";
> > +			#sound-dai-cells = <0>;
> > +			st,syscfg = <&syscfg_core>;
> > +			reg = <0x8D83000 0x158>;
> > +			interrupts = <GIC_SPI 87 IRQ_TYPE_NONE>;
> > +			dmas = <&fdma0 5 0 1>;
> > +			dma-names = "rx";
> > +			dai-name = "Uni Reader #0 (PCM IN)";
> > +			st,version = <3>;
> > +			pinctrl-names = "default";
> > +			pinctrl-0 = <&pinctrl_i2s_8ch_in>;
> suppress pinctrl declaration

Will fix in v5

regards,

Peter.
