From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 31 Jan 2014 16:27:50 +0100
Subject: [PATCH V3 6/8] SPEAr13xx: Fixup: Move SPEAr1340 SATA platform
 code to phy driver
In-Reply-To: <20140131041204.GC2618@pratyush-vbox>
References: <cover.1391077731.git.mohit.kumar@st.com>
 <201401301421.00990.arnd@arndb.de> <20140131041204.GC2618@pratyush-vbox>
Message-ID: <201401311627.50482.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 31 January 2014, Pratyush Anand wrote:
> On Thu, Jan 30, 2014 at 09:21:00PM +0800, Arnd Bergmann wrote:
> > On Thursday 30 January 2014, Mohit Kumar wrote:
> > > 
> > > diff --git a/Documentation/devicetree/bindings/phy/spear13xx-miphy.txt b/Documentation/devicetree/bindings/phy/spear13xx-miphy.txt
> > > new file mode 100644
> > > index 0000000..208b37d
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/phy/spear13xx-miphy.txt
> > > @@ -0,0 +1,8 @@
> > > +Required properties:
> > > +- compatible : should be "st,spear1340-sata-pcie-phy".
> > 
> > Just for confirmation: This phy is by design only capable of driving
> > sata or pcie, but nothing else if reused in a different SoC, right?
> > 
> > If the phy is actually more generic than that, I'd suggest changing
> > the name, otherwise it's ok.
> 
> OK, we will give a generic name as it can be used for sata/pcie/usb3.0.
> Although, phy register definition may vary from version to version,
> but that can be managed,as and when support of new soc is added. 

It probably doesn't hurt to already define a list of possible
modes in the binding that you already know about. That way, you
don't have to update the binding in sync with the driver if you
add another mode, such as USB.

	Arnd
