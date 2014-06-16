From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Mon, 16 Jun 2014 16:38:47 +0200
Subject: [PATCH v3 12/19] ARM: shmobile: r8a7790: Add CMT devices to DT
In-Reply-To: <539C7E2D.9060807@cogentembedded.com>
References: <1402763021-4067-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <1402763021-4067-13-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <539C7E2D.9060807@cogentembedded.com>
Message-ID: <7796272.K4ZeEadym2@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sergei,

On Saturday 14 June 2014 20:54:05 Sergei Shtylyov wrote:
> On 06/14/2014 08:23 PM, Laurent Pinchart wrote:
> > Add the CMT0 and CMT1 counters to the r8a7790 device tree and make them
> > disabled by default.
> > 
> > Signed-off-by: Laurent Pinchart
> > <laurent.pinchart+renesas@ideasonboard.com>
> > ---
> > 
> >   arch/arm/boot/dts/r8a7790.dtsi | 34 ++++++++++++++++++++++++++++++++++
> >   1 file changed, 34 insertions(+)
> > 
> > diff --git a/arch/arm/boot/dts/r8a7790.dtsi
> > b/arch/arm/boot/dts/r8a7790.dtsi index 29907c9..cc32ac5 100644
> > --- a/arch/arm/boot/dts/r8a7790.dtsi
> > +++ b/arch/arm/boot/dts/r8a7790.dtsi
> > @@ -206,6 +206,40 @@
> >   			     <1 10 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>;
> >   	};
> > 
> > +	cmt0: timer at ffca0000 {
> > +		compatible = "renesas,cmt-48-gen2";
> > +		reg = <0 0xffca0000 0 0x1004>;
> > +		interrupt-parent = <&gic>;
> 
> This prop is inherited from the root node, so unneeded here.

Thank you, I'll fix that. Same for patch 13/19.

> > +		interrupts = <0 142 IRQ_TYPE_LEVEL_HIGH>,
> > +			     <0 143 IRQ_TYPE_LEVEL_HIGH>;
> > +		clocks = <&mstp1_clks R8A7790_CLK_CMT0>;
> > +		clock-names = "fck";
> > +
> > +		renesas,channels-mask = <0x60>;
> > +
> > +		status = "disabled";
> > +	};
> > +
> > +	cmt1: timer at e6130000 {
> > +		compatible = "renesas,cmt-48-gen2";
> > +		reg = <0 0xe6130000 0 0x1004>;
> > +		interrupt-parent = <&gic>;
> 
> Likewise.

-- 
Regards,

Laurent Pinchart
