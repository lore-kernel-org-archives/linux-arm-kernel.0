From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 21 Nov 2016 14:06:29 +0100
Subject: [PATCH] clk: sunxi-ng: sun6i-a31: Enable PLL-MIPI LDOs when
 ungating it
In-Reply-To: <20161118071557.30195-1-wens@csie.org>
References: <20161118071557.30195-1-wens@csie.org>
Message-ID: <20161121130629.2qp6tvdd5slvl5m6@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 18, 2016 at 03:15:57PM +0800, Chen-Yu Tsai wrote:
> The PLL-MIPI clock is somewhat special as it has its own LDOs which
> need to be turned on for this PLL to actually work and output a clock
> signal.
> 
> Add the 2 LDO enable bits to the gate bits. This fixes issues with
> the TCON not sending vblank interrupts when the tcon and dot clock are
> indirectly clocked from the PLL-MIPI clock.
> 
> Fixes: c6e6c96d8fa6 ("clk: sunxi-ng: Add A31/A31s clocks")
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Applied, thanks!
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161121/9c40b2a4/attachment.sig>
