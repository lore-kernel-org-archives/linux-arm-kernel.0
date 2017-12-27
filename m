From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Wed, 27 Dec 2017 23:42:52 +0100
Subject: [PATCH net-next 5/6] arm64: dts: marvell: mcbin: enable the
 fourth network interface
In-Reply-To: <20171227222401.GT10595@n2100.armlinux.org.uk>
References: <20171227221446.18459-1-antoine.tenart@free-electrons.com>
 <20171227221446.18459-6-antoine.tenart@free-electrons.com>
 <20171227222401.GT10595@n2100.armlinux.org.uk>
Message-ID: <20171227224252.GB2626@kwain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

On Wed, Dec 27, 2017 at 10:24:01PM +0000, Russell King - ARM Linux wrote:
> On Wed, Dec 27, 2017 at 11:14:45PM +0100, Antoine Tenart wrote:
> >  
> > +&cps_eth2 {
> > +	/* CPS Lane 5 */
> > +	status = "okay";
> > +	phy-mode = "2500base-x";
> > +	/* Generic PHY, providing serdes lanes */
> > +	phys = <&cps_comphy5 2>;
> > +};
> > +
> 
> This is wrong.  This lane is connected to a SFP cage which can support
> more than just 2500base-X.  Tying it in this way to 2500base-X means
> that this port does not support conenctions at 1000base-X, despite
> that's one of the most popular and more standardised speeds.

What do you suggest to describe this in the dt, to enable a port using
the current PPv2 driver?

Antoine

-- 
Antoine T?nart, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
