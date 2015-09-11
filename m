From: peter.griffin@linaro.org (Peter Griffin)
Date: Fri, 11 Sep 2015 19:06:35 +0100
Subject: [PATCH v2 7/9] ARM: STi: DT: STiH407: Add FDMA driver dt nodes.
In-Reply-To: <20150911175555.GF18779@x1>
References: <1441980871-24475-1-git-send-email-peter.griffin@linaro.org>
 <1441980871-24475-8-git-send-email-peter.griffin@linaro.org>
 <20150911162749.GD18779@x1>
 <20150911164822.GA1150@griffinp-ThinkPad-X1-Carbon-2nd>
 <20150911175555.GF18779@x1>
Message-ID: <20150911180635.GA15803@griffinp-ThinkPad-X1-Carbon-2nd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lee,

On Fri, 11 Sep 2015, Lee Jones wrote:

> On Fri, 11 Sep 2015, Peter Griffin wrote:
> > On Fri, 11 Sep 2015, Lee Jones wrote:
> > > On Fri, 11 Sep 2015, Peter Griffin wrote:
> > > 
> > > > These nodes are required to get the fdma driver working
> > > > on STiH407 based silicon.
> > > > 
> > > > Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
> > > > ---
> > > >  arch/arm/boot/dts/stih407-family.dtsi | 51 +++++++++++++++++++++++++++++++++++
> > > >  1 file changed, 51 insertions(+)
> > > > 
> > > > diff --git a/arch/arm/boot/dts/stih407-family.dtsi b/arch/arm/boot/dts/stih407-family.dtsi
> > > > index 838b812..da07474b 100644
> > > > --- a/arch/arm/boot/dts/stih407-family.dtsi
> > > > +++ b/arch/arm/boot/dts/stih407-family.dtsi
> > > > @@ -565,5 +565,56 @@
> > > >  						  <&phy_port2 PHY_TYPE_USB3>;
> > > >  			};
> > > >  		};
> > > > +
> > > > +		fdma0: fdma0-audio at 8e20000 {
> > > 
> > > I'm not familiar with the FDMA driver, so can't comment knowledgeably,
> > > but the <dev> part of <dev>@<base_address> should only describe the
> > > type of hardware.  I believe in this case it should just be
> > > dma at 08e20000.  Also notice the leading zero in the address, which I
> > > believe mitigates possible confusion.  Then you be more specific with
> > > the label, so something like 'fdma-audio' seems appropriate here.
> > 
> > Ok, can change to that format in v3.
> > 
> > > 
> > > > +			compatible = "st,stih407-fdma-mpe31";
> > > > +			reg = <0x8e20000 0x20000>;
> > > 
> > > I personally find padding up to 32bits helpful in the addresses.
> > 
> > None of the stih407-family nodes I can see have this padding, including
> > the ones merged by you.
> 
> Nither of these two facts mean it's correct.

I thought it was a 'personal' thing. If it is mandated by the spec, then that
is different.

> 
> I'm happy to write a patch to correct them all.

Are you sure your actually correcting anything? Where does it say you
should have a leading zero?

> 
> Bear in mind that this isn't a hard and fast rule.  Both work and are
> legal.  I just think the padding is more consistent.

Surely adding a patch with how the nodes are currently formatted, is more consistent
than adding a patch with padding?

regards,

Peter.
