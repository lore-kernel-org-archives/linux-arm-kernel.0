From: peter.griffin@linaro.org (Peter Griffin)
Date: Tue, 30 Aug 2016 15:21:12 +0100
Subject: [PATCH v8 15/18] ARM: STi: DT: STiH407: Add uniperif reader dt
 nodes
In-Reply-To: <20160830100148.GO1661@dell>
References: <1472223413-7254-1-git-send-email-peter.griffin@linaro.org>
 <1472223413-7254-16-git-send-email-peter.griffin@linaro.org>
 <20160830100148.GO1661@dell>
Message-ID: <20160830142112.GA22514@griffinp-ThinkPad-X1-Carbon-2nd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lee,

Thanks for reviewing and your very valuable feedback.

On Tue, 30 Aug 2016, Lee Jones wrote:

> On Fri, 26 Aug 2016, Peter Griffin wrote:
> 
> > This patch adds the DT node for the uniperif reader
> > IP block found on STiH407 family silicon.
> > 
> > Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
> > Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
> > ---
> >  arch/arm/boot/dts/stih407-family.dtsi | 26 ++++++++++++++++++++++++++
> >  1 file changed, 26 insertions(+)
> > 
> > diff --git a/arch/arm/boot/dts/stih407-family.dtsi b/arch/arm/boot/dts/stih407-family.dtsi
> > index d263c96..bdddf2c 100644
> > --- a/arch/arm/boot/dts/stih407-family.dtsi
> > +++ b/arch/arm/boot/dts/stih407-family.dtsi
> > @@ -956,5 +956,31 @@
> >  			st,version = <5>;
> >  			st,mode = "SPDIF";
> >  		};
> > +
> > +		sti_uni_reader0: sti-uni-reader at 0 {
> > +			compatible = "st,sti-uni-reader";
> > +			status = "disabled";
> 
> I find it's normally nicer to place the status of the node at the
> bottom, separated by a '\n'.

Ok I'll add a superflous '\n' in the next version.

>  There isn't a functional difference
> admittedly, but it would be my preference, since it's not describing
> the device per se.

Will change to your preference in the next version.

> 
> > +			#sound-dai-cells = <0>;
> > +			st,syscfg = <&syscfg_core>;
> > +			reg = <0x8D83000 0x158>;
> 
> We usually use lower-case for the address.

Will fix.

> 
> Since this has a 'reg' property, the '0' in the node name does not
> look appropriate.

Will fix.
> 
> > +			interrupts = <GIC_SPI 87 IRQ_TYPE_NONE>;
> > +			dmas = <&fdma0 5 0 1>;
> > +			dma-names = "rx";
> > +			dai-name = "Uni Reader #0 (PCM IN)";
> 
> Oooo, not seen something like this before.
> 
> If it does not already have one, it would require a DT Ack.

No idea, the driver got merged 1 year ago.

Arnaud did you get a DT ack when you merged this driver & binding?
> 
> > +			st,version = <3>;
> 
> This will likely need a DT Ack too.  We usually encode this sort of
> information in the compatible string.

See 05c1b4480e86a871b18030d6f3d532dc0ecdf38c
> 
> > +		};
> > +
> > +		sti_uni_reader1: sti-uni-reader at 1 {
> > +			compatible = "st,sti-uni-reader";
> > +			status = "disabled";
> > +			#sound-dai-cells = <0>;
> > +			st,syscfg = <&syscfg_core>;
> > +			reg = <0x8D84000 0x158>;
> > +			interrupts = <GIC_SPI 88 IRQ_TYPE_NONE>;
> > +			dmas = <&fdma0 6 0 1>;
> > +			dma-names = "rx";
> > +			dai-name = "Uni Reader #1 (HDMI RX)";
> > +			st,version = <3>;
> > +		};
> 
> All as above.
> 
> >  	};
> >  };
> 

Regards,

Peter.
