From: JOLLYS@xilinx.com (Jolly Shah)
Date: Tue, 13 Mar 2018 18:39:13 +0000
Subject: [PATCH 2/3] dt-bindings: clock: Add bindings for ZynqMP clock
 driver
In-Reply-To: <CAL_JsqKUC47xB5O2Y6c3efVCjJY=V+XO3xyLTU9rNia40bdZkg@mail.gmail.com>
References: <1519856861-31384-1-git-send-email-jollys@xilinx.com>
 <1519856861-31384-3-git-send-email-jollys@xilinx.com>
 <20180306014549.6t3ae5adzc3cpi5v@rob-hp-laptop>
 <DM2PR0201MB0767031248A9F773620722FDB8D80@DM2PR0201MB0767.namprd02.prod.outlook.com>
 <CAL_JsqKUC47xB5O2Y6c3efVCjJY=V+XO3xyLTU9rNia40bdZkg@mail.gmail.com>
Message-ID: <DM2PR0201MB0767FFBAECF3A0B30251DBB8B8D20@DM2PR0201MB0767.namprd02.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,

> -----Original Message-----
> From: Rob Herring [mailto:robh at kernel.org]
> Sent: Wednesday, March 07, 2018 5:20 PM
> To: Jolly Shah <JOLLYS@xilinx.com>
> Cc: mturquette at baylibre.com; sboyd at codeaurora.org;
> michal.simek at xilinx.com; mark.rutland at arm.com; linux-clk at vger.kernel.org;
> devicetree at vger.kernel.org; Shubhrajyoti Datta <shubhraj@xilinx.com>; linux-
> kernel at vger.kernel.org; Rajan Vaja <RAJANV@xilinx.com>; linux-arm-
> kernel at lists.infradead.org
> Subject: Re: [PATCH 2/3] dt-bindings: clock: Add bindings for ZynqMP clock
> driver
> 
> On Wed, Mar 7, 2018 at 4:47 PM, Jolly Shah <JOLLYS@xilinx.com> wrote:
> > Hi Rob,
> >
> >
> >> -----Original Message-----
> >> From: Rob Herring [mailto:robh at kernel.org]
> >> Sent: Monday, March 05, 2018 5:46 PM
> >> To: Jolly Shah <JOLLYS@xilinx.com>
> >> Cc: mturquette at baylibre.com; sboyd at codeaurora.org;
> >> michal.simek at xilinx.com; mark.rutland at arm.com;
> >> linux-clk at vger.kernel.org; devicetree at vger.kernel.org; Shubhrajyoti
> >> Datta <shubhraj@xilinx.com>; linux- kernel at vger.kernel.org; Jolly
> >> Shah <JOLLYS@xilinx.com>; Rajan Vaja <RAJANV@xilinx.com>;
> >> linux-arm-kernel at lists.infradead.org
> >> Subject: Re: [PATCH 2/3] dt-bindings: clock: Add bindings for ZynqMP
> >> clock driver
> >>
> >> On Wed, Feb 28, 2018 at 02:27:40PM -0800, Jolly Shah wrote:
> >> > Add documentation to describe Xilinx ZynqMP clock driver bindings.
> >> >
> >> > Signed-off-by: Jolly Shah <jollys@xilinx.com>
> >> > Signed-off-by: Rajan Vaja <rajanv@xilinx.com>
> >> > Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
> >> > ---
> 
> >> > +95         dpll_post_src
> >> > +96         vpll_int
> >> > +97         vpll_pre_src
> >> > +98         vpll_half
> >> > +99         vpll_int_mux
> >> > +100                vpll_post_src
> >> > +101                can0_mio
> >> > +102                can1_mio
> >> > +
> >> > +Example:
> >> > +
> >> > +clk: clk {
> >> > +   #clock-cells = <1>;
> >> > +   compatible = "xlnx,zynqmp-clk";
> >>
> >> How do you control the clocks?
> >
> > Clocks are controlled by a dedicated platform management controller. Above
> clock ids are used to identify clocks between master and PMU.
> 
> What is the interface to the "platform management controller"? Because you
> have no registers, I'm guessing a firmware interface? If so, then just define the
> firmware node as a clock provider.

Yes it is firmware interface. Along with clocks, firmware interface also controls power and pinctrl operations as major.
I am not sure if I understand you correctly. Do you suggest to register clocks through Firmware driver or just use firmware DT node as clock provider and clock driver DT node can reference clocks from FW node to register same?
 
> 
> Rob
