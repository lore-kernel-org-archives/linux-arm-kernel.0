From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 24 Aug 2017 10:50:35 +0200
Subject: [PATCH] clk: sunxi: fix uninitialized access
In-Reply-To: <20170823143937.2176025-1-arnd@arndb.de>
References: <20170823143937.2176025-1-arnd@arndb.de>
Message-ID: <20170824085035.uznlemp5dzpts5ms@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 23, 2017 at 04:39:27PM +0200, Arnd Bergmann wrote:
> gcc-8 reports an uninitialized variable access in a code path
> that we would see with incorrect DTB input:
> 
> drivers/clk/sunxi/clk-sun8i-bus-gates.c: In function 'sun8i_h3_bus_gates_init':
> drivers/clk/sunxi/clk-sun8i-bus-gates.c:85:27: error: 'clk_parent' may be used uninitialized in this function [-Werror=maybe-uninitialized]
> 
> This works around by skipping invalid input and printing a warning
> instead if it ever happens. The problem was apparently part of the
> initiali driver submission, but older compilers don't notice it.
> 
> Fixes: ab6e23a4e388 ("clk: sunxi: Add H3 clocks support")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

That's weird it stayed for that long without any compiler noticing.

Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Mike, Stephen, can you pick it up as a fix? We don't have anything
else coming your way.

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170824/ab1db200/attachment.sig>
