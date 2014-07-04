From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 4 Jul 2014 09:03:55 +0200
Subject: [PATCH] pinctrl: sunxi: Fix multi bank interrupt support in
 gpio_to_irq
In-Reply-To: <1404144299-740-1-git-send-email-wens@csie.org>
References: <1404144299-740-1-git-send-email-wens@csie.org>
Message-ID: <20140704070355.GI31996@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Jul 01, 2014 at 12:04:59AM +0800, Chen-Yu Tsai wrote:
> When mapping the interrupts, the gpio_to_irq function did not consider
> the bank number of the gpio pin in question, only the offset or the
> interrupt number in the bank. As a result, requests for interrupts in
> the later banks get mapped to the first bank.
> 
> This issue was discovered while enabling mmc on the new sun8i platform.
> The tablet I have uses a pin/interrupt from the second bank to do mmc
> card detection. Tested on this very device with register inspection and
> actual mmc card insertion/removal.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Linus, could this be merged as a fix for 3.16?

Thanks,
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140704/94b1554b/attachment-0001.sig>
