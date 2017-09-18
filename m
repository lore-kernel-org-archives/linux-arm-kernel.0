From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Mon, 18 Sep 2017 11:44:51 +0200
Subject: [PATCH 5/9] arm64: dts: marvell: mcbin: add comphy references to
 Ethernet ports
In-Reply-To: <20170918085012.knvnwgouhtjyychn@sapphire.tkos.co.il>
References: <20170918075814.27405-1-antoine.tenart@free-electrons.com>
 <20170918075814.27405-6-antoine.tenart@free-electrons.com>
 <20170918085012.knvnwgouhtjyychn@sapphire.tkos.co.il>
Message-ID: <20170918094451.GB20017@kwain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Baruch,

On Mon, Sep 18, 2017 at 11:50:12AM +0300, Baruch Siach wrote:
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
> 
> >  };
> >  
> > @@ -258,6 +259,7 @@
> >  &cps_eth0 {
> >  	status = "okay";
> >  	phy = <&phy8>;
> > +	phys = <&cps_comphy4 0>;
> >  	phy-mode = "10gbase-kr";
> 
> ... not here ...
> 
> >  };
> >  
> > @@ -266,6 +268,7 @@
> >  	status = "okay";
> >  	phy = <&ge_phy>;
> >  	phy-mode = "sgmii";
> > +	phys = <&cps_comphy0 1>;
> 
> ... but here.

OK, I'll update.

Thanks,
Antoine

-- 
Antoine T?nart, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170918/ba16b8b7/attachment.sig>
