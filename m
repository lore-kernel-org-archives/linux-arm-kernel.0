From: horms@verge.net.au (Simon Horman)
Date: Mon, 12 Oct 2015 09:19:20 +0900
Subject: [PATCH] ARM: shmobile: porter: add QSPI DT support
In-Reply-To: <20151012000453.GC20025@verge.net.au>
References: <1738678.v21ITp1gYW@wasted.cogentembedded.com>
 <20151012000453.GC20025@verge.net.au>
Message-ID: <20151012001920.GG20025@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 12, 2015 at 09:04:53AM +0900, Simon Horman wrote:
> [Cc Geert]
> 
> On Fri, Oct 09, 2015 at 11:51:05PM +0300, Sergei Shtylyov wrote:
> > Define the Porter board dependent part of the QSPI device node.
> > Add device nodes  for Spansion  S25FL512S SPI flash and the MTD partitions
> > on it.
> > 
> > This patch is  mostly analogous to the commit f59838d44835 (ARM: shmobile:
> > henninger: add QSPI DT support) as there  are no differences between the
> > boards in this respect.
> > 
> > Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> 
> Thanks, I have queued this up for v4.4.

For the record, I queued-up v2.

> 
> > ---
> > This patch is against 'renesas-devel-20151008-v4.3-rc4' tag of Simon Horman's
> > 'renesas.git' repo plus the Porter I2C2 and VIN0/ADV7180 patches posted earlier.
> > 
> >  arch/arm/boot/dts/r8a7791-porter.dts |   38 +++++++++++++++++++++++++++++++++++
> >  1 file changed, 38 insertions(+)
> > 
> > Index: renesas/arch/arm/boot/dts/r8a7791-porter.dts
> > ===================================================================
> > --- renesas.orig/arch/arm/boot/dts/r8a7791-porter.dts
> > +++ renesas/arch/arm/boot/dts/r8a7791-porter.dts
> > @@ -110,6 +110,11 @@
> >  		renesas,function = "sdhi2";
> >  	};
> >  
> > +	qspi_pins: spi0 {
> > +		renesas,groups = "qspi_ctrl", "qspi_data4";
> > +		renesas,function = "qspi";
> > +	};
> > +
> >  	i2c2_pins: i2c2 {
> >  		renesas,groups = "i2c2";
> >  		renesas,function = "i2c2";
> > @@ -165,6 +170,39 @@
> >  	status = "okay";
> >  };
> >  
> > +&qspi {
> > +	pinctrl-0 = <&qspi_pins>;
> > +	pinctrl-names = "default";
> > +
> > +	status = "okay";
> > +
> > +	flash at 0 {
> > +		#address-cells = <1>;
> > +		#size-cells = <1>;
> > +		compatible = "spansion,s25fl512s", "jedec,spi-nor";
> 
> spansion,s25fl512s is used in several dt files but it seems to be
> undocumented. Do we have a plan to resolve this?
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
