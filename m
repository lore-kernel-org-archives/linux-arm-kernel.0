From: peter.griffin@linaro.org (Peter Griffin)
Date: Fri, 3 Jun 2016 14:00:46 +0100
Subject: [PATCH v4 15/18] ARM: STi: DT: STiH407: Add sti-sasg-codec dt node
In-Reply-To: <574D53E7.40008@st.com>
References: <1464192412-16386-1-git-send-email-peter.griffin@linaro.org>
 <1464192412-16386-17-git-send-email-peter.griffin@linaro.org>
 <574D53E7.40008@st.com>
Message-ID: <20160603130046.GE9912@griffinp-ThinkPad-X1-Carbon-2nd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnaud,

Thanks for reviewing.

On Tue, 31 May 2016, Arnaud Pouliquen wrote:
> 
> 
> On 05/25/2016 06:06 PM, Peter Griffin wrote:
> > This patch adds the dt node for the internal audio
> > codec IP.
> > 
> > Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
> > ---
> >  arch/arm/boot/dts/stih407-family.dtsi | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> > 
> > diff --git a/arch/arm/boot/dts/stih407-family.dtsi b/arch/arm/boot/dts/stih407-family.dtsi
> > index b423836..60f95b6 100644
> > --- a/arch/arm/boot/dts/stih407-family.dtsi
> > +++ b/arch/arm/boot/dts/stih407-family.dtsi
> > @@ -746,5 +746,14 @@
> >  				<&clk_s_c0_flexgen CLK_TX_ICN_DISP_0>,
> >  				<&clk_s_c0_flexgen CLK_EXT2F_A9>;
> >  		};
> > +
> > +		sti_sasg_codec: sti-sasg-codec {
> > +			compatible = "st,stih407-sas-codec";
> > +			#sound-dai-cells = <1>;
> > +			status = "okay";
> Should be set to disable in family and enabled it depending on boards
> (stihxxx-b2120.dtsi)

Will fix in v5

> > +			st,syscfg = <&syscfg_core>;
> > +			pinctrl-names = "default";
> > +			pinctrl-0 = <&pinctrl_spdif_out >;
> Declare pinctrl use in stihxxx-b2120.dtsi, should be set only if SPDIF used.

Will fix in v5

regards,

Peter.
