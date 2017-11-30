From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Thu, 30 Nov 2017 18:15:20 +0000
Subject: [PATCH 1/1] phy: Add 2.5G SGMII interface mode
In-Reply-To: <20171130174127.GA28828@lunn.ch>
References: <1512016235-15909-1-git-send-email-Bhaskar.Upadhaya@nxp.com>
 <20171130155050.GD7483@lunn.ch>
 <AM3PR04MB4494050122E413E2445BD348C380@AM3PR04MB449.eurprd04.prod.outlook.com>
 <20171130174127.GA28828@lunn.ch>
Message-ID: <20171130181520.GF10595@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 30, 2017 at 06:41:27PM +0100, Andrew Lunn wrote:
> SGMII supports passing auto-negotiation results from the PHY to the
> MAC. 1000BASE-X does not.
> 
> SGMII supports the PHY running at 10, 100, and 1000 Mbps. But to
> support this, the MAC needs to replicate the bits 100, or 10 times
> when the PHY is running in 10 or 100Mbps mode.
> 
> So with your 2.5G SGMII, you need to replicate the bits 250, 25, or
> 2.5 times if they PHY is running at lower speeds. This last one is
> interesting.

That's not what I've read so far - but I don't know about the PHY
in this exact case because the docs are only available under NDA
(which makes it incredibly difficult to have this discussion.)

However, from what I can ascertain from a Xilinx document, 2.5G is
1G SGMII clocked 2.5x faster.  When in 2.5G mode, the other modes
are unavailable.  There's also no 250M or 25M as the speed bits
are not relevant.

The Xilinx doc does talk about a "2.5G SGMII standard" but I haven't
been able to locate such a thing - maybe someone can provide some
pointers?

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
