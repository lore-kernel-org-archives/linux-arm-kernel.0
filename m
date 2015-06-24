From: tony@atomide.com (Tony Lindgren)
Date: Wed, 24 Jun 2015 05:09:39 -0700
Subject: [PATCH 08/17] ARM: dts: dra7: Add dt node for the sycon pcie
In-Reply-To: <20150624145617.e5248d466fe5b2e0eb1ca087@ti.com>
References: <1435060743-5511-1-git-send-email-kishon@ti.com>
 <1435060743-5511-9-git-send-email-kishon@ti.com>
 <20150624145017.9b70a1fba477d8b99ce85702@ti.com>
 <20150624145617.e5248d466fe5b2e0eb1ca087@ti.com>
Message-ID: <20150624120938.GG4156@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Roger Quadros <rogerq@ti.com> [150624 04:58]:
> On Wed, 24 Jun 2015 14:50:17 +0300
> Roger Quadros <rogerq@ti.com> wrote:
> 
> > On Tue, 23 Jun 2015 17:28:53 +0530
> > Kishon Vijay Abraham I <kishon@ti.com> wrote:
> > 
> > > Add new device tree node for the control module register space where
> > > PCIe registers are present.
> > > 
> > > Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> > > ---
> > >  arch/arm/boot/dts/dra7.dtsi |    5 +++++
> > >  1 file changed, 5 insertions(+)
> > > 
> > > diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
> > > index 260f300..3f434f7 100644
> > > --- a/arch/arm/boot/dts/dra7.dtsi
> > > +++ b/arch/arm/boot/dts/dra7.dtsi
> > > @@ -291,6 +291,11 @@
> > >  			reg = <0x4a002e00 0x7c>;
> > >  		};
> > >  
> > > +		dra7_ctrl_pcie: tisyscon at 4a003c00 {
> > > +			compatible = "syscon";
> > > +			reg = <0x4a003c00 0x48>;
> > > +		};
> > > +
> > 
> > Why do you need to start from 0x4a003c00?
> > CTRL_CORE_PCIESS1_PCS1 is at 0x4a003c24
> 
> Also, why can't this dra7_ctrl_pcie node be where scm_conf is.

Yes all the scm children should be under scm at 2000 entry in the
dra7.dtsi file.

And BTW, there's nothing stopping a driver doing of_ioremap
on a larger range and be a child under scm at 2000 in the dra7.dtsi
if that range is dedicated to a single driver.

My take is we should only use regmap for the scm_conf area
in general.

Regards,

Tony
