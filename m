From: horms@verge.net.au (Simon Horman)
Date: Mon, 26 May 2014 09:44:19 +0900
Subject: [PATCH v2 2/2] ARM: shmobile: r8a7779 dtsi: Update
 unit-addresses for clocks
In-Reply-To: <11119685.9RVVTTLT6z@avalon>
References: <1400831180-20409-1-git-send-email-geert+renesas@glider.be>
 <1400831180-20409-3-git-send-email-geert+renesas@glider.be>
 <11119685.9RVVTTLT6z@avalon>
Message-ID: <20140526004419.GC31096@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 23, 2014 at 11:36:51AM +0200, Laurent Pinchart wrote:
> Hi Geert,
> 
> Thank you for the patch.
> 
> On Friday 23 May 2014 09:46:20 Geert Uytterhoeven wrote:
> >   - Correct the unit-address for the "cpg_clocks" node,
> >   - Add missing unit-addresses for the "mstp*_clks" nodes,
> >   - Rename "cpg_clocks" and "mstp*_clks" nodes to the more generic
> >     "clocks".
> > 
> > Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> 
> Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

Thanks, I will queue this up.

> > ---
> > v2:
> >   - Spun-off from "ARM: shmobile: r8a7779 dtsi: Correct #address-cells/
> >     #size-cells for clocks".
> >   - Removed "0x" prefix from cpg_clocks unit-address,
> >   - Renamed cpg_clocks and mstp*_clks nodes to the more generic "clocks".
> > 
> >  arch/arm/boot/dts/r8a7779.dtsi | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> > 
> > diff --git a/arch/arm/boot/dts/r8a7779.dtsi b/arch/arm/boot/dts/r8a7779.dtsi
> > index 395a611e2b5a..61d08f42456c 100644
> > --- a/arch/arm/boot/dts/r8a7779.dtsi
> > +++ b/arch/arm/boot/dts/r8a7779.dtsi
> > @@ -298,7 +298,7 @@
> >  		};
> > 
> >  		/* Special CPG clocks */
> > -		cpg_clocks: cpg_clocks at 0xe6150000 {
> > +		cpg_clocks: clocks at ffc80000 {
> >  			compatible = "renesas,r8a7779-cpg-clocks";
> >  			reg = <0xffc80000 0x30>;
> >  			clocks = <&extal_clk>;
> > @@ -342,7 +342,7 @@
> >  		};
> > 
> >  		/* Gate clocks */
> > -		mstp0_clks: mstp0_clks {
> > +		mstp0_clks: clocks at ffc80030 {
> >  			compatible = "renesas,r8a7779-mstp-clocks",
> >  			             "renesas,cpg-mstp-clocks";
> >  			reg = <0xffc80030 4>;
> > @@ -379,7 +379,7 @@
> >  				"scif1", "scif0", "i2c3", "i2c2", "i2c1",
> >  				"i2c0";
> >  		};
> > -		mstp1_clks: mstp1_clks {
> > +		mstp1_clks: clocks at ffc80034 {
> >  			compatible = "renesas,r8a7779-mstp-clocks",
> >  			             "renesas,cpg-mstp-clocks";
> >  			reg = <0xffc80034 4>, <0xffc80044 4>;
> > @@ -408,7 +408,7 @@
> >  				"ether", "sata",
> >  				"pcie", "vin3";
> >  		};
> > -		mstp3_clks: mstp3_clks {
> > +		mstp3_clks: clocks at ffc8003c {
> >  			compatible = "renesas,r8a7779-mstp-clocks",
> >  			             "renesas,cpg-mstp-clocks";
> >  			reg = <0xffc8003c 4>;
> 
> -- 
> Regards,
> 
> Laurent Pinchart
> 
