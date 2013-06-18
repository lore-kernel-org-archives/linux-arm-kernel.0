From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Tue, 18 Jun 2013 19:14:37 -0300
Subject: [PATCH v3 10/12] ARM: mvebu: Relocate Armada 370/XP DeviceBus
 device tree nodes
In-Reply-To: <20130618220929.GA24056@localhost>
References: <1371554737-25319-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1371554737-25319-11-git-send-email-ezequiel.garcia@free-electrons.com>
 <201306181816.26530.arnd@arndb.de>
 <20130618220929.GA24056@localhost>
Message-ID: <20130618221436.GB24056@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 18, 2013 at 07:09:29PM -0300, Ezequiel Garcia wrote:
> On Tue, Jun 18, 2013 at 06:16:26PM +0200, Arnd Bergmann wrote:
> > On Tuesday 18 June 2013, Ezequiel Garcia wrote:
> > > 
> > > +               devbus-bootcs {
> > > +                       compatible = "marvell,mvebu-devbus";
> > > +                       reg = <0xffff0001 0x10400 0x8>;
> > > +                       ranges = <0 MBUS_ID(0x01, 0x2f) 0 0xffffffff>;
> > > +                       #address-cells = <1>;
> > > +                       #size-cells = <1>;
> > > +                       clocks = <&coreclk 0>;
> > > +                       status = "disabled";
> > > +               };
> > 
> > This is a violation of the binding as far as I can tell, since you don't specify ranges
> > to access the 0xffff0001 0x10400 address. However, as I explained in my comment for
> > the binding, I think you should clarify the binding and leave the implementation
> > as you have it here.
> > 
> 
> Mmm... again I got lost here. Which 'ranges' you say I don't specify to
> access the (formerly) 0xffff0001?
> 

Oh, maybe you meant I'm not specifying an mbus-node ranges translation
in this same patch in this .dtsi file I'm modifying?

In that case, that's on purpose to avoid the nightmare involved in
mixing 'ranges' in per-board .dts files together with the ranges
declared in each included .dtsi.

By having only one mbus-node ranges property, per-board, it gets a bit
simpler.

-- 
Ezequiel Garc?a, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
