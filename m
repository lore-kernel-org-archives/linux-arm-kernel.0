From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sun, 16 Nov 2014 18:07:24 +0100
Subject: [PATCH v3 2/6] clk: sunxi: Implement A31 PLL6 as a divs clock
 for 2x output
In-Reply-To: <1415815715-31791-3-git-send-email-wens@csie.org>
References: <1415815715-31791-1-git-send-email-wens@csie.org>
 <1415815715-31791-3-git-send-email-wens@csie.org>
Message-ID: <20141116170724.GM6414@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 13, 2014 at 02:08:31AM +0800, Chen-Yu Tsai wrote:
> Some clock modules on the A31 use PLL6x2 as one of their inputs.
> This patch changes the PLL6 implementation for A31 to a divs clock,
> i.e. clock with multiple outputs that have different dividers.
> The first output will be the normal PLL6 output, and the second
> will be PLL6x2.
> 
> This patch fixes the PLL6 N factor in the clock driver, and removes
> any /2 dividers in the PLL6 factors clock part. The N factor counts
> from 1 to 32, mapping to values 0 to 31, as shown in the A31 manual.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Merged, thanks!
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141116/bdb7a54b/attachment.sig>
