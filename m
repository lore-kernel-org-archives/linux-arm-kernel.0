From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sat, 13 Sep 2014 10:08:01 +0200
Subject: [PATCH] clk: sunxi: add correct divider table for sun4i-apb0 clock
In-Reply-To: <1409985910-30737-1-git-send-email-wens@csie.org>
References: <1409985910-30737-1-git-send-email-wens@csie.org>
Message-ID: <20140913080801.GW31276@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Sep 06, 2014 at 02:45:10PM +0800, Chen-Yu Tsai wrote:
> The sun4i-apb0 clock, as found on all platforms using it, is a
> power-of-two-based divider clock, with a special divider of 2
> for value 0.
> 
> This was causing the clock framework to incorrectly calculate
> the clock rate for apb1 and related modules on sun6i and sun8i.
> On sun[4/5/7]i, u-boot SPL configures the divider with value 1
> for /2 divider, so no suprises there.
> 
> This patch adds a proper divider table for it, so the correct
> clock rate can be calculated.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Applied, thanks!

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140913/5859a864/attachment.sig>
