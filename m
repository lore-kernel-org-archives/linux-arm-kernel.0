From: andrew@lunn.ch (Andrew Lunn)
Date: Mon, 19 Mar 2018 14:23:11 +0100
Subject: [EXT] Re: [PATCH net-next 02/10] net: phy: phylink: allow 10GKR
 interface to use in-band negotiation
In-Reply-To: <02614799e30f4823a97fca0e9f29b14b@IL-EXCH01.marvell.com>
References: <20180316103351.16616-1-antoine.tenart@bootlin.com>
 <20180316103351.16616-3-antoine.tenart@bootlin.com>
 <20180316155307.GQ9418@n2100.armlinux.org.uk>
 <20180319085252.GF4519@kwain>
 <20180319111205.GB2743@n2100.armlinux.org.uk>
 <20180319125227.GI4519@kwain> <20180319125953.GD19795@lunn.ch>
 <54e290a192734831b5db22191f056a81@IL-EXCH01.marvell.com>
 <20180319130823.GA22306@lunn.ch>
 <02614799e30f4823a97fca0e9f29b14b@IL-EXCH01.marvell.com>
Message-ID: <20180319132311.GA26039@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> phylink pool SFP loss signal to determine link up/down?

Yes, the SFP driver will act on a GPIO for link up/down, and a GPIO
for module prescience. When it detects an SFP module hotplugged, it
reads the EEPROM to find out what sort of module it is, and what mode
should be used between the MAC and SFP module. It will also handle if
the SFP module is copper, and has a PHY in it...

       Andrew
