From: andrew@lunn.ch (Andrew Lunn)
Date: Tue, 6 Jun 2017 14:10:25 +0200
Subject: [PATCH] arm64: dts: marvell: 8040-mcbin: Enable 1GB Ethernet
In-Reply-To: <3e387cee-0107-8c29-d99a-abd61bdef9c2@arm.com>
References: <20170605200107.7692-1-marc.zyngier@arm.com>
 <20170605211639.GB9339@lunn.ch>
 <3e387cee-0107-8c29-d99a-abd61bdef9c2@arm.com>
Message-ID: <20170606121025.GD18198@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 06, 2017 at 09:21:58AM +0100, Marc Zyngier wrote:
> Hi Andrew,
> 
> On 05/06/17 22:16, Andrew Lunn wrote:
> >> +&cps_eth1 {
> >> +	status = "okay";
> >> +	phy = <&phy0>;
> >> +	phy-mode = "sgmii";
> >> +};
> > 
> > Hi Marc
> > 
> > Documentation/devicetree/bindings/net/ethernet.txt says:
> > 
> > - phy-handle: phandle, specifies a reference to a node representing a PHY
> >   device; this property is described in ePAPR and so preferred;
> > - phy: the same as "phy-handle" property, not recommended for new bindings.
> 
> Happy to amend the patch, though armada-8040-db.dts is already using
> "phy" (and not "phy-handle"). Should that one be fixed as well in the
> name of consistency? Also,
> Documentation/devicetree/bindings/net/marvell-pp2.txt only mentions the
> "phy" property. If feels a bit odd not to at least recommend the new
> property in the binding documentation.

Ah. As Russell pointed out, parsing this property is done by the
driver, not a central helper. mvpp2 only supports phy, not phy-handle.
This is not a new binding, it has been around since the middle of
2014. So "phy" is O.K.

Sometime in the future, it would be nice to centralise the parsing of
this and phy-mode.

     Andrew
