From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 26 Jul 2016 10:56:51 +0200
Subject: [PATCH resend 1/9] clk: sunxi-ng: Fix inverted test condition in
 ccu_helper_wait_for_lock
In-Reply-To: <1469516671-19377-2-git-send-email-wens@csie.org>
References: <1469516671-19377-1-git-send-email-wens@csie.org>
 <1469516671-19377-2-git-send-email-wens@csie.org>
Message-ID: <20160726085651.GB7190@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 26, 2016 at 03:04:23PM +0800, Chen-Yu Tsai wrote:
> The condition passed to read*_poll_timeout() is the break condition,
> i.e. wait for this condition to happen and return success.
> 
> The original code assumed the opposite, resulting in a warning when
> the PLL clock rate was changed but never lost it's lock as far as
> the readout indicated. This was verified by checking the read out
> register value.
> 
> Fixes: 1d80c14248d6 ("clk: sunxi-ng: Add common infrastructure")
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Applied, thanks

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160726/c68867a5/attachment.sig>
