From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Mon, 9 Apr 2018 12:17:33 +0100
Subject: [PATCH 0/5] Add tda998x (HDMI) support to atmel-hlcdc
In-Reply-To: <20180409105918.20792-1-peda@axentia.se>
References: <20180409105918.20792-1-peda@axentia.se>
Message-ID: <20180409111733.GP16141@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 09, 2018 at 12:59:13PM +0200, Peter Rosin wrote:
> During this, I found that the tda998x driver never sets the format in
> the connector display_info. Thus, the atmel-hlcdc driver fails to select
> output format. Since I had similar problems with ds90c185 lvds encoder
> I added patches to override the atmel-hlcdc output format via a DT
> property and things start to play together.

That sounds like a hack.  The tda998x driver doesn't set the format
because it pre-dates the addition of this information in the display
info structure, and none of its current users require that information.

As you're the first to require it, rather than working around the
driver by adding stuff to DT, it would be much better to improve the
driver by adding this information.

Thanks.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
