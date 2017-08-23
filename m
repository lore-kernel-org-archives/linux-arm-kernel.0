From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Wed, 23 Aug 2017 10:11:12 +0200
Subject: [PATCH net-next v2 10/10] arm64: dts: marvell: mcbin: enable
 more networking ports
In-Reply-To: <20170823072842.ibk6gqtswhamvppy@sapphire.tkos.co.il>
References: <20170822170830.32413-1-antoine.tenart@free-electrons.com>
 <20170822170830.32413-11-antoine.tenart@free-electrons.com>
 <20170823072842.ibk6gqtswhamvppy@sapphire.tkos.co.il>
Message-ID: <20170823081112.GC5202@kwain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Baruch,

On Wed, Aug 23, 2017 at 10:28:42AM +0300, Baruch Siach wrote:
> On Tue, Aug 22, 2017 at 07:08:30PM +0200, Antoine Tenart wrote:
> > This patch enables the two GE/SFP ports. They are configured in 10GKR
> > mode by default. To do this the cpm_xdmio is enabled as well, and two
> > phy descriptions are added.
> > 
> > Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>
> > Tested-by: Marcin Wojtas <mw@semihalf.com>
> > ---
> >  arch/arm64/boot/dts/marvell/armada-8040-mcbin.dts | 30 +++++++++++++++++++++++
> >  1 file changed, 30 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/marvell/armada-8040-mcbin.dts b/arch/arm64/boot/dts/marvell/armada-8040-mcbin.dts
> > index abd39d1c1739..6cb4b000e1ac 100644
> > --- a/arch/arm64/boot/dts/marvell/armada-8040-mcbin.dts
> > +++ b/arch/arm64/boot/dts/marvell/armada-8040-mcbin.dts
> > @@ -127,6 +127,30 @@
> >  	};
> >  };
> >  
> > +&cpm_xmdio {
> > +	status = "okay";
> > +
> > +	phy0: ethernet-phy at 0 {
> > +		compatible = "ethernet-phy-ieee802.3-c45";
> > +		reg = <0>;
> > +	};
> > +
> > +	phy1: ethernet-phy at 1 {
> 
> Should be named 'ethernet-phy at 8' to match the 'reg' property.

That's right.

Thanks!
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170823/a5c64539/attachment.sig>
