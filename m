From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 18 Dec 2017 17:32:22 -0800
Subject: [PATCH 1/3] dt-bindings: ARM: Mediatek: Fix ethsys documentation
In-Reply-To: <b92fd3bd-c61a-ae58-49ef-8727af065ec1@gmail.com>
References: <20171201120708.30129-1-matthias.bgg@gmail.com>
 <b92fd3bd-c61a-ae58-49ef-8727af065ec1@gmail.com>
Message-ID: <20171219013222.GZ7997@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/14, Matthias Brugger wrote:
> Hi Stephen, Michael,
> 
> On 12/01/2017 01:07 PM, Matthias Brugger wrote:
> > The ethsys registers a reset controller, so we need to specify a
> > reset cell. This patch fixes the documentation.
> > 
> > Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>
> > ---
> >  Documentation/devicetree/bindings/arm/mediatek/mediatek,ethsys.txt | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,ethsys.txt b/Documentation/devicetree/bindings/arm/mediatek/mediatek,ethsys.txt
> > index 7aa3fa167668..6cc7840ff37a 100644
> > --- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,ethsys.txt
> > +++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,ethsys.txt
> > @@ -20,4 +20,5 @@ ethsys: clock-controller at 1b000000 {
> >  	compatible = "mediatek,mt2701-ethsys", "syscon";
> >  	reg = <0 0x1b000000 0 0x1000>;
> >  	#clock-cells = <1>;
> > +	#reset-cells = <1>;
> >  };
> > 
> 
> Will you take this patch through the clk tree, or shall I take it through my SoC
> tree?
> 

It's resets, we are clk maintainers. I'm clkfused.

You can take it, along with my

Acked-by: Stephen Boyd <sboyd@codeaurora.org>

if you like/expect conflicts.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
