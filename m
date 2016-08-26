From: andrew@lunn.ch (Andrew Lunn)
Date: Fri, 26 Aug 2016 17:05:09 +0200
Subject: [PATCH 8/8] arm: orion5x: Configure WNR854T ethernet PHY LEDs
In-Reply-To: <1472203264-21089-9-git-send-email-jm@lentin.co.uk>
References: <1468679348-10522-1-git-send-email-jm@lentin.co.uk>
 <1472203264-21089-1-git-send-email-jm@lentin.co.uk>
 <1472203264-21089-9-git-send-email-jm@lentin.co.uk>
Message-ID: <20160826150509.GM25046@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 26, 2016 at 10:21:04AM +0100, Jamie Lentin wrote:
> The default PHY configuration disables most of the LEDs. The following
> configures the ethernet activity LEDs as Netgear intended.
> 
> Signed-off-by: Jamie Lentin <jm@lentin.co.uk>
> ---
> Andrew, note that the slave mdio bus is called "mdio", however there is
> an example in bindings/net/dsa/dsa.txt using "mdio-bus". Is this a
> mismatch to fix?

Hi Jamie

Yes, the documentation should match reality.

Unfortunately, there is a bit of a mess here. Different drivers have
different names for this node in device tree. And since device tree is
supposed to be stable, we cannot change them all to be the same.

I did intend to write some documentation defining what best practices
are for mdio busses, but never got around to it.

    Andrew
