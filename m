From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Fri, 19 Jul 2013 14:42:14 +0200
Subject: [PATCH 01/19] ARM: shmobile: r8a73a4: Add pin control device to
 device tree
In-Reply-To: <51E931EA.6010805@cogentembedded.com>
References: <cover.1374208262.git.horms+renesas@verge.net.au>
 <c173e780f82e5dea3da21f9eda47bc48aa3f57b1.1374208262.git.horms+renesas@verge.net.au>
 <51E931EA.6010805@cogentembedded.com>
Message-ID: <5391577.hBy909tQ3H@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 19 July 2013 16:32:42 Sergei Shtylyov wrote:
> Hello.
> 
> On 19-07-2013 8:36, Simon Horman wrote:
> > From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> > 
> > Add a pfc node to the r8a73a4 device tree.
> 
>     This patch looks strange...
> 
> > Signed-off-by: Laurent Pinchart
> > <laurent.pinchart+renesas@ideasonboard.com>
> > Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> > ---
> > 
> >   arch/arm/boot/dts/r8a73a4.dtsi |   88
> >   ++++++++++++++++++++++++++++++++++++++++ 1 file changed, 88
> >   insertions(+)
> > 
> > diff --git a/arch/arm/boot/dts/r8a73a4.dtsi
> > b/arch/arm/boot/dts/r8a73a4.dtsi index 4ff2019..f1a35d5 100644
> > --- a/arch/arm/boot/dts/r8a73a4.dtsi
> > +++ b/arch/arm/boot/dts/r8a73a4.dtsi
> > @@ -85,4 +85,92 @@
> > 
> >   		interrupt-parent = <&gic>;
> >   		interrupts = <0 69 4>;
> >   	
> >   	};
> > 
> > +
> > +	i2c0: i2c at e6500000 {
> > +		#address-cells = <1>;
> > +		#size-cells = <0>;
> > +		compatible = "renesas,rmobile-iic";
> > +		reg = <0 0xe6500000 0 0x428>;
> > +		interrupt-parent = <&gic>;
> > +		interrupts = <0 174 0x4>;
> > +	};
> 
> [...]
> 
> > +	i2c8: i2c at e6570000 {
> > +		#address-cells = <1>;
> > +		#size-cells = <0>;
> > +		compatible = "renesas,rmobile-iic";
> > +		reg = <0 0xe6570000 0 0x428>;
> > +		interrupt-parent = <&gic>;
> > +		interrupts = <0 173 0x4>;
> > +	};
> > +
> 
> Hm, this also adds a bunch of I2C controllers which is not mentioned in the
> changelog at all.

Rebase error ? They were not included in my original patch.

-- 
Regards,

Laurent Pinchart
