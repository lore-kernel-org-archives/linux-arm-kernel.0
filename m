From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 26 Jan 2016 11:37:08 +0000
Subject: [PATCH 2/6] mtd: physmap_of: add a hook for Versatile write
 protection
In-Reply-To: <1453806725-4880-3-git-send-email-linus.walleij@linaro.org>
References: <1453806725-4880-1-git-send-email-linus.walleij@linaro.org>
 <1453806725-4880-3-git-send-email-linus.walleij@linaro.org>
Message-ID: <20160126113707.GL10826@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 26, 2016 at 12:12:01PM +0100, Linus Walleij wrote:
> Solve this by looking for the arm,versatile-flash compatible
> string in the flash device tree node. In the driver,
> add a special hook to check for the various Versatile syscons and
> register a callback for .set_vpp() if this compatible is present.

You are aware that the "write enable" applies to all flash devices
on the board, and not just NOR flash.  What that means is if you
have drivers for the other flash devices, you need to have a way
to enable writes when _any_ driver wants write access.

So, it shouldn't be part of the flash driver at all.

-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
