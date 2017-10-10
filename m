From: horms@verge.net.au (Simon Horman)
Date: Tue, 10 Oct 2017 09:25:02 +0200
Subject: [PATCH v2 2/2] arm64: dts: r8a7796: Add OPPs table for cpu devices
In-Reply-To: <e2e31fd8-b5f8-40a8-df3d-e7726bb8a8e1@arm.com>
References: <1507209984-17123-1-git-send-email-horms+renesas@verge.net.au>
 <1507209984-17123-3-git-send-email-horms+renesas@verge.net.au>
 <e2e31fd8-b5f8-40a8-df3d-e7726bb8a8e1@arm.com>
Message-ID: <20171010072501.GI2518@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 05, 2017 at 04:04:47PM +0100, Sudeep Holla wrote:
> 
> 
> On 05/10/17 14:26, Simon Horman wrote:
> > From: Dien Pham <dien.pham.ry@rvc.renesas.com>
> > 
> > Current, OPP tables are defined temporary,
> > they are being evaluated and adjust in future.
> > 
> 
> I assume these OPPs will continue to work in future but just not optimal.

Yes, that is my understanding.

> > Based in part on work by Hien Dang.
> > 
> > Signed-off-by: Dien Pham <dien.pham.ry@rvc.renesas.com>
> > Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
> > Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> > ---
> > v2 [Simon Horman]
> > - Only provide one operating points node for each operating-points-v2 node
> >   as per the binding; other nodes were unused and have been removed
> > 
> > v1 [Simon Horman]
> > - consolidated several patches into one
> > 
> > v0 [Dien Pham]
> > ---
> >  arch/arm64/boot/dts/renesas/r8a7796.dtsi | 58 ++++++++++++++++++++++++++++++++
> >  1 file changed, 58 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/renesas/r8a7796.dtsi b/arch/arm64/boot/dts/renesas/r8a7796.dtsi
> > index 57ac5ca6ed98..2d9edc61437c 100644
> > --- a/arch/arm64/boot/dts/renesas/r8a7796.dtsi
> > +++ b/arch/arm64/boot/dts/renesas/r8a7796.dtsi
> > @@ -46,6 +46,8 @@
> >  			power-domains = <&sysc R8A7796_PD_CA57_CPU0>;
> >  			next-level-cache = <&L2_CA57>;
> >  			enable-method = "psci";
> > +			clocks =<&cpg CPG_CORE R8A7796_CLK_Z>;
> > +			operating-points-v2 = <&cluster0_opp>;
> >  		};
> >  
> >  		a57_1: cpu at 1 {
> > @@ -55,6 +57,7 @@
> >  			power-domains = <&sysc R8A7796_PD_CA57_CPU1>;
> >  			next-level-cache = <&L2_CA57>;
> >  			enable-method = "psci";
> 
> Just curious why clocks are not specified in secondaries ?
> Does this continue work if I hotplug out CPUs in ascending order and
> then hotplug back in descending order ? Also the current driver or OS
> may deal with that but not a good assumption when write DT

Good point. I expect that this is an oversight.
