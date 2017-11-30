From: andrew@lunn.ch (Andrew Lunn)
Date: Thu, 30 Nov 2017 18:41:27 +0100
Subject: [PATCH 1/1] phy: Add 2.5G SGMII interface mode
In-Reply-To: <AM3PR04MB4494050122E413E2445BD348C380@AM3PR04MB449.eurprd04.prod.outlook.com>
References: <1512016235-15909-1-git-send-email-Bhaskar.Upadhaya@nxp.com>
 <20171130155050.GD7483@lunn.ch>
 <AM3PR04MB4494050122E413E2445BD348C380@AM3PR04MB449.eurprd04.prod.outlook.com>
Message-ID: <20171130174127.GA28828@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> [bhaskar] 2.5G in general needs to operate with auto negotiation in
> disabled mode. Its 2.5G requirement and not specific to our system.

> My understanding is that one of the main differences between SGMII and 1000BASE-X is the negotiation.
> [Bhaskar] which of SGMII and 1000BASE-X support negotiation ?

SGMII supports passing auto-negotiation results from the PHY to the
MAC. 1000BASE-X does not.

SGMII supports the PHY running at 10, 100, and 1000 Mbps. But to
support this, the MAC needs to replicate the bits 100, or 10 times
when the PHY is running in 10 or 100Mbps mode.

So with your 2.5G SGMII, you need to replicate the bits 250, 25, or
2.5 times if they PHY is running at lower speeds. This last one is
interesting.

	Andrew
