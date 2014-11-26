From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 26 Nov 2014 19:35:39 +0100
Subject: [PATCH resend v4 0/3] clk: sun6i: Unify AHB1 clock and fix rate
 calculation
In-Reply-To: <1416986214-4861-1-git-send-email-wens@csie.org>
References: <1416986214-4861-1-git-send-email-wens@csie.org>
Message-ID: <20141126183539.GI25249@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 26, 2014 at 03:16:51PM +0800, Chen-Yu Tsai wrote:
> Hi everyone,
> 
> This is a resend of v4 of the sun6i AHB1 clock unification series.
> This includes only the 3 patches not yet merged.
> 
> This series unifies the mux and divider parts of the AHB1 clock found
> on sun6i and sun8i, while also adding support for the pre-divider on the
> PLL6 input.
> 
> The rate calculation logic must factor in which parent it is using to
> calculate the rate, to decide whether to use the pre-divider or not.
> This is beyond the original factors clk design in sunxi. To avoid
> feature bloat, this is implemented as a separate composite clk.
> 
> The new clock driver is registered with a separate OF_CLK_DECLARE.
> As it shares its register with the APB1 div clock, thus shares the same
> spinlock, it cannot reside in a separate file.

Queued this for 3.20, thanks!
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141126/ed6b736f/attachment.sig>
