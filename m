From: andrew@lunn.ch (Andrew Lunn)
Date: Mon, 1 May 2017 18:10:30 +0200
Subject: [PATCH v5 00/20] net-next: stmmac: add dwmac-sun8i ethernet driver
In-Reply-To: <20170501155856.GA1957@Red>
References: <20170501124520.3769-1-clabbe.montjoie@gmail.com>
 <20170501140133.GD31281@lunn.ch>
 <CAGb2v67qGqswdz_JcDaD5jTkcvtBuzqqP8KZh=S_5pkp=o6cUQ@mail.gmail.com>
 <20170501144541.GB1285@lunn.ch> <20170501155856.GA1957@Red>
Message-ID: <20170501161030.GF1285@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > > > Does the internal PHY have a phy driver? It seems like
> > > > tx-delay-ps/rx-delay-ps are properties of this internal PHY, and so
> > > > should be in the phy driver, if it has one.
> > > 
> > > Nope. These affect the delay lines for the external PHY interface.
> 
> I will add some sentences in the documentation to be more clear about that.

Thanks

> 
> > 
> > Oh, yes. I understood the patch wrong.
> > 
> > None of the patches actually use these properties. Are they actually
> > needed? We should avoid adding vendor specific properties, if they are
> > not used.
> > 
> 
> The board that use it is the BananaPi M3, but the SoC A83T still lack clocks support.
> So theses properties is already used out of tree, and will be used in tree soon.

Fair enough.

Thanks
	Andrew
