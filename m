From: andrew@lunn.ch (Andrew Lunn)
Date: Thu, 21 Dec 2017 10:06:26 +0100
Subject: [PATCH 4/4] ARM: dts: vf610-zii-dev-rev-b: add interrupts for
 88e1545 PHY
In-Reply-To: <E1eRnWr-0006VS-1m@rmk-PC.armlinux.org.uk>
References: <20171220231108.GJ10595@n2100.armlinux.org.uk>
 <E1eRnWr-0006VS-1m@rmk-PC.armlinux.org.uk>
Message-ID: <20171221090626.GC6683@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 20, 2017 at 11:12:01PM +0000, Russell King wrote:
> The 88e1545 PHY has its interrupts wired to the VF610, so we might as
> well use them.
> 
> Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
> ---
> This is certainly not correct, as all PHYs on this device share the
> same interrupt line, but we can't specify the pinmux settings
> individually on each PHY.  How should this be handled?

Hi Russell

You could put it as a hog on the gpio controller node.  However, i
don't think that is much better.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
