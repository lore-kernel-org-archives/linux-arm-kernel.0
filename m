From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 20 Mar 2017 10:33:55 +0100
Subject: [PATCH] clk: sunxi-ng: fix recalc_rate formula of NKMP clocks
In-Reply-To: <20170317201943.45190-1-icenowy@aosc.xyz>
References: <20170317201943.45190-1-icenowy@aosc.xyz>
Message-ID: <20170320093355.wougjul675q3hru7@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Mar 18, 2017 at 04:19:43AM +0800, Icenowy Zheng wrote:
> In commit e66f81bbd746 ("clk: sunxi-ng: Implement factors offsets"), the
> final formula of NKMP clocks' recalc_rate is refactored; however, the
> refactored formula broke the calculation due to some C language operand
> priority problem -- the priority of operand >> is lower than * and /,
> makes the formula being parsed as "(parent_rate * n * k) >> (p / m)", but
> it should be "(parent_rate * n * k >> p) / m".
> 
> Add the pair of parentheses to fix up this issue. This pair of
> parentheses used to exist in the old formula.
> 
> Fixes: commit e66f81bbd746 ("clk: sunxi-ng: Implement factors offsets")

You shouldn't have commit here.

> Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>

Fixed it, and applied, thanks!
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170320/5741ef4a/attachment.sig>
