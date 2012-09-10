From: avinashphilip@ti.com (Philip, Avinash)
Date: Mon, 10 Sep 2012 07:45:48 +0000
Subject: [PATCH RESEND] arm/dts: AM33XX: Add SPI device tree data
In-Reply-To: <20120907125936.GH27758@beef>
References: <1346914815-860-1-git-send-email-avinashphilip@ti.com>
 <20120907125936.GH27758@beef>
Message-ID: <518397C60809E147AF5323E0420B992E3E99E663@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 07, 2012 at 18:29:36, Porter, Matt wrote:
> On Thu, Sep 06, 2012 at 12:30:15PM +0530, Philip, Avinash wrote:
> > Add McSPI data node to AM33XX device tree file. The McSPI module (and so
> > as the driver) is reused from OMAP4.
> > 
> > Signed-off-by: Philip, Avinash <avinashphilip@ti.com>
> > ---
> > Resenting patch because ARM & OMAP mailing list was not copied.
> > 
> > :100644 100644 bb31bff... 6b469bd... M	arch/arm/boot/dts/am33xx.dtsi
> >  arch/arm/boot/dts/am33xx.dtsi |   25 +++++++++++++++++++++++++
> >  1 files changed, 25 insertions(+), 0 deletions(-)
> > 
> > diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
> > index bb31bff..6b469bd 100644
> > --- a/arch/arm/boot/dts/am33xx.dtsi
> > +++ b/arch/arm/boot/dts/am33xx.dtsi
> > @@ -210,5 +210,30 @@
> >  			interrupt-parent = <&intc>;
> >  			interrupts = <91>;
> >  		};
> > +
> > +		spi0: spi at 48030000 {
> > +			compatible = "ti,omap4-mcspi";
> > +			#address-cells = <1>;
> > +			#size-cells = <0>;
> > +			reg = <0x4830000 0x400>;
> 
> Please fix this typo, should be 0x48030000.
> 
> With the typo fixed, it's working on bone for me:

Thanks for review and testing.
I didn't notice the issue as currently hwmod fills up reg 
resource data & hence I missed it.

I will correct & re-send.

Thanks
Avinash

> 
> Tested-by: Matt Porter <mporter@ti.com>
> 
> -Matt
> 
