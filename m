From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 9 Nov 2015 17:31:30 +0000
Subject: [PATCH] mvneta: add FIXED_PHY dependency
In-Reply-To: <4827390.CWKT8ytt79@wuerfel>
References: <4225885.EYXTHjRPmX@wuerfel> <6910088.dNmooXDTJR@wuerfel>
 <20151109170834.GE8644@n2100.arm.linux.org.uk>
 <4827390.CWKT8ytt79@wuerfel>
Message-ID: <20151109173130.GF8644@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 09, 2015 at 06:12:02PM +0100, Arnd Bergmann wrote:
> On Monday 09 November 2015 17:08:34 Russell King - ARM Linux wrote:
> > They are "optional" because when you're using a DSA switch, you don't
> > specify a PHY (because, there isn't one).  For example, this is what
> > I'm using with an Armada 388 board with a Marvell DSA switch.  The
> > DSA does not appear as a PHY, and no node in the DSA stanza can be
> > referenced for a phy entry in the ethernet device's stanza.
> > 
> >                         eth1: ethernet at 30000 {
> >                                 compatible = "marvell,armada-370-neta";
> >                                 reg = <0x30000 0x4000>;
> >                                 interrupts-extended = <&mpic 10>;
> >                                 clocks = <&gateclk 3>;
> >                                 managed = "in-band-status";
> >                                 phy-mode = "sgmii";
> >                                 status = "okay";
> >                         };
> > 
> > 
> 
> Ok, then it would be nice to change the binding to reflect that,
> and also document the "managed" property there.

"managed" is already documented.  See
Documentation/devicetree/bindings/net/ethernet.txt:

- managed: string, specifies the PHY management type. Supported values are:
  "auto", "in-band-status". "auto" is the default, it usess MDIO for
  management if fixed-link is not specified.

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
