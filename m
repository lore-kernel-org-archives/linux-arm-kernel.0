From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 13 Aug 2014 19:24:35 +0100
Subject: PL310 cache initialization/fixup for BCM63138
In-Reply-To: <53EBA9CF.4030902@gmail.com>
References: <53EBA9CF.4030902@gmail.com>
Message-ID: <20140813182435.GM30401@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 13, 2014 at 11:09:19AM -0700, Florian Fainelli wrote:
> Hi Russell, Arnd,
> 
> The PL310 cache present on BCM63138 comes up with wrong values out of
> reset in particular, I need to at least override the way-size to be
> 32KiB otherwise.
> 
> Right now, I am overriding the auxiliary control register by supplying a
> non 0xffffffff aux_ctrl_mask to l2x0_of_init().
> 
> Should I rather use a separate compatible string for it and perform the
> "fixup" in a separate of_parse() callback, or in a separate fixup()
> callback?
> 
> Or is it recommended to keep overriding the aux_ctrl_mask as part of the
> call to l2x0_of_init()?

The correct answer is to research how to specify cache attributes in DT,
and create an appropriate set of properties described by that, and have
the l2x0 OF init code parse those, and create the appropriate aux control
register values from those.

I forget exactly what they are, but I do know that there is a standardised
set of DT properties to describe the geometry of caches - I came across
them about six months back when I worked on the L2 code.

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
