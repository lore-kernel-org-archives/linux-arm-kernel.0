From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 14 Feb 2017 10:34:38 +0100
Subject: [PATCH 1/5] clk: sunxi-ng: mp: Adjust parent rate for pre-dividers
In-Reply-To: <20170214033526.16977-2-wens@csie.org>
References: <20170214033526.16977-1-wens@csie.org>
 <20170214033526.16977-2-wens@csie.org>
Message-ID: <20170214093438.4v6ykhqrstnkvzl6@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 14, 2017 at 11:35:22AM +0800, Chen-Yu Tsai wrote:
> The MP style clocks support an mux with pre-dividers. While the driver
> correctly accounted for them in the .determine_rate callback, it did
> not in the .recalc_rate and .set_rate callbacks.
> 
> This means when calculating the factors in the .set_rate callback, they
> would be off by a factor of the active pre-divider. Same goes for
> reading back the clock rate after it is set.
> 
> Fixes: 2ab836db5097 ("clk: sunxi-ng: Add M-P factor clock support")
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---
> 
> Maybe we want to Cc stable for this one?

I've applied it and added the Cc.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170214/1643bd2a/attachment.sig>
