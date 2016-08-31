From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 31 Aug 2016 12:28:19 +0100
Subject: [PATCH v8 15/18] ARM: STi: DT: STiH407: Add uniperif reader dt
 nodes
In-Reply-To: <20160830142112.GA22514@griffinp-ThinkPad-X1-Carbon-2nd>
References: <1472223413-7254-1-git-send-email-peter.griffin@linaro.org>
 <1472223413-7254-16-git-send-email-peter.griffin@linaro.org>
 <20160830100148.GO1661@dell>
 <20160830142112.GA22514@griffinp-ThinkPad-X1-Carbon-2nd>
Message-ID: <20160831112819.GJ27357@dell>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 30 Aug 2016, Peter Griffin wrote:
> Thanks for reviewing and your very valuable feedback.
> On Tue, 30 Aug 2016, Lee Jones wrote:
> > On Fri, 26 Aug 2016, Peter Griffin wrote:
> > 
> > > This patch adds the DT node for the uniperif reader
> > > IP block found on STiH407 family silicon.
> > > 
> > > Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
> > > Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
> > > ---
> > >  arch/arm/boot/dts/stih407-family.dtsi | 26 ++++++++++++++++++++++++++
> > >  1 file changed, 26 insertions(+)
> > > 
> > > diff --git a/arch/arm/boot/dts/stih407-family.dtsi b/arch/arm/boot/dts/stih407-family.dtsi
> > > index d263c96..bdddf2c 100644
> > > --- a/arch/arm/boot/dts/stih407-family.dtsi
> > > +++ b/arch/arm/boot/dts/stih407-family.dtsi
> > > @@ -956,5 +956,31 @@
> > >  			st,version = <5>;
> > >  			st,mode = "SPDIF";
> > >  		};
> > > +
> > > +		sti_uni_reader0: sti-uni-reader at 0 {
> > > +			compatible = "st,sti-uni-reader";
> > > +			status = "disabled";
> > 
> > I find it's normally nicer to place the status of the node at the
> > bottom, separated by a '\n'.
> 
> Ok I'll add a superflous '\n' in the next version.

Everyone loves a smart arse!

In this case I believe the '\n' to be a functional separator and not
superfluous at all.

> > > +			dai-name = "Uni Reader #0 (PCM IN)";
> > 
> > Oooo, not seen something like this before.
> > 
> > If it does not already have one, it would require a DT Ack.
> 
> No idea, the driver got merged 1 year ago.
> 
> Arnaud did you get a DT ack when you merged this driver & binding?
> > 
> > > +			st,version = <3>;
> > 
> > This will likely need a DT Ack too.  We usually encode this sort of
> > information in the compatible string.
> 
> See 05c1b4480e86a871b18030d6f3d532dc0ecdf38c

Well Rob's the boss.  We certainly never used to take 'device ID' or
'version' attributes.  I guess something must have changed.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
