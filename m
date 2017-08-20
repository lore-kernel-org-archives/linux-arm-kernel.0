From: clabbe.montjoie@gmail.com (Corentin Labbe)
Date: Sun, 20 Aug 2017 08:57:57 +0200
Subject: [PATCH v3 3/4] net: stmmac: register parent MDIO node for
 sun8i-h3-emac
In-Reply-To: <20170819203836.GA21567@lunn.ch>
References: <20170818122118.4925-1-clabbe.montjoie@gmail.com>
 <20170818122118.4925-4-clabbe.montjoie@gmail.com>
 <CAGb2v66KcZkiDDHryMmVzm4WroXePPy3V44SLpVdoO3ZEjgC=g@mail.gmail.com>
 <20170819185025.GB13266@Red> <20170819203836.GA21567@lunn.ch>
Message-ID: <20170820065757.GA6081@Red>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Aug 19, 2017 at 10:38:36PM +0200, Andrew Lunn wrote:
> On Sat, Aug 19, 2017 at 08:50:25PM +0200, Corentin Labbe wrote:
> > On Sat, Aug 19, 2017 at 01:05:21AM +0800, Chen-Yu Tsai wrote:
> > > On Fri, Aug 18, 2017 at 8:21 PM, Corentin Labbe
> > > <clabbe.montjoie@gmail.com> wrote:
> > > > In case of a MDIO switch, the registered MDIO node should be
> > > > the parent of the PHY. Otherwise of_phy_connect will fail.
> 
> Hi Corentin
> 
> Sorry, I missed this patch series. Looking at patchwork...

That's my fault, I forgot to set you in recipient like in last send.

> 
> Can you represent the MDIO mux using 
> 
> Documentation/devicetree/bindings/net/mdio-mux-mmioreg.txt
> 
> It would be better if you could reuse existing infrastructure than
> invent something new.
> 

I think we cannot use mdio-mux-mmioreg since the register for doing the switch is in middle of the "System Control" and shared with other functions.
This is why we use a sycon/regmap for selecting the MDIO.

Regards
