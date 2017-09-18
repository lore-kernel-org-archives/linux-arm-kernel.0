From: andrew@lunn.ch (Andrew Lunn)
Date: Mon, 18 Sep 2017 15:04:37 +0200
Subject: [PATCH 5/9] arm64: dts: marvell: mcbin: add comphy references to
 Ethernet ports
In-Reply-To: <20170918085012.knvnwgouhtjyychn@sapphire.tkos.co.il>
References: <20170918075814.27405-1-antoine.tenart@free-electrons.com>
 <20170918075814.27405-6-antoine.tenart@free-electrons.com>
 <20170918085012.knvnwgouhtjyychn@sapphire.tkos.co.il>
Message-ID: <20170918130437.GA12118@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 18, 2017 at 11:50:12AM +0300, Baruch Siach wrote:
> Hi Antoine,
> 
> On Mon, Sep 18, 2017 at 09:58:10AM +0200, Antoine Tenart wrote:
> > This patch adds comphy phandles to the Ethernet ports in the mcbin
> > device tree. The comphy is used to configure the serdes PHYs used by
> > these ports.
> > 
> > Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>
> > ---
> >  arch/arm64/boot/dts/marvell/armada-8040-mcbin.dts | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/marvell/armada-8040-mcbin.dts b/arch/arm64/boot/dts/marvell/armada-8040-mcbin.dts
> > index acf5c7d16d79..9a3b4a1fd445 100644
> > --- a/arch/arm64/boot/dts/marvell/armada-8040-mcbin.dts
> > +++ b/arch/arm64/boot/dts/marvell/armada-8040-mcbin.dts
> > @@ -223,6 +223,7 @@
> >  &cpm_eth0 {
> >  	status = "okay";
> >  	phy = <&phy0>;
> > +	phys = <&cpm_comphy4 0>;
> >  	phy-mode = "10gbase-kr";
> 
> Since the 'phys' generic PHY property is unrelated to the 'phy*' Ethernet PHY 
> properties that surround it, its location might be confusing. I think it 
> should appear below those two other properties like you did below ...

Hi Baruch, Antoine

Yes, i agree. It is confusing enough as it is, so we should not make
it worse.

I even wonder if it is worth doing some renaming?

  	phy = <&ethernet_phy0>;
  	phy-mode = "10gbase-kr";
 	phys = <&cpm_generic_comphy4 0>;

	Andrew
