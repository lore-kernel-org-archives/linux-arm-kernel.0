From: horms@verge.net.au (Simon Horman)
Date: Mon, 22 Jul 2013 09:43:30 +0900
Subject: [PATCH 01/19] ARM: shmobile: r8a73a4: Add pin control device to
 device tree
In-Reply-To: <5391577.hBy909tQ3H@avalon>
References: <cover.1374208262.git.horms+renesas@verge.net.au>
 <c173e780f82e5dea3da21f9eda47bc48aa3f57b1.1374208262.git.horms+renesas@verge.net.au>
 <51E931EA.6010805@cogentembedded.com> <5391577.hBy909tQ3H@avalon>
Message-ID: <20130722004329.GE12445@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 19, 2013 at 02:42:14PM +0200, Laurent Pinchart wrote:
> On Friday 19 July 2013 16:32:42 Sergei Shtylyov wrote:
> > Hello.
> > 
> > On 19-07-2013 8:36, Simon Horman wrote:
> > > From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> > > 
> > > Add a pfc node to the r8a73a4 device tree.
> > 
> >     This patch looks strange...
> > 
> > > Signed-off-by: Laurent Pinchart
> > > <laurent.pinchart+renesas@ideasonboard.com>
> > > Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> > > ---
> > > 
> > >   arch/arm/boot/dts/r8a73a4.dtsi |   88
> > >   ++++++++++++++++++++++++++++++++++++++++ 1 file changed, 88
> > >   insertions(+)
> > > 
> > > diff --git a/arch/arm/boot/dts/r8a73a4.dtsi
> > > b/arch/arm/boot/dts/r8a73a4.dtsi index 4ff2019..f1a35d5 100644
> > > --- a/arch/arm/boot/dts/r8a73a4.dtsi
> > > +++ b/arch/arm/boot/dts/r8a73a4.dtsi
> > > @@ -85,4 +85,92 @@
> > > 
> > >   		interrupt-parent = <&gic>;
> > >   		interrupts = <0 69 4>;
> > >   	
> > >   	};
> > > 
> > > +
> > > +	i2c0: i2c at e6500000 {
> > > +		#address-cells = <1>;
> > > +		#size-cells = <0>;
> > > +		compatible = "renesas,rmobile-iic";
> > > +		reg = <0 0xe6500000 0 0x428>;
> > > +		interrupt-parent = <&gic>;
> > > +		interrupts = <0 174 0x4>;
> > > +	};
> > 
> > [...]
> > 
> > > +	i2c8: i2c at e6570000 {
> > > +		#address-cells = <1>;
> > > +		#size-cells = <0>;
> > > +		compatible = "renesas,rmobile-iic";
> > > +		reg = <0 0xe6570000 0 0x428>;
> > > +		interrupt-parent = <&gic>;
> > > +		interrupts = <0 173 0x4>;
> > > +	};
> > > +
> > 
> > Hm, this also adds a bunch of I2C controllers which is not mentioned in the
> > changelog at all.
> 
> Rebase error ? They were not included in my original patch.

Sorry, I will correct that and repost.
