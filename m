From: andrew@lunn.ch (Andrew Lunn)
Date: Sat, 19 Aug 2017 22:38:36 +0200
Subject: [PATCH v3 3/4] net: stmmac: register parent MDIO node for
 sun8i-h3-emac
In-Reply-To: <20170819185025.GB13266@Red>
References: <20170818122118.4925-1-clabbe.montjoie@gmail.com>
 <20170818122118.4925-4-clabbe.montjoie@gmail.com>
 <CAGb2v66KcZkiDDHryMmVzm4WroXePPy3V44SLpVdoO3ZEjgC=g@mail.gmail.com>
 <20170819185025.GB13266@Red>
Message-ID: <20170819203836.GA21567@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Aug 19, 2017 at 08:50:25PM +0200, Corentin Labbe wrote:
> On Sat, Aug 19, 2017 at 01:05:21AM +0800, Chen-Yu Tsai wrote:
> > On Fri, Aug 18, 2017 at 8:21 PM, Corentin Labbe
> > <clabbe.montjoie@gmail.com> wrote:
> > > In case of a MDIO switch, the registered MDIO node should be
> > > the parent of the PHY. Otherwise of_phy_connect will fail.

Hi Corentin

Sorry, I missed this patch series. Looking at patchwork...

Can you represent the MDIO mux using 

Documentation/devicetree/bindings/net/mdio-mux-mmioreg.txt

It would be better if you could reuse existing infrastructure than
invent something new.

   Andrew
