From: robh@kernel.org (Rob Herring)
Date: Thu, 5 Oct 2017 17:09:27 -0500
Subject: [PATCH v6 11/11] of: mdio: Prevent of_mdiobus_register from
 scanning mdio-mux nodes
In-Reply-To: <c8697b60-294f-7cc1-8425-aa5b837fcca0@gmail.com>
References: <20170927073414.17361-1-clabbe.montjoie@gmail.com>
 <20170927073414.17361-12-clabbe.montjoie@gmail.com>
 <20170927141213.GF13516@lunn.ch>
 <c8697b60-294f-7cc1-8425-aa5b837fcca0@gmail.com>
Message-ID: <20171005220927.7rabn3ftvow253xj@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 27, 2017 at 09:50:46PM -0700, Florian Fainelli wrote:
> 
> 
> On 09/27/2017 07:12 AM, Andrew Lunn wrote:
> > On Wed, Sep 27, 2017 at 09:34:14AM +0200, Corentin Labbe wrote:
> >> Each child node of an MDIO node is scanned as a PHY when calling
> >> of_mdiobus_register() givint the following result:
> >> [   18.175379] mdio_bus stmmac-0: /soc/ethernet at 1c30000/mdio/mdio-mux has invalid PHY address
> >> [   18.175408] mdio_bus stmmac-0: scan phy mdio-mux at address 0
> >> [   18.175450] mdio_bus stmmac-0: scan phy mdio-mux at address 1
> >> [...]
> >> [   18.176420] mdio_bus stmmac-0: scan phy mdio-mux at address 30
> >> [   18.176452] mdio_bus stmmac-0: scan phy mdio-mux at address 31
> >>
> >> Since mdio-mux nodes are not PHY, this patch a way to to not scan
> >> them.
> > 
> > Hi Corentin
> > 
> > I still don't like this, but ...
> 
> Me neither, even more so as I don't understand the reasoning behind
> putting the mux as a child node of the MDIO bus controller in the first
> place.

If no one agrees with me, then you shouldn't just accept my answers. I'm 
not always right.

Looking at this some more, why can't mdio-mux-mmio be used? Then there 
is nothing to review or discuss. If you want to extend that then make it 
clear this is just extending/inheriting already defined bindings.

That being said, if we were starting over I would probably do mux 
designs differently with DT hierarchy reflecting the mux hierarchy, but 
that ship has sailed.

Rob
