From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Tue, 18 Jun 2013 19:09:30 -0300
Subject: [PATCH v3 10/12] ARM: mvebu: Relocate Armada 370/XP DeviceBus
 device tree nodes
In-Reply-To: <201306181816.26530.arnd@arndb.de>
References: <1371554737-25319-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1371554737-25319-11-git-send-email-ezequiel.garcia@free-electrons.com>
 <201306181816.26530.arnd@arndb.de>
Message-ID: <20130618220929.GA24056@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 18, 2013 at 06:16:26PM +0200, Arnd Bergmann wrote:
> On Tuesday 18 June 2013, Ezequiel Garcia wrote:
> > 
> > +               devbus-bootcs {
> > +                       compatible = "marvell,mvebu-devbus";
> > +                       reg = <0xffff0001 0x10400 0x8>;
> > +                       ranges = <0 MBUS_ID(0x01, 0x2f) 0 0xffffffff>;
> > +                       #address-cells = <1>;
> > +                       #size-cells = <1>;
> > +                       clocks = <&coreclk 0>;
> > +                       status = "disabled";
> > +               };
> 
> This is a violation of the binding as far as I can tell, since you don't specify ranges
> to access the 0xffff0001 0x10400 address. However, as I explained in my comment for
> the binding, I think you should clarify the binding and leave the implementation
> as you have it here.
> 

Mmm... again I got lost here. Which 'ranges' you say I don't specify to
access the (formerly) 0xffff0001?

AFAIK, 'ranges' are only for children translation, which means I don't
need to specify a ranges for that in the devbus node, but in its parent,
right?

This ranges thing can be very tricky, so please correct me if I'm
mistaken.

-- 
Ezequiel Garc?a, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
