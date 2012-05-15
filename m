From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 15 May 2012 22:00:40 +0200
Subject: [PATCH] clk: Fix race conditions between clk_set_parent() and
 clk_enable()
In-Reply-To: <4FB2B3AA.3010903@codeaurora.org>
References: <1336798797-8724-1-git-send-email-skannan@codeaurora.org>
 <20120515194245.GO30400@pengutronix.de>
 <4FB2B3AA.3010903@codeaurora.org>
Message-ID: <20120515200040.GP30400@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 15, 2012 at 12:51:06PM -0700, Saravana Kannan wrote:
> >>  	ret = clk->ops->set_parent(clk->hw, i);
> >
> >You call ->set_parent while holding a spinlock. This won't work with i2c
> >clocks.
> 
> I did account for that. I explained it in the commit text. Please
> let me know if any part of that is not clear or is not correct.
>

I missed this part in the commit log. I have no idea whether we can live
with this limitation though.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
