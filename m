From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Tue, 23 Sep 2014 16:29:22 +0200
Subject: [PATCH v4 3/9] Documentation: bindings: net: add the Marvell
 PXA168 Ethernet controller
In-Reply-To: <20140923140113.GC18924@kwain>
References: <1411474536-22626-1-git-send-email-antoine.tenart@free-electrons.com>
 <1411474536-22626-4-git-send-email-antoine.tenart@free-electrons.com>
 <51745791.Wuu5QiQB2e@wuerfel> <20140923140113.GC18924@kwain>
Message-ID: <20140923142922.GE18924@kwain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 23, 2014 at 04:01:13PM +0200, Antoine Tenart wrote:
> Arnd,
> 
> On Tue, Sep 23, 2014 at 02:38:39PM +0200, Arnd Bergmann wrote:
> > On Tuesday 23 September 2014 14:15:30 Antoine Tenart wrote:
> > > +Optional properties:
> > > +- port-id: should be '0','1' or '2'.
> > > +- phy-addr: MDIO address of the PHY.
> > > +- local-mac-address: see ethernet.txt file in the same directory.
> > > +
> > > 
> > 
> > I believe new bindings should not use "phy-addr" properties, but
> > instead use a phy-handle property pointing to a phy device instead.
> 

So I had a look on other Ethernet bindings. Would you agree with
something like the following?

	eth0: ethernet at f7b90000 {
		...
		#address-cells = <1>;
		#size-cells = <0>;
		phy-handle = <&ethphy0>;

		ethphy0: ethernet-phy at 0 {
			reg = <0>;
		};
	};

Antoine

-- 
Antoine T?nart, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
