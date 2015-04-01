From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 1 Apr 2015 11:27:51 +0100
Subject: [PATCH RFC v2 04/12] drm/components: add generic vga encoder
 driver
In-Reply-To: <1427882986-19110-5-git-send-email-heiko@sntech.de>
References: <1427882986-19110-1-git-send-email-heiko@sntech.de>
 <1427882986-19110-5-git-send-email-heiko@sntech.de>
Message-ID: <20150401102751.GZ24899@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 01, 2015 at 12:09:38PM +0200, Heiko Stuebner wrote:
> This adds a driver for generic vga encoders like the Analog Devices adv7123
> and similar ics. These chips do not have any special configuration options
> except a powersafe gpio.
> 
> An exception is added for the rcar-du driver which also implements support
> for the adv7123 internally but is not yet converted to the component framework.

Why is this implemented as a master?  It's not the top level card device,
it shouldn't be a master.  It should be a component.

I wonder if this is why you need your previous patches.  Componentised
DRM works fine without needing to build lists of connectors and encoders.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
