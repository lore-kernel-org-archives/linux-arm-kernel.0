From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 21 Jul 2017 13:38:47 -0700
Subject: [PATCHv1 1/4] ARM: dts: socfpga: update documentation for clock
 bindings
In-Reply-To: <20170710155134.d6egwhncc3mw5ch5@rob-hp-laptop>
References: <1499454199-31901-1-git-send-email-dinguyen@kernel.org>
 <20170710155134.d6egwhncc3mw5ch5@rob-hp-laptop>
Message-ID: <20170721203847.GI19878@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/10, Rob Herring wrote:
> On Fri, Jul 07, 2017 at 02:03:16PM -0500, Dinh Nguyen wrote:
> > Update the bindings document for the Arria10 and Stratix10 clock bindings.
> > 
> > Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
> > ---
> >  Documentation/devicetree/bindings/clock/altr_socfpga.txt | 14 ++++++++++++++
> >  1 file changed, 14 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/clock/altr_socfpga.txt b/Documentation/devicetree/bindings/clock/altr_socfpga.txt
> > index f72e80e..1c32658 100644
> > --- a/Documentation/devicetree/bindings/clock/altr_socfpga.txt
> > +++ b/Documentation/devicetree/bindings/clock/altr_socfpga.txt
> > @@ -12,6 +12,20 @@ Required properties:
> >  	"altr,socfpga-gate-clk" - Clocks that directly feed peripherals and
> >  		can get gated.
> >  
> > +	For Arria10:
> > +	"altr,socfpga-a10-pll-clock" - for a PLL clock
> > +	"altr,socfpga-a10-perip-clock" - The peripheral clock divided from the
> > +		PLL clock.
> > +	"altr,socfpga-a10-gate-clk" - Clocks that directly feed peripherals and
> > +		can get gated.
> > +
> > +	For Stratix10:
> > +	"altr,socfpga-s10-pll-clock" - for a PLL clock
> > +	"altr,socfpga-s10-perip-clock" - The peripheral clock divided from the
> > +		PLL clock.
> > +	"altr,socfpga-s10-gate-clk" - Clocks that directly feed peripherals and
> > +		can get gated.
> 
> We're generally not doing a clock per node clock providers on new 
> platforms and doing a single (or few) clock controller nodes instead. It 
> doesn't look like there's much or any reuse here from older platforms 
> which would be the main reason to keep this style.

Agreed. Can this be rewritten to new style binding?

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
