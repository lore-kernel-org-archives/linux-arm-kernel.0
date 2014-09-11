From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 11 Sep 2014 22:38:25 +0200
Subject: [PATCH 2/7] clk: sunxi: Fix PLL6 calculation on sun6i
In-Reply-To: <1410000448-9999-3-git-send-email-wens@csie.org>
References: <1410000448-9999-1-git-send-email-wens@csie.org>
 <1410000448-9999-3-git-send-email-wens@csie.org>
Message-ID: <20140911203825.GL31276@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Sep 06, 2014 at 06:47:23PM +0800, Chen-Yu Tsai wrote:
> The N factor for PLL6 counts from 1 to 32, as specified in the A23
> manual, and shown in Allwinner's original A31 code.
> 
> Also the PLL6 factors alone calculate the clock rate for PLL6x2, not
> the normal halved output for PLL6. This is what the factors clk
> .recalc_rate callback expects.
> 
> This patch fixes the N factor in the clock driver, and adds a post
> PLL divider of 2 to calculate the rate for PLL6.
> 
> A further patch (to the DT) should add a fixed-factor x2 clock as
> the PLL6x2 output.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Thanks!
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140911/3f493df6/attachment.sig>
