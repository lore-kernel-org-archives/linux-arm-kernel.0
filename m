From: peter.griffin@linaro.org (Peter Griffin)
Date: Fri, 28 Aug 2015 18:25:59 +0100
Subject: [PATCH v2 5/5] [media] c8sectpfe: Update DT binding doc with
 some minor fixes
In-Reply-To: <20150828065702.GC4796@x1>
References: <1440678575-21646-1-git-send-email-peter.griffin@linaro.org>
 <1440678575-21646-6-git-send-email-peter.griffin@linaro.org>
 <20150828065702.GC4796@x1>
Message-ID: <20150828172559.GC18136@griffinp-ThinkPad-X1-Carbon-2nd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lee,

On Fri, 28 Aug 2015, Lee Jones wrote:

> On Thu, 27 Aug 2015, Peter Griffin wrote:
> 
> > Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
> > ---
> >  .../devicetree/bindings/media/stih407-c8sectpfe.txt      | 16 +++++++---------
> >  1 file changed, 7 insertions(+), 9 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/media/stih407-c8sectpfe.txt b/Documentation/devicetree/bindings/media/stih407-c8sectpfe.txt
> > index e70d840..5d6438c 100644
> > --- a/Documentation/devicetree/bindings/media/stih407-c8sectpfe.txt
> > +++ b/Documentation/devicetree/bindings/media/stih407-c8sectpfe.txt
> > @@ -55,21 +55,20 @@ Example:
> >  		status = "okay";
> >  		reg = <0x08a20000 0x10000>, <0x08a00000 0x4000>;
> >  		reg-names = "stfe", "stfe-ram";
> > -		interrupts = <0 34 0>, <0 35 0>;
> > +		interrupts = <GIC_SPI 34 IRQ_TYPE_NONE>, <GIC_SPI 35 IRQ_TYPE_NONE>;
> >  		interrupt-names = "stfe-error-irq", "stfe-idle-irq";
> > -
> > -		pinctrl-names	= "tsin0-serial", "tsin0-parallel", "tsin3-serial",
> > -				"tsin4-serial", "tsin5-serial";
> > -
> > +		pinctrl-names	= "tsin0-serial",
> > +				  "tsin0-parallel",
> > +				  "tsin3-serial",
> > +				  "tsin4-serial",
> > +				  "tsin5-serial";
> >  		pinctrl-0	= <&pinctrl_tsin0_serial>;
> >  		pinctrl-1	= <&pinctrl_tsin0_parallel>;
> >  		pinctrl-2	= <&pinctrl_tsin3_serial>;
> >  		pinctrl-3	= <&pinctrl_tsin4_serial_alt3>;
> >  		pinctrl-4	= <&pinctrl_tsin5_serial_alt1>;
> > -
> >  		clocks = <&clk_s_c0_flexgen CLK_PROC_STFE>;
> > -		clock-names = "stfe";
> > -
> > +		clock-names = "c8sectpfe";
> 
> Are you sure you even need this property?  I'm thinking that *-names
> properties are *usually* only required if there are more than one in a
> single property.

Yes that is true, but for tsout and merged input stream
functionality the driver will require additional clocks. As I
mentioned in a previous email I hope to add support for this in the
near future.

> 
> >  		/* tsin0 is TSA on NIMA */
> >  		tsin0: port at 0 {
> >  			tsin-num		= <0>;
> > @@ -78,7 +77,6 @@ Example:
> >  			reset-gpios		= <&pio15 4 GPIO_ACTIVE_HIGH>;
> >  			dvb-card		= <STV0367_TDA18212_NIMA_1>;
> >  		};
> > -
> 
> My personal preference is to have a '\n' between nodes.

Yes mine as well, I removed it due to your earlier comment about "superflous \n".
I will add it back in again in v3.

> 
> >  		tsin3: port at 3 {
> >  			tsin-num		= <3>;
> >  			serial-not-parallel;
> 
> But these comments are pretty trivial, so agree or not, or fix-up or
> not, it's that big of a deal.

I agree all trivial, but will fixup in v3.
> 
> Either way,
>   Acked-by: Lee Jones <lee.jones@linaro.org>

Thanks & regards,

Peter.
