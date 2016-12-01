From: eric@anholt.net (Eric Anholt)
Date: Thu, 01 Dec 2016 12:46:23 -0800
Subject: [PATCH] clk: bcm2835: Avoid overwriting the div info when
 disabling a pll_div clk
In-Reply-To: <1480620441-5442-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1480620441-5442-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <87shq7fkdc.fsf@eliezer.anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Boris Brezillon <boris.brezillon@free-electrons.com> writes:

> bcm2835_pll_divider_off() is resetting the divider field in the A2W reg
> to zero when disabling the clock.
>
> Make sure we preserve this value by reading the previous a2w_reg value
> first and ORing the result with A2W_PLL_CHANNEL_DISABLE.
>
> Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> Fixes: 41691b8862e2 ("clk: bcm2835: Add support for programming the audio domain clocks")
> Cc: <stable@vger.kernel.org>

Reviewed-by: Eric Anholt <eric@anholt.net>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 832 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161201/9182a06b/attachment.sig>
