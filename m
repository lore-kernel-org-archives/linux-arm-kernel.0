From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Wed, 18 Jul 2018 14:02:28 +0100
Subject: [PATCH] clk: Add functions to get optional clocks
In-Reply-To: <1531918658-32278-1-git-send-email-phil.edworthy@renesas.com>
References: <1531918658-32278-1-git-send-email-phil.edworthy@renesas.com>
Message-ID: <20180718130228.GG17271@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 18, 2018 at 01:57:38PM +0100, Phil Edworthy wrote:
> Behaves the same as (devm_)clk_get except where there is no clock
> producer. In this case, instead of returning -ENOENT, the function
> returns NULL. This makes error checking simpler and allows
> clk_prepare_enable, etc to be called on the returned reference
> without additional checks.

How does this work with non-DT systems, where looking a clock up which
isn't yet registered with clkdev returns -ENOENT ?

(clkdev doesn't know when all clocks are registered with it.)

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 13.8Mbps down 630kbps up
According to speedtest.net: 13Mbps down 490kbps up
